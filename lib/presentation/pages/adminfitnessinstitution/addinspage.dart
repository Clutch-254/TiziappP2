import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Addinspage extends StatefulWidget {
  const Addinspage({super.key});

  @override
  State<Addinspage> createState() => _AddinspageState();
}

class _AddinspageState extends State<Addinspage> {
  final List<XFile> _mediaFiles = [];
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _captionController = TextEditingController();

  Future<void> _pickImage() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _mediaFiles.addAll(images);
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _mediaFiles.add(video);
      });
    }
  }

  void _showPickOptionDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text('Video Library'),
                onTap: () {
                  _pickVideo();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeMedia(int index) {
    setState(() {
      _mediaFiles.removeAt(index);
    });
  }

  void _postContent() {
    if (_mediaFiles.isEmpty && _captionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add some content to post')),
      );
      return;
    }

    // Simulate posting
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Dismiss loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Posted successfully!')),
      );
      setState(() {
        _mediaFiles.clear();
        _captionController.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _postContent,
            child: const Text(
              'Post',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Caption Input
              TextField(
                controller: _captionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'What\'s happening at your gym?',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              
              // Media Grid
              if (_mediaFiles.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _mediaFiles.length,
                  itemBuilder: (context, index) {
                    final file = _mediaFiles[index];
                    final isVideo = file.path.toLowerCase().endsWith('.mp4') || 
                                    file.path.toLowerCase().endsWith('.mov');
                    
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(
                          File(file.path),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.videocam, color: Colors.grey),
                            );
                          },
                        ),
                        if (isVideo)
                          const Center(
                            child: Icon(Icons.play_circle_fill, color: Colors.white, size: 30),
                          ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => _removeMedia(index),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              
              const SizedBox(height: 20),
              
              // Add Media Button
              OutlinedButton.icon(
                onPressed: _showPickOptionDialog,
                icon: const Icon(Icons.add_photo_alternate),
                label: const Text('Add Photos/Videos'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}