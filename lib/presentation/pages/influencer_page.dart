import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:tiziappp2/technicals/services/post_service.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';
import 'package:intl/intl.dart';

class InfluencerPage extends StatefulWidget {
  const InfluencerPage({super.key});

  @override
  State<InfluencerPage> createState() => _InfluencerPageState();
}

class _InfluencerPageState extends State<InfluencerPage> with SingleTickerProviderStateMixin {
  final PostService _postService = PostService();
  late TabController _tabController;
  bool _isLoading = true;
  List<Map<String, dynamic>> _publicPosts = [];
  List<Map<String, dynamic>> _privatePosts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadPosts() async {
    setState(() => _isLoading = true);
    try {
      final public = await _postService.getPublicPosts();
      final private = await _postService.getPrivatePosts();
      
      if (mounted) {
        setState(() {
          _publicPosts = public;
          _privatePosts = private;
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading posts: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              _buildFeed(_publicPosts, "No public posts yet"),
              _buildFeed(_privatePosts, "No posts from your gym bros yet"),
            ],
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTabItem("Public", 0),
                  const SizedBox(width: 20),
                  Container(width: 1, height: 15, color: Colors.white54),
                  const SizedBox(width: 20),
                  _buildTabItem("Gym Bros", 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    return GestureDetector(
      onTap: () => _tabController.animateTo(index),
      child: AnimatedBuilder(
        animation: _tabController.animation!,
        builder: (context, child) {
          final isSelected = _tabController.index == index;
          return Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: isSelected ? 18 : 16,
              shadows: isSelected 
                ? [const Shadow(color: Colors.black, blurRadius: 4)] 
                : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeed(List<Map<String, dynamic>> posts, String emptyMessage) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    if (posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.video_library_outlined, color: Colors.white54, size: 64),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: const TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostItem(post: posts[index], postService: _postService);
      },
    );
  }
}

class PostItem extends StatefulWidget {
  final Map<String, dynamic> post;
  final PostService postService;

  const PostItem({
    super.key, 
    required this.post,
    required this.postService,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isLiked = false;
  int _likeCount = 0;
  bool _showHeartAnimation = false;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.post['likes'] ?? 0;
    _checkIfLiked();
    if (widget.post['mediaType'] == 'video') {
      _initializeVideo();
    }
  }

  Future<void> _checkIfLiked() async {
    final liked = await widget.postService.hasLikedPost(widget.post['id']);
    if (mounted) {
      setState(() => _isLiked = liked);
    }
  }

  Future<void> _initializeVideo() async {
    final file = File(widget.post['mediaPath']);
    if (await file.exists()) {
      _videoController = VideoPlayerController.file(file);
      await _videoController!.initialize();
      
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: true,
        showControls: false,
        aspectRatio: _videoController!.value.aspectRatio,
      );
      
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    if (!_isLiked) {
      _toggleLike();
    }
    setState(() => _showHeartAnimation = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _showHeartAnimation = false);
    });
  }

  Future<void> _toggleLike() async {
    await widget.postService.toggleLike(widget.post['id']);
    if (mounted) {
      setState(() {
        _isLiked = !_isLiked;
        _likeCount += _isLiked ? 1 : -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isVideo = widget.post['mediaType'] == 'video';
    final mediaPath = widget.post['mediaPath'];
    final file = File(mediaPath);

    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Media Content
          Container(
            color: Colors.black,
            child: Center(
              child: isVideo
                  ? (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
                      ? Chewie(controller: _chewieController!)
                      : const CircularProgressIndicator(color: Colors.white))
                  : (file.existsSync() 
                      ? Image.file(file, fit: BoxFit.contain)
                      : const Icon(Icons.broken_image, color: Colors.white)),
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),

          // Right Side Actions
          Positioned(
            right: 10,
            bottom: 100,
            child: Column(
              children: [
                _buildProfileImage(),
                const SizedBox(height: 20),
                _buildActionButton(
                  icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : Colors.white,
                  label: _formatCount(_likeCount),
                  onTap: _toggleLike,
                ),
                const SizedBox(height: 20),
                _buildActionButton(
                  icon: Icons.comment_rounded,
                  color: Colors.white,
                  label: "0",
                  onTap: () {}, // Comments not implemented yet
                ),
                const SizedBox(height: 20),
                _buildActionButton(
                  icon: Icons.share,
                  color: Colors.white,
                  label: "Share",
                  onTap: () {}, // Share not implemented yet
                ),
              ],
            ),
          ),

          // Bottom Info
          Positioned(
            left: 10,
            bottom: 20,
            right: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@${widget.post['userName']}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                if (widget.post['caption'] != null && widget.post['caption'].isNotEmpty)
                  Text(
                    widget.post['caption'],
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 8),
                Text(
                  _formatDate(widget.post['createdAt']),
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),

          // Heart Animation
          if (_showHeartAnimation)
            const Center(
              child: Icon(
                Icons.favorite,
                color: Colors.white,
                size: 100,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    final profilePicPath = widget.post['userProfilePic'];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 24,
        backgroundImage: profilePicPath != null && File(profilePicPath).existsSync()
            ? FileImage(File(profilePicPath))
            : const AssetImage("Images/profile.png") as ImageProvider,
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 35),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }

  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return DateFormat('MMM d, yyyy').format(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
