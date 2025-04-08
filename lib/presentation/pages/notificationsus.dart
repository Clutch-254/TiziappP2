
import 'package:flutter/material.dart';

class Notificationsus extends StatefulWidget {
  const Notificationsus({super.key});

  @override
  State<Notificationsus> createState() => _NotificationsusState();
}

class _NotificationsusState extends State<Notificationsus> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Sample data for different types of notifications and messages
  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'PnM', 
      'role': 'Trainer',
      'message': 'Your workout plan for next week is ready. Let\'s focus on improving your bench press form.',
      'time': '10:30 AM',
      'isRead': false,
      'avatar': 'Images/PnM.png',
    },
    {
      'sender': 'Kisha', 
      'role': 'Nutritionist',
      'message': 'I noticed your protein intake is below target. Let\'s discuss some easy additions to your diet.',
      'time': 'Yesterday',
      'isRead': true,
      'avatar': 'Images/kisha.png',
    },
    {
      'sender': 'David M.', 
      'role': 'Gym Buddy',
      'message': 'Are we still meeting for the 6PM session tomorrow?',
      'time': 'Yesterday',
      'isRead': true,
      'avatar': null,
    },
    {
      'sender': 'Fitness Enthusiasts', 
      'role': 'Community',
      'message': 'New challenge posted: 30 Days of Functional Fitness. 5 members from your network have joined.',
      'time': 'Apr 5',
      'isRead': true,
      'avatar': null,
    },
    {
      'sender': 'Sarah L.', 
      'role': 'Gym Buddy',
      'message': 'Thanks for the protein shake recipe! It tastes amazing.',
      'time': 'Apr 4',
      'isRead': true,
      'avatar': null,
    },
  ];
  
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Workout Reminder', 
      'content': 'You have a Chest & Arms workout scheduled for today at 5:30 PM.',
      'time': '2 hours ago',
      'isRead': false,
      'type': 'reminder',
    },
    {
      'title': 'New Feature Available', 
      'content': 'We\'ve added AI-powered workout recommendations based on your progress!',
      'time': 'Today',
      'isRead': false,
      'type': 'app_update',
    },
    {
      'title': 'Subscription Renewal', 
      'content': 'Your premium subscription will renew in 3 days. Tap to manage.',
      'time': 'Yesterday',
      'isRead': true,
      'type': 'subscription',
    },
    {
      'title': 'Goal Achieved!', 
      'content': 'Congratulations! You\'ve reached your weekly protein intake goal.',
      'time': 'Apr 6',
      'isRead': true,
      'type': 'achievement',
    },
    {
      'title': 'New Blog Post', 
      'content': 'Check out "5 Ways to Improve Your Deadlift" on our blog.',
      'time': 'Apr 5',
      'isRead': true,
      'type': 'content',
    },
    {
      'title': 'Community Activity', 
      'content': '3 people liked your progress photo from last week.',
      'time': 'Apr 3',
      'isRead': true,
      'type': 'social',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inbox',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.grey[800],
          unselectedLabelColor: Colors.grey[500],
          indicatorColor: Colors.grey[800],
          tabs: const [
            Tab(text: "Messages"),
            Tab(text: "Notifications"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
              print('Search pressed');
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Messages Tab
          _buildMessagesTab(),
          
          // Notifications Tab
          _buildNotificationsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewMessageDialog(context);
        },
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.add_comment, color: Colors.white),
      ),
    );
  }
  
  // Build the Messages Tab
  Widget _buildMessagesTab() {
    return _messages.isEmpty 
      ? _buildEmptyState("No messages yet", "Your conversations with trainers, nutritionists, and other users will appear here.") 
      : ListView.builder(
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            final message = _messages[index];
            return _buildMessageTile(message);
          },
        );
  }
  
  // Build the Notifications Tab
  Widget _buildNotificationsTab() {
    return _notifications.isEmpty 
      ? _buildEmptyState("No notifications", "You're all caught up!") 
      : ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notification = _notifications[index];
            return _buildNotificationTile(notification);
          },
        );
  }
  
  // Empty state widget
  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Message tile widget
  Widget _buildMessageTile(Map<String, dynamic> message) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey[400],
        backgroundImage: message['avatar'] != null 
          ? AssetImage(message['avatar'])
          : null,
        child: message['avatar'] == null 
          ? Text(
              message['sender'][0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              message['sender'],
              style: TextStyle(
                fontWeight: message['isRead'] ? FontWeight.normal : FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            message['time'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            message['role'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message['message'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: message['isRead'] ? Colors.grey[600] : Colors.grey[800],
            ),
          ),
        ],
      ),
      trailing: !message['isRead'] 
        ? Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[800],
            ),
          )
        : null,
      onTap: () {
        // Open conversation
        _openConversation(message);
      },
    );
  }
  
  // Notification tile widget
  Widget _buildNotificationTile(Map<String, dynamic> notification) {
    IconData iconData;
    Color iconColor;
    
    // Determine icon and color based on notification type
    switch(notification['type']) {
      case 'reminder':
        iconData = Icons.alarm;
        iconColor = Colors.orange;
        break;
      case 'app_update':
        iconData = Icons.new_releases;
        iconColor = Colors.purple;
        break;
      case 'subscription':
        iconData = Icons.card_membership;
        iconColor = Colors.blue;
        break;
      case 'achievement':
        iconData = Icons.emoji_events;
        iconColor = Colors.amber;
        break;
      case 'content':
        iconData = Icons.article;
        iconColor = Colors.teal;
        break;
      case 'social':
        iconData = Icons.people;
        iconColor = Colors.green;
        break;
      default:
        iconData = Icons.notifications;
        iconColor = Colors.grey;
    }
    
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: iconColor,
          size: 24,
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              notification['title'],
              style: TextStyle(
                fontWeight: notification['isRead'] ? FontWeight.normal : FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            notification['time'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          notification['content'],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: notification['isRead'] ? Colors.grey[600] : Colors.grey[800],
          ),
        ),
      ),
      trailing: !notification['isRead'] 
        ? Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[800],
            ),
          )
        : null,
      onTap: () {
        // Handle notification tap
        setState(() {
          notification['isRead'] = true;
        });
        
        // Show notification details
        _showNotificationDetails(notification);
      },
    );
  }
  
  // Open conversation method
  void _openConversation(Map<String, dynamic> message) {
    // Mark message as read
    setState(() {
      message['isRead'] = true;
    });
    
    // Navigate to conversation screen (placeholder)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[400],
                backgroundImage: message['avatar'] != null 
                  ? AssetImage(message['avatar'])
                  : null,
                child: message['avatar'] == null 
                  ? Text(
                      message['sender'][0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    )
                  : null,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message['sender'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    message['role'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          content: Container(
            height: 300,
            width: double.maxFinite,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _buildChatBubble(message['message'], false),
                      _buildChatBubble("This is a placeholder for the conversation view. In a real app, this would show the full chat history.", true),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        // Send message functionality
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
  
  // Show notification details
  void _showNotificationDetails(Map<String, dynamic> notification) {
    IconData iconData;
    Color iconColor;
    
    // Determine icon and color based on notification type
    switch(notification['type']) {
      case 'reminder':
        iconData = Icons.alarm;
        iconColor = Colors.orange;
        break;
      case 'app_update':
        iconData = Icons.new_releases;
        iconColor = Colors.purple;
        break;
      case 'subscription':
        iconData = Icons.card_membership;
        iconColor = Colors.blue;
        break;
      case 'achievement':
        iconData = Icons.emoji_events;
        iconColor = Colors.amber;
        break;
      case 'content':
        iconData = Icons.article;
        iconColor = Colors.teal;
        break;
      case 'social':
        iconData = Icons.people;
        iconColor = Colors.green;
        break;
      default:
        iconData = Icons.notifications;
        iconColor = Colors.grey;
    }
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  color: iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  notification['title'],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification['content'],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Received: ${notification['time']}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16),
              if (notification['type'] == 'reminder')
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to workout screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text("View Workout Details"),
                )
              else if (notification['type'] == 'app_update')
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to new feature screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text("Explore New Feature"),
                )
              else if (notification['type'] == 'subscription')
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to subscription screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text("Manage Subscription"),
                )
              else if (notification['type'] == 'achievement')
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to achievements screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text("View All Achievements"),
                )
              else if (notification['type'] == 'content')
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to blog post
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text("Read Article"),
                )
              else if (notification['type'] == 'social')
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to profile
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text("View Your Profile"),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Dismiss"),
            ),
          ],
        );
      },
    );
  }
  
  // Chat bubble for conversation
  Widget _buildChatBubble(String message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.grey[800] : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.grey[800],
          ),
        ),
      ),
    );
  }
  
  // Show filter dialog
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Filter By"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterOption("All", true),
              _buildFilterOption("Unread", false),
              _buildFilterOption("Trainers", false),
              _buildFilterOption("Nutritionists", false),
              _buildFilterOption("App Updates", false),
              _buildFilterOption("Communities", false),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Apply filter
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
              ),
              child: const Text("Apply"),
            ),
          ],
        );
      },
    );
  }
  
  // Build filter option
  Widget _buildFilterOption(String label, bool isSelected) {
    return ListTile(
      title: Text(label),
      trailing: isSelected 
        ? Icon(Icons.check_circle, color: Colors.grey[800])
        : Icon(Icons.circle_outlined, color: Colors.grey[400]),
      onTap: () {
        // Select this filter option
        Navigator.of(context).pop();
        // Here you would apply the filter
      },
    );
  }
  
  // Show new message dialog
  void _showNewMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("New Message"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "To",
                  hintText: "Search for a person or group",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Recent Contacts",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              _buildQuickContactOption("PnM", "Trainer", "Images/PnM.png"),
              _buildQuickContactOption("Kisha", "Nutritionist", "Images/kisha.png"),
              _buildQuickContactOption("Fitness Enthusiasts", "Community", null),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
  
  // Quick contact option for new message
  Widget _buildQuickContactOption(String name, String role, String? avatarPath) {
    return ListTile(
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.grey[400],
        backgroundImage: avatarPath != null 
          ? AssetImage(avatarPath)
          : null,
        child: avatarPath == null 
          ? Text(
              name[0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            )
          : null,
      ),
      title: Text(name),
      subtitle: Text(
        role,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        // Open conversation with this contact
        _openConversation({
          'sender': name,
          'role': role,
          'message': '',
          'time': 'Now',
          'isRead': true,
          'avatar': avatarPath,
        });
      },
    );
  }
}