import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/local_database.dart';

class PostService {
  final LocalDatabase _db = LocalDatabase.instance;

  /// Get current user's name from SharedPreferences
  Future<String> _getCurrentUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name') ?? 'User';
  }

  /// Get current user's profile picture path
  Future<String?> _getCurrentUserProfilePic() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_image_path');
  }

  /// Create a new post
  Future<int> createPost({
    required String mediaPath,
    required String mediaType,
    required String caption,
    required String privacy,
    String? thumbnailPath,
  }) async {
    final db = await _db.database;
    final userName = await _getCurrentUserName();
    final userProfilePic = await _getCurrentUserProfilePic();

    return await db.insert('ProgressPosts', {
      'userName': userName,
      'userProfilePic': userProfilePic,
      'mediaPath': mediaPath,
      'mediaType': mediaType,
      'caption': caption,
      'privacy': privacy,
      'likes': 0,
      'createdAt': DateTime.now().toIso8601String(),
      'thumbnailPath': thumbnailPath,
    });
  }

  /// Get all posts by current user
  Future<List<Map<String, dynamic>>> getMyPosts() async {
    final db = await _db.database;
    final userName = await _getCurrentUserName();
    
    return await db.query(
      'ProgressPosts',
      where: 'userName = ?',
      whereArgs: [userName],
      orderBy: 'createdAt DESC',
    );
  }

  /// Get all public posts
  Future<List<Map<String, dynamic>>> getPublicPosts() async {
    final db = await _db.database;
    
    return await db.query(
      'ProgressPosts',
      where: 'privacy = ?',
      whereArgs: ['public'],
      orderBy: 'createdAt DESC',
    );
  }

  /// Get all private posts (for "Gym Bros" feed)
  Future<List<Map<String, dynamic>>> getPrivatePosts() async {
    final db = await _db.database;
    
    return await db.query(
      'ProgressPosts',
      where: 'privacy = ?',
      whereArgs: ['private'],
      orderBy: 'createdAt DESC',
    );
  }

  /// Get all posts for influencer feed (public + private)
  Future<List<Map<String, dynamic>>> getAllFeedPosts() async {
    final db = await _db.database;
    
    return await db.query(
      'ProgressPosts',
      orderBy: 'createdAt DESC',
    );
  }

  /// Check if current user has liked a post
  Future<bool> hasLikedPost(int postId) async {
    final db = await _db.database;
    
    final result = await db.query(
      'PostLikes',
      where: 'postId = ?',
      whereArgs: [postId],
    );
    
    return result.isNotEmpty;
  }

  /// Like a post
  Future<void> likePost(int postId) async {
    final db = await _db.database;
    
    // Check if already liked
    final alreadyLiked = await hasLikedPost(postId);
    if (alreadyLiked) return;

    // Add like record
    await db.insert('PostLikes', {
      'postId': postId,
      'likedAt': DateTime.now().toIso8601String(),
    });

    // Increment like count
    await db.rawUpdate(
      'UPDATE ProgressPosts SET likes = likes + 1 WHERE id = ?',
      [postId],
    );
  }

  /// Unlike a post
  Future<void> unlikePost(int postId) async {
    final db = await _db.database;

    // Remove like record
    await db.delete(
      'PostLikes',
      where: 'postId = ?',
      whereArgs: [postId],
    );

    // Decrement like count
    await db.rawUpdate(
      'UPDATE ProgressPosts SET likes = CASE WHEN likes > 0 THEN likes - 1 ELSE 0 END WHERE id = ?',
      [postId],
    );
  }

  /// Toggle like on a post
  Future<void> toggleLike(int postId) async {
    final liked = await hasLikedPost(postId);
    if (liked) {
      await unlikePost(postId);
    } else {
      await likePost(postId);
    }
  }

  /// Delete a post and its media file
  Future<void> deletePost(int postId) async {
    final db = await _db.database;
    
    // Get post to delete media files
    final posts = await db.query(
      'ProgressPosts',
      where: 'id = ?',
      whereArgs: [postId],
    );

    if (posts.isNotEmpty) {
      final post = posts.first;
      
      // Delete media file
      final mediaPath = post['mediaPath'] as String?;
      if (mediaPath != null) {
        final mediaFile = File(mediaPath);
        if (await mediaFile.exists()) {
          await mediaFile.delete();
        }
      }

      // Delete thumbnail if exists
      final thumbnailPath = post['thumbnailPath'] as String?;
      if (thumbnailPath != null) {
        final thumbnailFile = File(thumbnailPath);
        if (await thumbnailFile.exists()) {
          await thumbnailFile.delete();
        }
      }
    }

    // Delete post from database (likes will be deleted automatically due to CASCADE)
    await db.delete(
      'ProgressPosts',
      where: 'id = ?',
      whereArgs: [postId],
    );
  }

  /// Save media file to app documents directory
  Future<String> saveMediaFile(File sourceFile, String mediaType) async {
    final appDir = await getApplicationDocumentsDirectory();
    final postsDir = Directory('${appDir.path}/posts');
    
    // Create posts directory if it doesn't exist
    if (!await postsDir.exists()) {
      await postsDir.create(recursive: true);
    }

    // Generate unique filename
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = path.extension(sourceFile.path);
    final fileName = '${mediaType}_$timestamp$extension';
    final savedPath = '${postsDir.path}/$fileName';

    // Copy file to app directory
    await sourceFile.copy(savedPath);
    
    return savedPath;
  }

  /// Generate video thumbnail (placeholder - would need video_thumbnail package)
  Future<String?> generateVideoThumbnail(String videoPath) async {
    // This is a placeholder. In a real implementation, you would use
    // the video_thumbnail package to generate an actual thumbnail.
    // For now, we'll return null and handle it in the UI
    return null;
  }
}
