import 'package:flutter/material.dart';

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

  // Selected category state
  String _selectedCategory = 'Brand'; // Default selected category
  final List<String> _categories = ['Brand', 'Specialist', 'Influencer'];

  // Sample content data - replace with your actual content
  final List<Map<String, dynamic>> _contentItems = [
    {
      'username': '@user1',
      'description': 'This is my workout routine #fitness #gym',
      'likes': '10.2K',
      'comments': '342',
      'backgroundColor': Colors.red.shade200,
    },
    {
      'username': '@nutritionist',
      'description': 'Easy protein meal prep for the week #nutrition #mealprep',
      'likes': '5.7K',
      'comments': '129',
      'backgroundColor': Colors.blue.shade200,
    },
    {
      'username': '@gymtrainer',
      'description':
          'Perfect your squat form with these tips #squat #technique',
      'likes': '8.3K',
      'comments': '256',
      'backgroundColor': Colors.green.shade200,
    },
    {
      'username': '@fitnessjourney',
      'description': 'My 3-month transformation #progress #motivation',
      'likes': '15.9K',
      'comments': '478',
      'backgroundColor': Colors.purple.shade200,
    },
    {
      'username': '@healthycooking',
      'description': 'Low-carb dinner ideas #recipes #healthyeating',
      'likes': '7.1K',
      'comments': '215',
      'backgroundColor': Colors.orange.shade200,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
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
      }
    });
  }

  void _closeActionPanel() {
    setState(() {
      _isPanelVisible = false;
      _animationController.reverse();
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      // Here you would typically filter content based on category
      // For demo purposes, we're just changing the selected state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: Colors.black.withOpacity(0.7),
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
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: _contentItems.length,
              itemBuilder: (context, index) {
                final item = _contentItems[index];
                return ContentPage(
                  username: item['username'],
                  description: item['description'],
                  likes: item['likes'],
                  comments: item['comments'],
                  backgroundColor: item['backgroundColor'],
                  onActionButtonTap: _toggleActionPanel,
                  currentPage: index + 1,
                  totalPages: _contentItems.length,
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
                    color: Colors.black.withOpacity(0.8),
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
                            // Empty space for alignment
                            const SizedBox(width: 48),
                          ],
                        ),
                      ),
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
            _buildActionButton(Icons.favorite, 'Like', currentItem['likes']),
            _buildActionButton(
                Icons.chat_bubble, 'Comment', currentItem['comments']),
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
                    fontSize: 12,
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

class ContentPage extends StatelessWidget {
  final String username;
  final String description;
  final String likes;
  final String comments;
  final Color backgroundColor;
  final VoidCallback onActionButtonTap;
  final int currentPage;
  final int totalPages;

  const ContentPage({
    Key? key,
    required this.username,
    required this.description,
    required this.likes,
    required this.comments,
    required this.backgroundColor,
    required this.onActionButtonTap,
    required this.currentPage,
    required this.totalPages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          // This would be your content (video or image)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fitness_center,
                  size: 64,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Text(
                  'Content $currentPage of $totalPages',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Swipe up for next content',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Swipe down for previous content',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),

          // Overlay with user info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Single interaction button that opens the slide-up panel
          Positioned(
            right: 16,
            bottom: 100,
            child: GestureDetector(
              onTap: onActionButtonTap,
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
          ),
        ],
      ),
    );
  }
}
