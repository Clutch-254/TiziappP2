import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';

class Addfitpage extends StatefulWidget {
  const Addfitpage({super.key});

  @override
  State<Addfitpage> createState() => _AddfitpageState();
}

class _AddfitpageState extends State<Addfitpage> {
  final TextEditingController _captionController = TextEditingController();
  File? _selectedMedia;
  bool _isVideo = false;
  final ImagePicker _picker = ImagePicker();
  bool _isPosting = false;

  Future<void> _pickMedia(bool isVideo) async {
    final XFile? media = isVideo
        ? await _picker.pickVideo(source: ImageSource.gallery)
        : await _picker.pickImage(source: ImageSource.gallery);

    if (media != null) {
      setState(() {
        _selectedMedia = File(media.path);
        _isVideo = isVideo;
      });
    }
  }

  void _postContent() {
    if (_selectedMedia == null && _captionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add media or a caption')),
      );
      return;
    }

    setState(() {
      _isPosting = true;
    });

    // Simulate network request
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isPosting = false;
          _selectedMedia = null;
          _captionController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post uploaded successfully!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post", style: AppWidget.boldTextFieledStyle()),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: _isPosting ? null : _postContent,
            child: const Text(
              'Post',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isPosting)
              const LinearProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Text(
                  "Flex Apparel",
                  style: AppWidget.boldTextFieledStyle(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _captionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "What's new with your brand?",
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedMedia != null)
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                      image: _isVideo
                          ? null
                          : DecorationImage(
                              image: FileImage(_selectedMedia!),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: _isVideo
                        ? const Center(
                            child: Icon(Icons.play_circle_outline,
                                size: 60, color: Colors.white),
                          )
                        : null,
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedMedia = null;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.image, color: Colors.green),
              title: const Text("Photo"),
              onTap: () => _pickMedia(false),
            ),
            ListTile(
              leading: const Icon(Icons.videocam, color: Colors.red),
              title: const Text("Video"),
              onTap: () => _pickMedia(true),
            ),
          ],
        ),
      ),
    );
  }
}