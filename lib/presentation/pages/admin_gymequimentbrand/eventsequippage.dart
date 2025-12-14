import 'package:flutter/material.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Eventsequippage extends StatefulWidget {
  const Eventsequippage({super.key});

  @override
  State<Eventsequippage> createState() => _EventsequippageState();
}

class _EventsequippageState extends State<Eventsequippage> {
  // Sample media posts
  List<Map<String, dynamic>> mediaPosts = [
    {
      'type': 'image',
      'title': 'New Treadmill Collection',
      'description': 'Check out our latest treadmill models!',
      'date': '2024-12-10',
    },
    {
      'type': 'video',
      'title': 'Power Rack Demo',
      'description': 'See our power rack in action',
      'date': '2024-12-08',
    },
    {
      'type': 'image',
      'title': 'Dumbbells Showcase',
      'description': 'Premium quality dumbbells',
      'date': '2024-12-05',
    },
  ];

  void _addMediaPost() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String mediaType = 'image';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Media Post'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: mediaType,
                decoration: const InputDecoration(
                  labelText: 'Media Type',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem(value: 'image', child: Text('Image')),
                  const DropdownMenuItem(value: 'video', child: Text('Video')),
                ],
                onChanged: (value) => mediaType = value!,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  // In a real app, this would open file picker
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('File picker would open here')),
                  );
                },
                icon: const Icon(Icons.upload_file),
                label: Text('Upload ${mediaType == 'image' ? 'Image' : 'Video'}'),
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
              if (titleController.text.isNotEmpty) {
                setState(() {
                  mediaPosts.insert(0, {
                    'type': mediaType,
                    'title': titleController.text,
                    'description': descriptionController.text,
                    'date': DateTime.now().toString().substring(0, 10),
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Media post added!')),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  void _deletePost(int index) {
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
              setState(() => mediaPosts.removeAt(index));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post deleted')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Media & Advertising",
          style: AppWidget.boldTextFieledStyle(),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: _addMediaPost,
            tooltip: 'Add Media',
          ),
        ],
      ),
      body: mediaPosts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_library_outlined, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('No media posts yet', style: AppWidget.boldTextFieledStyle()),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _addMediaPost,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Media Post'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: mediaPosts.length,
              itemBuilder: (context, index) {
                final post = mediaPosts[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Icon(
                              post['type'] == 'image' ? Icons.image : Icons.play_circle_outline,
                              size: 60,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post['title'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              post['description'],
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  post['date'],
                                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, size: 18),
                                  onPressed: () => _deletePost(index),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
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