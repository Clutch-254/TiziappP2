import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tiziappp2/technicals/services/post_service.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:intl/intl.dart';
class Contentscroll extends StatefulWidget {
  const Contentscroll({super.key});

  @override
  State<Contentscroll> createState() => _ContentscrollState();
}

class _ContentscrollState extends State<Contentscroll>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  bool _isPanelVisible = false;
  bool _isMediaPickerVisible = false;

  final PostService _postService = PostService();
  List<Map<String, dynamic>> _contentItems = [];
  bool _isLoading = true;
  String _selectedCategory = 'Influencer'; // Default to Influencer for feed
  
  // Media picker properties
  final ImagePicker _picker = ImagePicker();
  File? _mediaFile;
  bool _isVideo = false;
  
  // Categories for the top selector
  final List<String> _categories = [
    'Influencer',
    'Trainer',
    'Nutritionist',
    'Institution',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() => _isLoading = true);
    try {
      // Load all posts for the feed
      final posts = await _postService.getAllFeedPosts();
      if (mounted) {
        setState(() {
          _contentItems = posts;
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading posts: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleActionPanel() {
    setState(() {
      _isPanelVisible = !_isPanelVisible;
      if (_isPanelVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        _isMediaPickerVisible = false; // Hide media picker when panel closes
      }
    });
  }

  void _closeActionPanel() {
    setState(() {
      _isPanelVisible = false;
      _animationController.reverse();
      _isMediaPickerVisible = false;
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      // Here you would typically filter content based on category
      // For demo purposes, we're just changing the selected state
    });
  }

  void _toggleMediaPicker() {
    setState(() {
      _isMediaPickerVisible = !_isMediaPickerVisible;
    });
  }

  Future<void> _takePicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _mediaFile = File(photo.path);
        _isVideo = false;
        _isMediaPickerVisible = false; // Hide picker after selection
        _showPostPreview();
      });
    }
  }

  Future<void> _recordVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      setState(() {
        _mediaFile = File(video.path);
        _isVideo = true;
        _isMediaPickerVisible = false; // Hide picker after selection
        _showPostPreview();
      });
    }
  }

  Future<void> _chooseFromGallery() async {
    final XFile? media = await _picker.pickMedia();
    if (media != null) {
      setState(() {
        _mediaFile = File(media.path);
        _isVideo = media.name.toLowerCase().endsWith('.mp4') ||
            media.name.toLowerCase().endsWith('.mov') ||
            media.name.toLowerCase().endsWith('.avi');
        _isMediaPickerVisible = false; // Hide picker after selection
        _showPostPreview();
      });
    }
  }

  void _showPostPreview() {
    // This would typically show a preview and allow adding description, tags, etc.
    // For now, we'll just show a basic dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Post Preview'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_mediaFile != null)
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: _isVideo
                      ? null
                      : DecorationImage(
                          image: FileImage(_mediaFile!),
                          fit: BoxFit.cover,
                        ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: _isVideo
                    ? Icon(Icons.video_file,
                        size: 50, color: Colors.grey.shade800)
                    : null,
              ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Add a description...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Here you would implement the post upload logic
              // For demo purposes, we'll just close the dialog
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Your post has been uploaded!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('Post'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Category selector at the top
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _categories
                    .map((category) => GestureDetector(
                          onTap: () => _selectCategory(category),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: _selectedCategory == category
                                  ? FontWeight.w900 // Bold when selected
                                  : FontWeight.w400, // Normal when not selected
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),

          // Main content scrollable area - adjusted for category header
          Positioned(
            top: MediaQuery.of(context).padding.top +
                60, // Height of the category selector
            bottom: 0,
            left: 0,
            right: 0,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : _contentItems.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.video_library_outlined,
                                color: Colors.white54, size: 64),
                            const SizedBox(height: 16),
                            const Text(
                              "No posts yet",
                              style: TextStyle(color: Colors.white54, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : PageView.builder(
                        scrollDirection: Axis.vertical,
                        controller: _pageController,
                        itemCount: _contentItems.length,
                        itemBuilder: (context, index) {
                          final item = _contentItems[index];
                          return ContentPage(
                            post: item,
                            onActionButtonTap: _toggleActionPanel,
                            currentPage: index + 1,
                            totalPages: _contentItems.length,
                            postService: _postService,
                          );
                        },
                      ),
          ),

          // Slide-up action panel
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height *
                    0.3 *
                    _animationController.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Panel header with back button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back button
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: _closeActionPanel,
                            ),
                            // Handle bar
                            Container(
                              width: 40,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                            ),
                            // Plus button for media capture
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline,
                                  color: Colors.white, size: 30),
                              onPressed: _toggleMediaPicker,
                            ),
                          ],
                        ),
                      ),
                      // Media picker options
                      if (_isMediaPickerVisible)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildMediaOption(
                                  Icons.camera_alt, 'Take Photo', _takePicture),
                              _buildMediaOption(
                                  Icons.videocam, 'Record Video', _recordVideo),
                              _buildMediaOption(Icons.photo_library, 'Gallery',
                                  _chooseFromGallery),
                            ],
                          ),
                        ),
                      if (!_isMediaPickerVisible)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: _buildActionPanelContent(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMediaOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionPanelContent() {
    final currentIndex =
        _pageController.hasClients ? (_pageController.page?.round() ?? 0) : 0;

    if (currentIndex >= _contentItems.length || currentIndex < 0) {
      return Container();
    }

    final currentItem = _contentItems[currentIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interact with this content',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildActionButton(Icons.favorite, 'Like', '${currentItem['likes'] ?? 0}'),
            _buildActionButton(
                Icons.chat_bubble, 'Comment', '0'),
            _buildActionButton(Icons.share, 'Share', ''),
            _buildActionButton(Icons.bookmark, 'Save', ''),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Comments',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        // Sample comments section
        _buildCommentItem(
            '@fitness_fan', "Great routine! I'll try this tomorrow."),
        _buildCommentItem(
            '@gym_newbie', 'This is really helpful, thanks for sharing!'),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, String count) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        if (count.isNotEmpty)
          Text(
            count,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget _buildCommentItem(String username, String comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 15, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  comment,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContentPage extends StatefulWidget {
  final Map<String, dynamic> post;
  final VoidCallback onActionButtonTap;
  final int currentPage;
  final int totalPages;
  final PostService postService;

  const ContentPage({
    Key? key,
    required this.post,
    required this.onActionButtonTap,
    required this.currentPage,
    required this.totalPages,
    required this.postService,
  }) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
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
      child: Container(
        color: Colors.transparent,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Media Content
            Center(
              child: isVideo
                  ? (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
                      ? Chewie(controller: _chewieController!)
                      : const CircularProgressIndicator(color: Colors.white))
                  : (file.existsSync() 
                      ? Image.file(file, fit: BoxFit.contain)
                      : const Icon(Icons.broken_image, color: Colors.white, size: 64)),
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

            // Heart Animation
            if (_showHeartAnimation)
              const Center(
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 100,
                ),
              ),

            // Overlay with user info
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildProfileImage(),
                        const SizedBox(width: 10),
                        Text(
                          "@${widget.post['userName']}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (widget.post['caption'] != null && widget.post['caption'].isNotEmpty)
                      Text(
                        widget.post['caption'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
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
            ),

            // Single interaction button that opens the slide-up panel
            Positioned(
              right: 16,
              bottom: 100,
              child: Column(
                children: [
                  _buildSideActionButton(
                    icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked ? Colors.red : Colors.white,
                    label: _formatCount(_likeCount),
                    onTap: _toggleLike,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: widget.onActionButtonTap,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Page indicator
            Positioned(
              top: 100,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${widget.currentPage}/${widget.totalPages}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
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
        radius: 16,
        backgroundImage: profilePicPath != null && File(profilePicPath).existsSync()
            ? FileImage(File(profilePicPath))
            : const AssetImage("Images/profile.png") as ImageProvider,
      ),
    );
  }

  Widget _buildSideActionButton({
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
              shadows: [Shadow(color: Colors.black, blurRadius: 2)],
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
