import 'package:flutter/material.dart';

class Messagesup extends StatefulWidget {
  const Messagesup({super.key});

  @override
  State<Messagesup> createState() => _MessagesupState();
}

class _MessagesupState extends State<Messagesup> {
  final List<Map<String, dynamic>> conversations = [
    {
      'customerName': 'John Kamau',
      'lastMessage': 'Do you have the new protein flavor in stock?',
      'timestamp': '10:30 AM',
      'unread': 2,
    },
    {
      'customerName': 'Sarah Njeri',
      'lastMessage': 'Thank you for the fast delivery!',
      'timestamp': 'Yesterday',
      'unread': 0,
    },
    {
      'customerName': 'Michael Odhiambo',
      'lastMessage': 'Can I get a discount on bulk orders?',
      'timestamp': '2 days ago',
      'unread': 1,
    },
  ];

  void _openChat(Map<String, dynamic> customer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(customerName: customer['customerName']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color.fromARGB(255, 47, 47, 49);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: primaryColor,
              child: Text(
                conversation['customerName'][0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              conversation['customerName'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              conversation['lastMessage'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  conversation['timestamp'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (conversation['unread'] > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${conversation['unread']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () => _openChat(conversation),
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String customerName;

  const ChatScreen({super.key, required this.customerName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hi! Do you have the new protein flavor in stock?',
      'isMe': false,
      'timestamp': '10:15 AM',
    },
    {
      'text': 'Yes, we just received it yesterday! Would you like to place an order?',
      'isMe': true,
      'timestamp': '10:20 AM',
    },
    {
      'text': 'Great! I\'ll take 2 containers.',
      'isMe': false,
      'timestamp': '10:30 AM',
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add({
          'text': _messageController.text,
          'isMe': true,
          'timestamp': 'Just now',
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color.fromARGB(255, 47, 47, 49);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                widget.customerName[0],
                style: TextStyle(color: primaryColor),
              ),
            ),
            const SizedBox(width: 12),
            Text(widget.customerName),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Initiating voice call...')),
              );
            },
            tooltip: 'Voice Call',
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Initiating video call...')),
              );
            },
            tooltip: 'Video Call',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: message['isMe'] ? primaryColor : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['text'],
                          style: TextStyle(
                            color: message['isMe'] ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message['timestamp'],
                          style: TextStyle(
                            fontSize: 10,
                            color: message['isMe'] ? Colors.white70 : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
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
      ),
    );
  }
}