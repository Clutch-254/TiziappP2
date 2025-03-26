import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Message model
class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final String? attachmentUrl;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    this.isRead = false,
    this.attachmentUrl,
  });
}

// Contact model
class Contact {
  final String id;
  final String name;
  final String photoUrl;
  final String status;
  final DateTime lastSeen;
  final bool isOnline;
  final String membershipType;
  final List<String> goals;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;

  Contact({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.status,
    required this.lastSeen,
    required this.isOnline,
    required this.membershipType,
    required this.goals,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
  });
}

// Community model
class Community {
  final String id;
  final String name;
  final String photoUrl;
  final String description;
  final int memberCount;
  final bool isPrivate;
  final List<String> tags;
  final String? lastMessage;
  final DateTime? lastMessageTime;

  Community({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.memberCount,
    required this.isPrivate,
    required this.tags,
    this.lastMessage,
    this.lastMessageTime,
  });
}

class Messagetrainer extends StatefulWidget {
  const Messagetrainer({super.key});

  @override
  State<Messagetrainer> createState() => _MessagetrainerState();
}

class _MessagetrainerState extends State<Messagetrainer>
    with SingleTickerProviderStateMixin {
  // Color scheme
  final Color primaryColor = const Color(0xFF616161);
  final Color lightGrey = const Color(0xFF9E9E9E);
  final Color veryLightGrey = const Color(0xFFE0E0E0);
  final Color backgroundGrey = const Color(0xFFF5F5F5);
  final Color accentBlue = const Color(0xFF2196F3);

  // Tab controller
  late TabController _tabController;

  // Search query
  String _searchQuery = '';

  // Selected client/community for messaging (would be null initially)
  String? _selectedContactId;
  String? _selectedCommunityId;
  bool _isContactSelected = true; // true for contacts, false for communities

  // Message input
  final TextEditingController _messageController = TextEditingController();

  // Sample data for clients
  final List<Contact> _clients = [
    Contact(
      id: '1',
      name: 'James Otuke',
      photoUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      status: 'Active',
      lastSeen: DateTime.now().subtract(const Duration(minutes: 5)),
      isOnline: true,
      membershipType: 'Premium',
      goals: ['Weight Loss', 'Strength Training'],
      lastMessage: 'Thanks for the workout plan!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 0,
    ),
    Contact(
      id: '2',
      name: 'Sarah Kiatu',
      photoUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      status: 'Active',
      lastSeen: DateTime.now().subtract(const Duration(minutes: 30)),
      isOnline: true,
      membershipType: 'Standard',
      goals: ['Toning', 'Flexibility'],
      lastMessage: 'I completed the HIIT session',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 2,
    ),
    Contact(
      id: '3',
      name: 'Michael Mwangi',
      photoUrl: 'https://randomuser.me/api/portraits/men/55.jpg',
      status: 'Inactive',
      lastSeen: DateTime.now().subtract(const Duration(days: 2)),
      isOnline: false,
      membershipType: 'Premium',
      goals: ['Muscle Building', 'Endurance'],
      lastMessage: 'Will resume next week',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
      unreadCount: 0,
    ),
    Contact(
      id: '4',
      name: 'Lisa Ngeje',
      photoUrl: 'https://randomuser.me/api/portraits/women/67.jpg',
      status: 'Active',
      lastSeen: DateTime.now().subtract(const Duration(hours: 1)),
      isOnline: false,
      membershipType: 'Standard',
      goals: ['Weight Loss', 'Cardio'],
      lastMessage: 'I need to reschedule our session',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 6)),
      unreadCount: 1,
    ),
    Contact(
      id: '5',
      name: 'David Tole',
      photoUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
      status: 'Active',
      lastSeen: DateTime.now().subtract(const Duration(minutes: 10)),
      isOnline: true,
      membershipType: 'Premium',
      goals: ['Muscle Building', 'Sports Performance'],
      lastMessage: 'When is our next session?',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 45)),
      unreadCount: 0,
    ),
    Contact(
      id: '6',
      name: 'Jennifer Mutembei',
      photoUrl: 'https://randomuser.me/api/portraits/women/28.jpg',
      status: 'New',
      lastSeen: DateTime.now().subtract(const Duration(days: 1)),
      isOnline: false,
      membershipType: 'Standard',
      goals: ['Weight Loss', 'Overall Fitness'],
    ),
  ];

  // Sample data for communities
  final List<Community> _communities = [
    Community(
      id: '1',
      name: 'Ultimate Fitness Gym',
      photoUrl:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=100',
      description: 'Official group for members of Ultimate Fitness Gym',
      memberCount: 156,
      isPrivate: false,
      tags: ['Gym', 'Official'],
      lastMessage: 'Reminder: Gym closes early on Friday',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Community(
      id: '2',
      name: 'Morning HIIT Warriors',
      photoUrl:
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?q=80&w=100',
      description: 'Group for 6AM HIIT class members',
      memberCount: 42,
      isPrivate: true,
      tags: ['HIIT', 'Morning'],
      lastMessage: 'Thursday class will focus on upper body',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Community(
      id: '3',
      name: 'Nutrition Support Group',
      photoUrl:
          'https://images.unsplash.com/photo-1490645935967-10de6ba17061?q=80&w=100',
      description: 'Share meal plans and nutrition tips',
      memberCount: 89,
      isPrivate: false,
      tags: ['Nutrition', 'Diet'],
      lastMessage: 'Check out this new protein smoothie recipe!',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Community(
      id: '4',
      name: 'Powerlifters Club',
      photoUrl:
          'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?q=80&w=100',
      description: 'For serious weightlifters and powerlifters',
      memberCount: 34,
      isPrivate: true,
      tags: ['Powerlifting', 'Strength'],
      lastMessage: 'New deadlift technique video posted',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    Community(
      id: '5',
      name: 'Trainer Network',
      photoUrl:
          'https://images.unsplash.com/photo-1571731956672-f2b94d7dd0cb?q=80&w=100',
      description: 'Private group for certified trainers',
      memberCount: 28,
      isPrivate: true,
      tags: ['Trainers', 'Professional'],
      lastMessage: 'Conference discount codes available',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  // Sample messages for the selected client/community
  final Map<String, List<Message>> _conversations = {
    '1': [
      // Messages with James Otuke
      Message(
        id: '101',
        senderId: 'trainer',
        receiverId: '1',
        content: 'How was your workout today?',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isRead: true,
      ),
      Message(
        id: '102',
        senderId: '1',
        receiverId: 'trainer',
        content: 'It was great! I hit a new personal record on deadlifts.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
      ),
      Message(
        id: '103',
        senderId: 'trainer',
        receiverId: '1',
        content: 'That\'s awesome! What was the weight?',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
      ),
      Message(
        id: '104',
        senderId: '1',
        receiverId: 'trainer',
        content: '315 lbs for 3 reps!',
        timestamp:
            DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
        isRead: true,
      ),
      Message(
        id: '105',
        senderId: 'trainer',
        receiverId: '1',
        content:
            'Incredible progress. Let\'s aim for 325 next week! I\'ll update your program.',
        timestamp:
            DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
        isRead: true,
      ),
      Message(
        id: '106',
        senderId: '1',
        receiverId: 'trainer',
        content: 'Thanks for the workout plan!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: true,
      ),
    ],
    '2': [
      // Messages with Sarah Kiatu
      Message(
        id: '201',
        senderId: 'trainer',
        receiverId: '2',
        content: 'Don\'t forget your HIIT session today',
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        isRead: true,
      ),
      Message(
        id: '202',
        senderId: '2',
        receiverId: 'trainer',
        content: 'I\'ll do it this afternoon!',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: true,
      ),
      Message(
        id: '203',
        senderId: '2',
        receiverId: 'trainer',
        content: 'I completed the HIIT session',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isRead: false,
      ),
      Message(
        id: '204',
        senderId: '2',
        receiverId: 'trainer',
        content: 'It was really challenging today',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isRead: false,
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Filter contacts/communities based on search query
  List<Contact> get _filteredClients {
    if (_searchQuery.isEmpty) {
      return _clients;
    }
    return _clients
        .where((client) =>
            client.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  List<Community> get _filteredCommunities {
    if (_searchQuery.isEmpty) {
      return _communities;
    }
    return _communities
        .where((community) =>
            community.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // Get selected client/community
  Contact? get _selectedContact {
    if (_selectedContactId == null) return null;
    try {
      return _clients.firstWhere((client) => client.id == _selectedContactId);
    } catch (e) {
      return null;
    }
  }

  Community? get _selectedCommunity {
    if (_selectedCommunityId == null) return null;
    try {
      return _communities
          .firstWhere((community) => community.id == _selectedCommunityId);
    } catch (e) {
      return null;
    }
  }

  // Get messages for the selected client/community
  List<Message> get _selectedConversation {
    if (_isContactSelected && _selectedContactId != null) {
      return _conversations[_selectedContactId] ?? [];
    } else if (!_isContactSelected && _selectedCommunityId != null) {
      return _conversations[_selectedCommunityId] ?? [];
    }
    return [];
  }

  // Select a client for messaging
  void _selectContact(String id) {
    setState(() {
      _selectedContactId = id;
      _selectedCommunityId = null;
      _isContactSelected = true;
    });
  }

  // Select a community for messaging
  void _selectCommunity(String id) {
    setState(() {
      _selectedCommunityId = id;
      _selectedContactId = null;
      _isContactSelected = false;
    });
  }

  // Send a message
  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      final newMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: 'trainer',
        receiverId:
            _isContactSelected ? _selectedContactId! : _selectedCommunityId!,
        content: message,
        timestamp: DateTime.now(),
      );

      final conversationId =
          _isContactSelected ? _selectedContactId! : _selectedCommunityId!;

      if (_conversations.containsKey(conversationId)) {
        _conversations[conversationId]!.add(newMessage);
      } else {
        _conversations[conversationId] = [newMessage];
      }

      _messageController.clear();
    });
  }

  // Format timestamp for display
  String _formatMessageTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return DateFormat('MMM d').format(timestamp);
    } else {
      return DateFormat('h:mm a').format(timestamp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Create new message or community (not implemented)
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Menu options (not implemented)
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Clients'),
            Tab(text: 'Communities'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(16),
            color: primaryColor,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: lightGrey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // Main content area
          Expanded(
            child: Row(
              children: [
                // Contact/Community list (left side)
                Container(
                  width: 280,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: veryLightGrey),
                    ),
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Clients tab
                      ListView.builder(
                        itemCount: _filteredClients.length,
                        itemBuilder: (context, index) {
                          final client = _filteredClients[index];
                          final isSelected = _selectedContactId == client.id;

                          return _buildContactTile(
                            client: client,
                            isSelected: isSelected,
                            onTap: () => _selectContact(client.id),
                          );
                        },
                      ),

                      // Communities tab
                      ListView.builder(
                        itemCount: _filteredCommunities.length,
                        itemBuilder: (context, index) {
                          final community = _filteredCommunities[index];
                          final isSelected =
                              _selectedCommunityId == community.id;

                          return _buildCommunityTile(
                            community: community,
                            isSelected: isSelected,
                            onTap: () => _selectCommunity(community.id),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Message area (right side)
                Expanded(
                  child: _selectedContact != null || _selectedCommunity != null
                      ? _buildConversationArea()
                      : _buildEmptyConversationArea(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _tabController.index == 1
          ? FloatingActionButton(
              backgroundColor: primaryColor,
              child: const Icon(Icons.group_add),
              onPressed: () {
                // Create new community (not implemented)
              },
            )
          : null,
    );
  }

  // Build a contact list tile
  Widget _buildContactTile({
    required Contact client,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      selected: isSelected,
      selectedTileColor: isSelected ? veryLightGrey : null,
      onTap: onTap,
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(client.photoUrl),
          ),
          if (client.isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              client.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (client.lastMessageTime != null)
            Text(
              _formatMessageTime(client.lastMessageTime!),
              style: TextStyle(
                fontSize: 12,
                color: client.unreadCount > 0 ? accentBlue : lightGrey,
              ),
            ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              client.lastMessage ?? client.membershipType,
              style: TextStyle(
                color: client.unreadCount > 0 ? accentBlue : lightGrey,
                fontWeight: client.unreadCount > 0
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (client.unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: accentBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                client.unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Build a community list tile
  Widget _buildCommunityTile({
    required Community community,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      selected: isSelected,
      selectedTileColor: isSelected ? veryLightGrey : null,
      onTap: onTap,
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(community.photoUrl),
        child: community.isPrivate
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 16,
                ),
              )
            : null,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              community.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (community.lastMessageTime != null)
            Text(
              _formatMessageTime(community.lastMessageTime!),
              style: TextStyle(
                fontSize: 12,
                color: lightGrey,
              ),
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (community.lastMessage != null)
            Text(
              community.lastMessage!,
              style: TextStyle(
                color: lightGrey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.people,
                size: 14,
                color: lightGrey,
              ),
              const SizedBox(width: 4),
              Text(
                '${community.memberCount}',
                style: TextStyle(
                  fontSize: 12,
                  color: lightGrey,
                ),
              ),
              const SizedBox(width: 8),
              ...community.tags.take(2).map((tag) => Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: veryLightGrey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                      ),
                    ),
                  )),
              if (community.tags.length > 2)
                Text(
                  '+${community.tags.length - 2}',
                  style: TextStyle(
                    fontSize: 10,
                    color: lightGrey,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // Build the conversation area when a contact/community is selected
  Widget _buildConversationArea() {
    final name =
        _isContactSelected ? _selectedContact!.name : _selectedCommunity!.name;
    final photoUrl = _isContactSelected
        ? _selectedContact!.photoUrl
        : _selectedCommunity!.photoUrl;
    final status = _isContactSelected
        ? _selectedContact!.isOnline
            ? 'Online'
            : 'Offline'
        : '${_selectedCommunity!.memberCount} members';

    return Column(
      children: [
        // Conversation header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: veryLightGrey),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(photoUrl),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        color: lightGrey,
                      ),
                    ),
                  ],
                ),
              ),
              // Call buttons
              IconButton(
                icon: const Icon(Icons.videocam),
                onPressed: () {
                  // Video call (not implemented)
                },
              ),
              IconButton(
                icon: const Icon(Icons.phone),
                onPressed: () {
                  // Voice call (not implemented)
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Options (not implemented)
                },
              ),
            ],
          ),
        ),

        // Messages area
        Expanded(
          child: Container(
            color: backgroundGrey,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: _selectedConversation.length,
              itemBuilder: (context, index) {
                final message = _selectedConversation.reversed.toList()[index];
                final isSentByMe = message.senderId == 'trainer';

                return _buildMessageBubble(
                  message: message,
                  isSentByMe: isSentByMe,
                );
              },
            ),
          ),
        ),

        // Message input area
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: veryLightGrey),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: () {
                  // Attachment (not implemented)
                },
              ),
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: backgroundGrey,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  maxLines: null,
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: primaryColor,
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: _sendMessage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Build the empty conversation area
  Widget _buildEmptyConversationArea() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 100,
            color: veryLightGrey,
          ),
          const SizedBox(height: 16),
          Text(
            'Select a conversation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose a client or community to start messaging',
            style: TextStyle(
              color: lightGrey,
            ),
          ),
        ],
      ),
    );
  }

  // Build a message bubble
  Widget _buildMessageBubble({
    required Message message,
    required bool isSentByMe,
  }) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSentByMe ? accentBlue : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: isSentByMe ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatMessageTime(message.timestamp),
              style: TextStyle(
                color: isSentByMe ? Colors.white.withOpacity(0.7) : lightGrey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
