import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Dietaddpage extends StatefulWidget {
  const Dietaddpage({super.key});

  @override
  State<Dietaddpage> createState() => _DietaddpageState();
}

class _DietaddpageState extends State<Dietaddpage> {
  final ImagePicker _picker = ImagePicker();
  
  List<Map<String, dynamic>> posts = [
    {
      'type': 'image',
      'content': null,
      'caption': 'Healthy meal prep ideas for the week! 🥗',
      'likes': 45,
      'comments': 12,
      'timestamp': '2 days ago',
    },
    {
      'type': 'video',
      'content': null,
      'caption': 'Quick nutrition tips for busy professionals',
      'likes': 67,
      'comments': 23,
      'timestamp': '5 days ago',
    },
    {
      'type': 'image',
      'content': null,
      'caption': 'Client success story: 15kg weight loss journey! 💪',
      'likes': 89,
      'comments': 34,
      'timestamp': '1 week ago',
    },
  ];

  Future<void> _pickMedia(String type) async {
    final XFile? media = type == 'image'
        ? await _picker.pickImage(source: ImageSource.gallery)
        : await _picker.pickVideo(source: ImageSource.gallery);
    
    if (media != null) {
      _showAddPostDialog(type, File(media.path));
    }
  }

  void _showAddPostDialog(String type, File? mediaFile) {
    final captionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add ${type == 'image' ? 'Photo' : 'Video'} Post'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (mediaFile != null)
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                    image: type == 'image'
                        ? DecorationImage(
                            image: FileImage(mediaFile),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: type == 'video'
                      ? const Center(
                          child: Icon(Icons.play_circle_outline, size: 64, color: Colors.grey),
                        )
                      : null,
                ),
              const SizedBox(height: 16),
              TextField(
                controller: captionController,
                decoration: const InputDecoration(
                  labelText: 'Caption',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                posts.insert(0, {
                  'type': type,
                  'content': mediaFile,
                  'caption': captionController.text,
                  'likes': 0,
                  'comments': 0,
                  'timestamp': 'Just now',
                });
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Post added successfully!'),
                  backgroundColor: Colors.green[700],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                posts.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Post deleted'),
                  backgroundColor: Colors.green[700],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.green[700]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Posts'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.add_circle_outline),
            onSelected: (value) {
              _pickMedia(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'image',
                child: Row(
                  children: [
                    Icon(Icons.photo),
                    SizedBox(width: 8),
                    Text('Add Photo'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'video',
                child: Row(
                  children: [
                    Icon(Icons.videocam),
                    SizedBox(width: 8),
                    Text('Add Video'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: posts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.post_add, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No posts yet',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => _pickMedia('image'),
                    icon: const Icon(Icons.add),
                    label: const Text('Create First Post'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post Header
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: primaryColor,
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        title: const Text(
                          'Sarah Wanjiru',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(post['timestamp']),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 20),
                                  SizedBox(width: 8),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, size: 20, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Delete', style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'delete') {
                              _showDeleteConfirmation(index);
                            }
                          },
                        ),
                      ),

                      // Post Media
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          image: post['content'] != null && post['type'] == 'image'
                              ? DecorationImage(
                                  image: FileImage(post['content']),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: post['content'] == null
                            ? Center(
                                child: Icon(
                                  post['type'] == 'video' ? Icons.play_circle_outline : Icons.image,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                              )
                            : post['type'] == 'video'
                                ? const Center(
                                    child: Icon(Icons.play_circle_outline, size: 64, color: Colors.white),
                                  )
                                : null,
                      ),

                      // Post Caption
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          post['caption'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),

                      // Post Actions
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Icon(Icons.favorite_border, size: 20, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text('${post['likes']}', style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(width: 24),
                            Icon(Icons.comment_outlined, size: 20, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text('${post['comments']}', style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(width: 24),
                            Icon(Icons.share_outlined, size: 20, color: Colors.grey[600]),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}