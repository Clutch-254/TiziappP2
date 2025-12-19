import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tiziappp2/presentation/pages/notificationsus.dart';
import 'dart:math' show pi;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tiziappp2/presentation/pages/settingsus.dart';
import 'package:tiziappp2/technicals/services/nutrition_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:tiziappp2/technicals/services/post_service.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class Profile extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final Color backgroundColor;

  const Profile({
    Key? key,
    this.onDateSelected,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late DateTime _selectedDate;
  late List<DateTime> _weekDays;
  late PageController _pageController;
  int _selectedIconIndex = 0; // Set the food icon as the default selected icon

  // Animation controller for the AI assistant drawer
  late AnimationController _drawerAnimationController;
  late Animation<double> _drawerAnimation;
  bool _isDrawerOpen = false;
  File? _profileImage;
  final _picker = ImagePicker();

  String _userName = "user_profile";
  final PostService _postService = PostService();
  List<Map<String, dynamic>> _myPosts = [];
  bool _isLoadingPosts = true;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _pageController = PageController(initialPage: 0);
    _generateWeekDays(DateTime.now());

    // Initialize the drawer animation controller
    _drawerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _drawerAnimation = CurvedAnimation(
      parent: _drawerAnimationController,
      curve: Curves.easeInOut,
    );
    _loadSavedName();
    _loadSavedProfilePicture();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() => _isLoadingPosts = true);
    try {
      final posts = await _postService.getMyPosts();
      if (mounted) {
        setState(() {
          _myPosts = posts;
          _isLoadingPosts = false;
        });
      }
    } catch (e) {
      print("Error loading posts: $e");
      if (mounted) setState(() => _isLoadingPosts = false);
    }
  }

  Future<void> _createPost() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Create New Post",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOption(Icons.camera_alt, "Camera", () => _pickMedia(ImageSource.camera, false)),
                _buildOption(Icons.videocam, "Video", () => _pickMedia(ImageSource.camera, true)),
                _buildOption(Icons.photo_library, "Gallery", () => _pickMedia(ImageSource.gallery, false)),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: Colors.blue),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Future<void> _pickMedia(ImageSource source, bool isVideo) async {
    try {
      final XFile? file = isVideo 
          ? await _picker.pickVideo(source: source)
          : await _picker.pickImage(source: source);

      if (file != null) {
        _showPostDialog(File(file.path), isVideo);
      }
    } catch (e) {
      print("Error picking media: $e");
    }
  }

  void _showPostDialog(File file, bool isVideo) {
    final captionController = TextEditingController();
    String privacy = 'public';
    String? thumbnailPath;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text("New Post"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: isVideo
                      ? Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                      : Image.file(file, fit: BoxFit.contain),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: captionController,
                  decoration: InputDecoration(
                    hintText: "Write a caption...",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text("Privacy: "),
                    DropdownButton<String>(
                      value: privacy,
                      items: [
                        DropdownMenuItem(value: 'public', child: Text("Public")),
                        DropdownMenuItem(value: 'private', child: Text("Gym Bros Only")),
                      ],
                      onChanged: (val) => setState(() => privacy = val!),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Generate thumbnail for video
                  if (isVideo) {
                    final uint8list = await VideoThumbnail.thumbnailData(
                      video: file.path,
                      imageFormat: ImageFormat.JPEG,
                      maxWidth: 200,
                      quality: 75,
                    );
                    if (uint8list != null) {
                      final tempDir = await getTemporaryDirectory();
                      final thumbFile = await File('${tempDir.path}/thumb_${DateTime.now().millisecondsSinceEpoch}.jpg').create();
                      await thumbFile.writeAsBytes(uint8list);
                      thumbnailPath = thumbFile.path;
                    }
                  }

                  // Save media
                  final savedPath = await _postService.saveMediaFile(
                    file, 
                    isVideo ? 'video' : 'image'
                  );

                  // Create post
                  await _postService.createPost(
                    mediaPath: savedPath,
                    mediaType: isVideo ? 'video' : 'image',
                    caption: captionController.text,
                    privacy: privacy,
                    thumbnailPath: thumbnailPath,
                  );

                  Navigator.pop(context);
                  _loadPosts(); // Refresh list
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Post created successfully!")),
                  );
                } catch (e) {
                  print("Error creating post: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error creating post")),
                  );
                }
              },
              child: Text("Post"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadSavedProfilePicture() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');
    if (imagePath != null) {
      final file = File(imagePath);
      if (await file.exists()) {
        setState(() {
          _profileImage = file;
        });
      }
    }
  }

  Future<void> _saveProfilePicture(File image) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final savedImage = await image.copy('${appDir.path}/$fileName');
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', savedImage.path);
    
    setState(() {
      _profileImage = savedImage;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _drawerAnimationController.dispose();
    super.dispose();
  }

  void _generateWeekDays(DateTime date) {
    // Find the start of the week (Monday)
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday - 1));

    _weekDays = List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });
  }

  Future<void> _loadSavedName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? "user_profile";
    });
  }

  Future<void> _saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
  }

  void _navigateToWeek(int direction) {
    setState(() {
      DateTime newDate = _selectedDate.add(Duration(days: 7 * direction));
      _selectedDate = newDate;
      _generateWeekDays(newDate);
    });
  }

  // Toggle the AI drawer
  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
      if (_isDrawerOpen) {
        _drawerAnimationController.forward();
      } else {
        _drawerAnimationController.reverse();
      }
    });
  }

  // Show music dialog
  void _showMusicDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MusicPlayerDialog();
      },
    );
  }

// Update the _showNameEditDialog method to save the name
  void _showNameEditDialog() {
    TextEditingController _nameController =
        TextEditingController(text: _userName);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Profile Name"),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "Enter your name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final newName = _nameController.text.trim().isNotEmpty
                    ? _nameController.text.trim()
                    : "user_profile";

                setState(() {
                  _userName = newName;
                });

                _saveName(newName);
                Navigator.pop(context);
              },
              child: Text("Save"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Options
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildImagePickerOption(
                      context,
                      icon: Icons.camera_alt,
                      title: "Take Photo",
                      onTap: () {
                        _getImageFromCamera();
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 16),
                    _buildImagePickerOption(
                      context,
                      icon: Icons.photo_library,
                      title: "Choose from Gallery",
                      onTap: () {
                        _getImageFromGallery();
                        Navigator.pop(context);
                      },
                    ),
                    if (_profileImage != null) ...[
                      SizedBox(height: 16),
                      _buildImagePickerOption(
                        context,
                        icon: Icons.delete,
                        title: "Remove Photo",
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('profile_image_path');
                          setState(() {
                            _profileImage = null;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImagePickerOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Icon(Icons.chevron_right, color: Colors.white70),
          ],
        ),
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _saveProfilePicture(File(pickedFile.path));
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _saveProfilePicture(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3),
                        child: GestureDetector(
                          onTap: _showImagePickerOptions,
                          child: Material(
                            elevation: 0,
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(60),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Container(
                                height: 90,
                                width: 90,
                                color: Colors.grey[200],
                                child: _profileImage != null
                                    ? Image.file(
                                        _profileImage!,
                                        fit: BoxFit.cover,
                                      )
                                    : Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey[800],
                                          size: 40,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3 - 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _userName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(width: 8),
                            // Edit icon button
                            GestureDetector(
                              onTap: _showNameEditDialog,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3 + 100),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildIconButton(
                                    0, Icons.fastfood), // Food icon
                                SizedBox(width: 40),
                                _buildIconButton(
                                    1, Icons.access_time), // Clock icon
                                SizedBox(width: 40),
                                _buildIconButton(
                                    2, Icons.contacts), // Phonebook icon
                                SizedBox(width: 40),
                                _buildIconButton(
                                    3, Icons.bar_chart), // Bar graph icon
                                SizedBox(width: 40),
                                _buildIconButton(4, Icons.videocam),
                              ],
                            ),

                            // Add the nutrition donut chart if the food icon is selected
                            if (_selectedIconIndex == 0)
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Column(
                                  children: [
                                    NutritionInfoSection(),
                                    SizedBox(height: 30),
                                    CaloriesBalanceSection(),
                                    SizedBox(height: 30),
                                    SupplementIntakeSection(),
                                    SizedBox(height: 50),
                                  ],
                                ),
                              ),
                            // Show today's routine if the clock icon is selected
                            if (_selectedIconIndex == 1)
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Today's Routine",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    WorkoutRoutine(selectedDate: _selectedDate),
                                  ],
                                ),
                              ),
                            // Show trainer, nutritionist, and gym sections if the phonebook icon is selected
                            if (_selectedIconIndex == 2)
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Column(
                                  children: [
                                    SubscriptionsSection(),
                                  ],
                                ),
                              ),
                            // Show weight gain bar graph if the bar graph icon is selected
                            if (_selectedIconIndex == 3)
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Weight Gain Progress",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    WeightGainBarGraph(),

                                    SizedBox(
                                        height:
                                            30), // Add spacing between the graphs
                                    Text(
                                      "Weight Loss Progress",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    WeightLossBarGraph(),
                                  ],
                                ),
                              ),
                            // Show media gallery if the camera icon is selected
                            if (_selectedIconIndex == 4)
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: MediaGallerySection(),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8, bottom: 16),
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.chevron_left,
                                      color: Colors.grey),
                                  onPressed: () => _navigateToWeek(-1),
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                ),
                                Text(
                                  DateFormat('MMMM yyyy').format(_weekDays[0]),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.chevron_right,
                                      color: Colors.grey),
                                  onPressed: () => _navigateToWeek(1),
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _weekDays.map((day) {
                              bool isToday = _isToday(day);
                              bool isSelected = _isSameDay(day, _selectedDate);

                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        _selectedDate = day;
                                        if (widget.onDateSelected != null) {
                                          widget.onDateSelected!(day);
                                        }
                                      },
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        DateFormat('E')
                                            .format(day)
                                            .substring(0, 3),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: isSelected
                                              ? Colors.grey
                                              : Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isSelected
                                              ? Colors.grey
                                              : isToday
                                                  ? Colors.grey.withOpacity(0.1)
                                                  : Colors.transparent,
                                        ),
                                        child: Center(
                                          child: Text(
                                            day.day.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: isToday || isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: isSelected
                                                  ? Colors.white
                                                  : isToday
                                                      ? Colors.grey
                                                      : Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Music button (new)
                    Positioned(
                      top: MediaQuery.of(context).size.height / 5,
                      left: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.music_note, // Music icon
                            color: Colors.white,
                            size: 26,
                          ),
                          onPressed: _showMusicDialog,
                          tooltip: "Music Player",
                        ),
                      ),
                    ),

                    // AI Assistant icon (robot) - moved to the right of Music button
                    Positioned(
                      top: MediaQuery.of(context).size.height / 5,
                      left: 70, // Moved to make room for music button
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.smart_toy_outlined, // Robot icon
                            color: Colors.white,
                            size: 26,
                          ),
                          onPressed: _toggleDrawer,
                          tooltip: "AI Assistant",
                        ),
                      ),
                    ),

                    // Settings icon in the top right corner
                    Positioned(
                      top: MediaQuery.of(context).size.height / 5,
                      right: 70,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 26,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Settinguser()),
                            );
                          },
                          tooltip: "Settings",
                        ),
                      ),
                    ),
                    // Message icon in the top right under the calendar
                    Positioned(
                      top: MediaQuery.of(context).size.height / 5,
                      right: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.message,
                            color: Colors.white,
                            size: 26,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Notificationsus()),
                            );
                          },
                          tooltip: "Messages",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // AI Assistant Drawer (slides from left)
          AnimatedBuilder(
            animation: _drawerAnimation,
            builder: (context, child) {
              return Positioned(
                left:
                    _drawerAnimation.value * 300 - 300, // Slide from -300 to 0
                top: 0,
                bottom: 0,
                width: 300,
                child: AIAssistantDrawer(
                  onClose: _toggleDrawer,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper method to build an icon button
  Widget _buildIconButton(int index, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIconIndex = index; // Update the selected icon index
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              _selectedIconIndex == index ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
          border: _selectedIconIndex == index
              ? Border.all(color: Colors.grey, width: 2)
              : null,
        ),
        child: Icon(
          icon,
          size: 30,
          color: _selectedIconIndex == index ? Colors.black : Colors.white70,
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isMonday(DateTime date) {
    return date.weekday == DateTime.monday;
  }

  bool _isThursday(DateTime date) {
    return date.weekday == DateTime.thursday;
  }
}

// AI Assistant Drawer Widget with enhanced functionality
class AIAssistantDrawer extends StatefulWidget {
  final VoidCallback onClose;

  const AIAssistantDrawer({Key? key, required this.onClose}) : super(key: key);

  @override
  _AIAssistantDrawerState createState() => _AIAssistantDrawerState();
}

class _AIAssistantDrawerState extends State<AIAssistantDrawer> {
  TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _chatMessages = [];
  bool _isLoading = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Add a welcome message
    _chatMessages.add({
      'isUser': false,
      'message': "Hi, I'm Tizi AI. How can I help you today?",
      'timestamp': DateTime.now(),
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Method to send a message
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    // Add user message to chat
    setState(() {
      _chatMessages.add({
        'isUser': true,
        'message': _messageController.text,
        'timestamp': DateTime.now(),
      });

      // Simulate AI thinking
      _isLoading = true;
    });

    // Clear input field
    _messageController.clear();

    // Scroll to bottom
    _scrollToBottom();

    // Simulate AI response after a short delay
    Future.delayed(Duration(seconds: 1), () {
      String userMessage =
          _chatMessages.last['message'].toString().toLowerCase();
      String aiResponse = _generateAIResponse(userMessage);

      setState(() {
        _chatMessages.add({
          'isUser': false,
          'message': aiResponse,
          'timestamp': DateTime.now(),
        });
        _isLoading = false;
      });

      // Scroll to bottom again after response
      _scrollToBottom();
    });
  }

  // Helper method to generate AI responses
  String _generateAIResponse(String userMessage) {
    if (userMessage.contains('workout') || userMessage.contains('exercise')) {
      return "Based on your profile, I'd recommend focusing on compound exercises today. Would you like me to suggest some specific exercises?";
    } else if (userMessage.contains('diet') ||
        userMessage.contains('nutrition')) {
      return "Your nutrition records show you're at 1850 calories today. Would you like some meal suggestions?";
    } else if (userMessage.contains('progress') ||
        userMessage.contains('weight')) {
      return "Looking at your progress charts, you're on track with your goals. Keep up the good work!";
    } else {
      return "I understand you're asking about \"$userMessage\". How can I assist you further?";
    }
  }

  // Scroll to the bottom of the chat
  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Header with title and close button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tizi AI",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.grey[600]),
                    onPressed: widget.onClose,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey[300]),

            // Chat messages area
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(16),
                itemCount: _chatMessages.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_isLoading && index == _chatMessages.length) {
                    return _buildLoadingBubble();
                  }

                  final message = _chatMessages[index];
                  final isUser = message['isUser'] as bool;

                  return _buildChatBubble(
                    message: message['message'] as String,
                    isUser: isUser,
                    timestamp: message['timestamp'] as DateTime,
                  );
                },
              ),
            ),

            // Input area
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Plus button for media options
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.grey[800]),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => MediaOptionsSheet(),
                          isScrollControlled: true,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Ask something...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.grey[800]),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Chat bubble widget
  Widget _buildChatBubble({
    required String message,
    required bool isUser,
    required DateTime timestamp,
  }) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? Colors.grey[800] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              DateFormat('h:mm a').format(timestamp),
              style: TextStyle(
                color: isUser ? Colors.white70 : Colors.grey[600],
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Loading bubble widget
  Widget _buildLoadingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Tizi AI is typing...",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Media Options Bottom Sheet
class MediaOptionsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Options
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildOption(
                  context,
                  icon: Icons.camera_alt,
                  title: "Take Photo",
                  onTap: () {
                    // Implement camera functionality
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 16),
                _buildOption(
                  context,
                  icon: Icons.videocam,
                  title: "Record Video",
                  onTap: () {
                    // Implement video recording functionality
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 16),
                _buildOption(
                  context,
                  icon: Icons.photo_library,
                  title: "Choose from Gallery",
                  onTap: () {
                    // Implement gallery picker functionality
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 16),
                _buildOption(
                  context,
                  icon: Icons.mic,
                  title: "Voice Recording",
                  onTap: () {
                    // Implement voice recording functionality
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.grey[800], size: 24),
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            Spacer(),
            Icon(Icons.chevron_right, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}

// Music Player Dialog
class MusicPlayerDialog extends StatefulWidget {
  @override
  _MusicPlayerDialogState createState() => _MusicPlayerDialogState();
}

class _MusicPlayerDialogState extends State<MusicPlayerDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();
  bool _isPlaying = false;
  String _currentTrack = "No track selected";

  // Sample music library data
  final List<Map<String, dynamic>> _musicLibrary = [
    {
      'title': 'Workout Energy Boost',
      'artist': 'Fitness Beats',
      'duration': '3:45',
      'isPlaylist': false,
    },
    {
      'title': 'Cardio Session Mix',
      'artist': 'Running Tracks',
      'duration': '4:12',
      'isPlaylist': false,
    },
    {
      'title': 'Power Lifting Anthems',
      'artist': 'Gym Heroes',
      'duration': '3:30',
      'isPlaylist': true,
      'tracks': 12,
    },
    {
      'title': 'Meditation & Stretching',
      'artist': 'Zen Fitness',
      'duration': '5:20',
      'isPlaylist': false,
    },
    {
      'title': 'HIIT Training Mix',
      'artist': 'Interval Masters',
      'duration': '2:45',
      'isPlaylist': false,
    },
    {
      'title': 'Workout Motivation',
      'artist': 'Fitness Gurus',
      'duration': '4:05',
      'isPlaylist': true,
      'tracks': 8,
    },
    {
      'title': 'Cool Down Session',
      'artist': 'Recovery Beats',
      'duration': '6:10',
      'isPlaylist': false,
    },
  ];

  List<Map<String, dynamic>> _filteredMusic = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _filteredMusic = List.from(_musicLibrary);

    _searchController.addListener(() {
      _filterMusic();
    });
  }

  void _filterMusic() {
    if (_searchController.text.isEmpty) {
      setState(() {
        _filteredMusic = List.from(_musicLibrary);
      });
    } else {
      setState(() {
        _filteredMusic = _musicLibrary
            .where((music) =>
                music['title']
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) ||
                music['artist']
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // Header with close button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Music Player",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.grey[600]),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.grey[800],
              unselectedLabelColor: Colors.grey[500],
              indicatorColor: Colors.grey[800],
              tabs: [
                Tab(text: "My Library"),
                Tab(text: "Search"),
                Tab(text: "Add Music"),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // My Library Tab
                _buildLibraryTab(),

                // Search Tab
                _buildSearchTab(),

                // Add Music Tab
                _buildAddMusicTab(),
              ],
            ),
          ),

          // Player controls at the bottom
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Track info
                    Expanded(
                      child: Text(
                        _currentTrack,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Controls
                    IconButton(
                      icon: Icon(Icons.skip_previous, color: Colors.grey[600]),
                      onPressed: () {
                        // Previous track functionality
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: Colors.grey[800],
                        size: 40,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next, color: Colors.grey[600]),
                      onPressed: () {
                        // Next track functionality
                      },
                    ),
                  ],
                ),

                // Progress bar
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LinearProgressIndicator(
                    value: 0.3, // Sample progress value
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.grey[700]!),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // My Library Tab
  Widget _buildLibraryTab() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16),
      itemCount: _musicLibrary.length,
      itemBuilder: (context, index) {
        final music = _musicLibrary[index];
        return _buildMusicListItem(music);
      },
    );
  }

  // Search Tab
  Widget _buildSearchTab() {
    return Column(
      children: [
        // Search input
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search music...",
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey[700]!),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
        ),

        // Search results
        Expanded(
          child: _filteredMusic.isEmpty
              ? Center(
                  child: Text(
                    "No results found",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemCount: _filteredMusic.length,
                  itemBuilder: (context, index) {
                    final music = _filteredMusic[index];
                    return _buildMusicListItem(music);
                  },
                ),
        ),
      ],
    );
  }

  // Add Music Tab
  Widget _buildAddMusicTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_circle_outline,
          size: 80,
          color: Colors.grey[400],
        ),
        SizedBox(height: 20),
        Text(
          "Add Music from Your Device",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          icon: Icon(Icons.folder_open),
          label: Text("Browse Files"),
          onPressed: () {
            // File browsing functionality
            print("Browse music files");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () {
            // Import from other apps functionality
            print("Import from other apps");
          },
          child: Text(
            "Import from other apps",
            style: TextStyle(
              color: Colors.grey[700],
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build a music item in the list
  Widget _buildMusicListItem(Map<String, dynamic> music) {
    final isPlaylist = music['isPlaylist'] ?? false;

    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          isPlaylist ? Icons.playlist_play : Icons.music_note,
          color: Colors.grey[700],
          size: 30,
        ),
      ),
      title: Text(
        music['title'],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.grey[800],
        ),
      ),
      subtitle: Text(
        isPlaylist
            ? "${music['tracks']} tracks · ${music['artist']}"
            : "${music['duration']} · ${music['artist']}",
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.play_circle_outline, color: Colors.grey[700]),
            onPressed: () {
              setState(() {
                _isPlaying = true;
                _currentTrack = "${music['title']} - ${music['artist']}";
              });
              // Play music functionality
              print("Play: ${music['title']}");
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.grey[600]),
            onPressed: () {
              // Show more options for this music
              print("More options for: ${music['title']}");
            },
          ),
        ],
      ),
      onTap: () {
        setState(() {
          _currentTrack = "${music['title']} - ${music['artist']}";
          _isPlaying = true;
        });
        // Select music functionality
        print("Selected: ${music['title']}");
      },
    );
  }
}

// Media Gallery Section for photos and videos
class MediaGallerySection extends StatefulWidget {
  @override
  _MediaGallerySectionState createState() => _MediaGallerySectionState();
}

class _MediaGallerySectionState extends State<MediaGallerySection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PostService _postService = PostService();
  List<Map<String, dynamic>> _myPosts = [];
  bool _isLoadingPosts = true;

  // Sample data for images
  final List<Map<String, dynamic>> _mediaItems = [
    {
      'type': 'image',
      'title': 'Week 1 Progress',
      'date': 'Jan 05, 2025',
      'likes': 24,
      'comments': 5,
    },
    {
      'type': 'video',
      'title': 'Deadlift Form Check',
      'date': 'Jan 12, 2025',
      'duration': '0:45',
      'likes': 38,
      'comments': 12,
    },
    {
      'type': 'image',
      'title': 'Month 2 Progress',
      'date': 'Feb 28, 2025',
      'likes': 56,
      'comments': 8,
    },
    {
      'type': 'video',
      'title': 'Squat PR 315lbs',
      'date': 'Feb 05, 2025',
      'duration': '1:20',
      'likes': 72,
      'comments': 15,
    },
    {
      'type': 'image',
      'title': 'Month 3 Progress',
      'date': 'Mar 30, 2025',
      'likes': 43,
      'comments': 7,
    },
    {
      'type': 'video',
      'title': 'Bench Press Form',
      'date': 'Mar 10, 2025',
      'duration': '0:55',
      'likes': 35,
      'comments': 9,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() => _isLoadingPosts = true);
    try {
      final posts = await _postService.getMyPosts();
      if (mounted) {
        setState(() {
          _myPosts = posts;
          _isLoadingPosts = false;
        });
      }
    } catch (e) {
      print("Error loading posts: $e");
      if (mounted) setState(() => _isLoadingPosts = false);
    }
  }

  Future<void> _createPost() async {
    // Implementation for creating posts
    // This can be added later if needed
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Progress Gallery",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: Colors.grey[800]),
                onPressed: _createPost,
                tooltip: "Add new",
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.grey[800],
            unselectedLabelColor: Colors.grey[500],
            indicatorColor: Colors.grey[800],
            tabs: [
              Tab(text: "All"),
              Tab(text: "Videos"),
            ],
          ),
        ),
        SizedBox(height: 16),
        // Grid of media items
        Container(
          height: 500, // Fixed height for the grid
          child: _isLoadingPosts
              ? Center(child: CircularProgressIndicator())
              : TabBarView(
                  controller: _tabController,
                  children: [
                    // All tab
                    _buildMediaGrid(_myPosts),
                    // Videos tab
                    _buildMediaGrid(_myPosts
                        .where((item) => item['mediaType'] == 'video')
                        .toList()),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildMediaGrid(List<Map<String, dynamic>> items) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildMediaItem(item);
      },
    );
  }

  Widget _buildMediaItem(Map<String, dynamic> item) {
    bool isVideo = item['mediaType'] == 'video';
    final mediaPath = item['mediaPath'];
    final thumbnailPath = item['thumbnailPath'];
    final file = File(mediaPath);

    return GestureDetector(
      onTap: () {
        // Show full screen view or delete option
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: isVideo 
              ? Icon(Icons.play_circle_outline, size: 50) 
              : Image.file(file),
            actions: [
              TextButton(
                onPressed: () async {
                  await _postService.deletePost(item['id']);
                  Navigator.pop(context);
                  _loadPosts();
                },
                child: Text("Delete", style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
            ],
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          image: !isVideo && file.existsSync()
              ? DecorationImage(image: FileImage(file), fit: BoxFit.cover)
              : null,
        ),
        child: isVideo
            ? Stack(
                alignment: Alignment.center,
                children: [
                  if (thumbnailPath != null && File(thumbnailPath).existsSync())
                    Image.file(File(thumbnailPath), fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                  Container(
                    color: Colors.black26,
                    child: Icon(Icons.play_circle_fill, color: Colors.white, size: 40),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}

// Custom Painter for Donut Chart (Nutrition)
class DonutChartPainter extends CustomPainter {
  final double proteins;
  final double carbs;
  final double fats;
  final double vitamins;
  final double minerals;

  DonutChartPainter({
    this.proteins = 0,
    this.carbs = 0,
    this.fats = 0,
    this.vitamins = 0,
    this.minerals = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final innerRadius = radius * 0.6; // Size of the donut hole

    // Define the colors as specified
    final proteinColor = Colors.cyanAccent;
    final carbsColor = Colors.greenAccent;
    final fatsColor = Colors.orangeAccent;
    final vitaminsColor = Colors.purpleAccent;
    final mineralsColor = Colors.pinkAccent;

    // Calculate total
    final total = proteins + carbs + fats + vitamins + minerals;
    
    // Calculate percentages (avoid division by zero)
    final proteinPercent = total > 0 ? proteins / total : 0.0;
    final carbsPercent = total > 0 ? carbs / total : 0.0;
    final fatsPercent = total > 0 ? fats / total : 0.0;
    final vitaminsPercent = total > 0 ? vitamins / total : 0.0;
    final mineralsPercent = total > 0 ? minerals / total : 0.0;

    // Paint configurations
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius - innerRadius;

    // Starting angle is -pi/2 (top of the circle)
    double startAngle = -pi / 2;

    // If total is 0, draw a placeholder ring
    if (total == 0) {
      paint.color = Colors.white24;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
        0,
        2 * pi,
        false,
        paint,
      );
      return;
    }

    // Draw protein section
    if (proteinPercent > 0) {
      paint.color = proteinColor;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
        startAngle,
        2 * pi * proteinPercent,
        false,
        paint,
      );
      startAngle += 2 * pi * proteinPercent;
    }

    // Draw carbs section
    if (carbsPercent > 0) {
      paint.color = carbsColor;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
        startAngle,
        2 * pi * carbsPercent,
        false,
        paint,
      );
      startAngle += 2 * pi * carbsPercent;
    }

    // Draw fats section
    if (fatsPercent > 0) {
      paint.color = fatsColor;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
        startAngle,
        2 * pi * fatsPercent,
        false,
        paint,
      );
      startAngle += 2 * pi * fatsPercent;
    }

    // Draw vitamins section
    if (vitaminsPercent > 0) {
      paint.color = vitaminsColor;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
        startAngle,
        2 * pi * vitaminsPercent,
        false,
        paint,
      );
      startAngle += 2 * pi * vitaminsPercent;
    }

    // Draw minerals section
    if (mineralsPercent > 0) {
      paint.color = mineralsColor;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
        startAngle,
        2 * pi * mineralsPercent,
        false,
        paint,
      );
      startAngle += 2 * pi * mineralsPercent;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Custom Painter for Calories Balance Chart
class CaloriesBalanceChartPainter extends CustomPainter {
  final int consumed;
  final int burned;

  CaloriesBalanceChartPainter({
    required this.consumed,
    required this.burned,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final innerRadius = radius * 0.6; // Size of the donut hole

    // Define the colors
    final consumedColor = Colors.orangeAccent; // Bright orange for calories consumed
    final burnedColor = Colors.lightBlueAccent; // Bright blue for calories burned

    // Calculate percentages
    final total = consumed + burned.toDouble();
    final consumedPercent = consumed / total;
    final burnedPercent = burned / total;

    // Paint configurations
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius - innerRadius;

    // Starting angle is -pi/2 (top of the circle)
    double startAngle = -pi / 2;

    // Draw consumed section
    paint.color = consumedColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * consumedPercent,
      false,
      paint,
    );
    startAngle += 2 * pi * consumedPercent;

    // Draw burned section
    paint.color = burnedColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (paint.strokeWidth / 2)),
      startAngle,
      2 * pi * burnedPercent,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Supplement Intake Section with daily checkboxes
class SupplementIntakeSection extends StatefulWidget {
  @override
  _SupplementIntakeSectionState createState() =>
      _SupplementIntakeSectionState();
}

class _SupplementIntakeSectionState extends State<SupplementIntakeSection> {
  final NutritionService _nutritionService = NutritionService();
  Map<String, bool> supplementStatus = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final status = await _nutritionService.getTodaySupplementStatus();
    if (mounted) {
      setState(() {
        supplementStatus = status;
      });
    }
  }

  void _showAddSupplementDialog() {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Supplement"),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: "Supplement Name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                await _nutritionService.addCustomSupplement(nameController.text);
                _loadData();
                Navigator.pop(context);
              }
            },
            child: Text("Add"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Supplement Intake",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle, color: Colors.black),
                onPressed: _showAddSupplementDialog,
                tooltip: "Add Supplement",
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "Track your daily supplements. Checkboxes reset every 24 hours.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 16),
          if (supplementStatus.isEmpty)
            Text("No supplements added yet.", style: TextStyle(color: Colors.grey)),
          ...supplementStatus.keys
              .map((supplement) => _buildSupplementCheckbox(supplement))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildSupplementCheckbox(String supplement) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Remove Supplement"),
              content: Text("Do you want to remove '$supplement' from your list?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    await _nutritionService.removeSupplement(supplement);
                    _loadData();
                    Navigator.pop(context);
                  },
                  child: Text("Remove", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        },
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: supplementStatus[supplement],
                onChanged: (bool? value) async {
                  if (value != null) {
                    await _nutritionService.toggleSupplement(supplement, value);
                    setState(() {
                      supplementStatus[supplement] = value;
                    });
                  }
                },
                activeColor: Colors.white,
                checkColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                supplement,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  decoration: supplementStatus[supplement]!
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            Text(
              supplementStatus[supplement]! ? "Taken" : "Not taken",
              style: TextStyle(
                fontSize: 14,
                color: supplementStatus[supplement]!
                    ? Colors.green[700]
                    : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Weight Gain Bar Graph Widget
class WeightGainBarGraph extends StatefulWidget {
  @override
  _WeightGainBarGraphState createState() => _WeightGainBarGraphState();
}

class _WeightGainBarGraphState extends State<WeightGainBarGraph> {
  final NutritionService _nutritionService = NutritionService();
  List<double> monthlyWeightGain = [];
  List<String> months = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeightGainData();
  }

  Future<void> _loadWeightGainData() async {
    try {
      final gainData = await _nutritionService.getMonthlyWeightGainData();
      final monthLabels = _nutritionService.getMonthLabels();
      
      if (mounted) {
        setState(() {
          monthlyWeightGain = gainData;
          months = monthLabels;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading weight gain data: $e');
      if (mounted) {
        setState(() {
          monthlyWeightGain = List.filled(12, 0.0);
          months = _nutritionService.getMonthLabels();
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        padding: EdgeInsets.all(16),
        height: 250,
        width: MediaQuery.of(context).size.width * 0.85,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.grey[800],
          ),
        ),
      );
    }

    // Calculate the maximum weight gain for Y-axis scaling
    double maxWeightGain = monthlyWeightGain.isEmpty
        ? 1.0
        : monthlyWeightGain.reduce((curr, next) => curr > next ? curr : next);
    
    // Ensure minimum scale
    if (maxWeightGain < 0.1) maxWeightGain = 1.0;

    return Container(
      padding: EdgeInsets.all(16),
      height: 250, // Graph height
      width: MediaQuery.of(context).size.width * 0.85, // Graph width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weight Gained (kg) by Month",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-axis labels
                Container(
                  width: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${maxWeightGain.toStringAsFixed(1)}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                      Text("${(maxWeightGain * 0.75).toStringAsFixed(1)}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                      Text("${(maxWeightGain * 0.5).toStringAsFixed(1)}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                      Text("${(maxWeightGain * 0.25).toStringAsFixed(1)}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                      Text("0.0",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                // Graph area
                Expanded(
                  child: Container(
                    height: 180,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: BarGraphPainter(
                          monthlyWeightGain: monthlyWeightGain,
                          maxWeightGain: maxWeightGain),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // X-axis labels
          Container(
            margin: EdgeInsets.only(left: 38), // Align with bars
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: months
                  .map((month) => Expanded(
                        child: Text(
                          month,
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the bar graph
class BarGraphPainter extends CustomPainter {
  final List<double> monthlyWeightGain;
  final double maxWeightGain;

  BarGraphPainter({
    required this.monthlyWeightGain,
    required this.maxWeightGain,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / (monthlyWeightGain.length * 1.5);
    final barMargin = barWidth / 2;
    final height = size.height;

    // Drawing horizontal grid lines
    final gridPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = height - (height * (i / 4));
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Drawing bars
    final barPaint = Paint()
      ..color = Colors.grey[600]!
      ..style = PaintingStyle.fill;

    for (int i = 0; i < monthlyWeightGain.length; i++) {
      final barHeight = (monthlyWeightGain[i] / maxWeightGain) * height;
      final barLeft = i * ((barWidth + barMargin) * 1.5);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            barLeft,
            height - barHeight,
            barWidth,
            barHeight,
          ),
          Radius.circular(4),
        ),
        barPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Weight Loss Bar Graph Widget
class WeightLossBarGraph extends StatefulWidget {
  @override
  _WeightLossBarGraphState createState() => _WeightLossBarGraphState();
}

class _WeightLossBarGraphState extends State<WeightLossBarGraph> {
  final NutritionService _nutritionService = NutritionService();
  List<double> monthlyWeightLoss = [];
  List<String> months = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeightLossData();
  }

  Future<void> _loadWeightLossData() async {
    try {
      final lossData = await _nutritionService.getMonthlyWeightLossData();
      final monthLabels = _nutritionService.getMonthLabels();
      
      if (mounted) {
        setState(() {
          monthlyWeightLoss = lossData;
          months = monthLabels;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading weight loss data: $e');
      if (mounted) {
        setState(() {
          monthlyWeightLoss = List.filled(12, 0.0);
          months = _nutritionService.getMonthLabels();
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        padding: EdgeInsets.all(16),
        height: 250,
        width: MediaQuery.of(context).size.width * 0.85,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.grey[800],
          ),
        ),
      );
    }

    // Calculate the maximum weight loss for Y-axis scaling
    double maxWeightLoss = monthlyWeightLoss.isEmpty
        ? 1.0
        : monthlyWeightLoss.reduce((curr, next) => curr > next ? curr : next);
    
    // Ensure minimum scale
    if (maxWeightLoss < 0.1) maxWeightLoss = 1.0;

    return Container(
      padding: EdgeInsets.all(16),
      height: 250, // Graph height
      width: MediaQuery.of(context).size.width * 0.85, // Graph width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weight Lost (kg) by Month",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-axis labels
                Container(
                  width: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${maxWeightLoss.toStringAsFixed(1)}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                      Text("${(maxWeightLoss * 0.75).toStringAsFixed(1)}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                      Text("${(maxWeightLoss * 0.5).toStringAsFixed(1)}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                      Text("${(maxWeightLoss * 0.25).toStringAsFixed(1)}",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                      Text("0.0",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700])),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                // Graph area
                Expanded(
                  child: Container(
                    height: 180,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: LossBarGraphPainter(
                          monthlyWeightLoss: monthlyWeightLoss,
                          maxWeightLoss: maxWeightLoss),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // X-axis labels
          Container(
            margin: EdgeInsets.only(left: 38), // Align with bars
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: months
                  .map((month) => Expanded(
                        child: Text(
                          month,
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the weight loss bar graph
class LossBarGraphPainter extends CustomPainter {
  final List<double> monthlyWeightLoss;
  final double maxWeightLoss;

  LossBarGraphPainter({
    required this.monthlyWeightLoss,
    required this.maxWeightLoss,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / (monthlyWeightLoss.length * 1.5);
    final barMargin = barWidth / 2;
    final height = size.height;

    // Drawing horizontal grid lines
    final gridPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = height - (height * (i / 4));
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Drawing bars with fainter grey color
    final barPaint = Paint()
      ..color = Colors.grey[350]! // Fainter grey for weight loss
      ..style = PaintingStyle.fill;

    for (int i = 0; i < monthlyWeightLoss.length; i++) {
      final barHeight = (monthlyWeightLoss[i] / maxWeightLoss) * height;
      final barLeft = i * ((barWidth + barMargin) * 1.5);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            barLeft,
            height - barHeight,
            barWidth,
            barHeight,
          ),
          Radius.circular(4),
        ),
        barPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// New Workout Routine Widget
class WorkoutRoutine extends StatefulWidget {
  final DateTime selectedDate;

  WorkoutRoutine({required this.selectedDate});

  @override
  _WorkoutRoutineState createState() => _WorkoutRoutineState();
}

class _WorkoutRoutineState extends State<WorkoutRoutine> {
  final NutritionService _nutritionService = NutritionService();
  List<Map<String, dynamic>> workouts = [];

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  @override
  void didUpdateWidget(WorkoutRoutine oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      _loadWorkouts();
    }
  }

  Future<void> _loadWorkouts() async {
    final loadedWorkouts = await _nutritionService.getWorkoutRoutines(widget.selectedDate);
    if (mounted) {
      setState(() {
        workouts = loadedWorkouts;
      });
    }
  }

  void _showAddWorkoutDialog() {
    final nameController = TextEditingController();
    final durationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Workout"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Workout Name (e.g., Bench Press)"),
            ),
            TextField(
              controller: durationController,
              decoration: InputDecoration(labelText: "Duration/Sets (e.g., 3 x 12)"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                await _nutritionService.addWorkoutRoutine(
                  date: widget.selectedDate,
                  workoutName: nameController.text,
                  duration: durationController.text,
                );
                _loadWorkouts();
                Navigator.pop(context);
              }
            },
            child: Text("Add"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Todays Routine",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.black),
              onPressed: _showAddWorkoutDialog,
              tooltip: "Add Workout",
            ),
          ],
        ),
        if (workouts.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "No workouts planned for this day.",
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          )
        else
          ...workouts.map((workout) => _buildWorkoutCheckbox(workout)).toList(),
      ],
    );
  }

  Widget _buildWorkoutCheckbox(Map<String, dynamic> workout) {
    final isCompleted = (workout['isCompleted'] as int) == 1;
    final id = workout['id'] as int;
    final name = "${workout['workoutName']} ${workout['duration']}";

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Remove Workout"),
              content: Text("Remove '$name' from routine?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    await _nutritionService.removeWorkoutRoutine(id);
                    _loadWorkouts();
                    Navigator.pop(context);
                  },
                  child: Text("Remove", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        },
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: isCompleted,
                onChanged: (bool? value) async {
                  if (value != null) {
                    await _nutritionService.toggleWorkoutCompletion(id, value);
                    _loadWorkouts();
                  }
                },
                activeColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                  decoration: isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isMonday(DateTime date) {
    return date.weekday == DateTime.monday;
  }

  bool _isThursday(DateTime date) {
    return date.weekday == DateTime.thursday;
  }

  bool _isTuesday(DateTime date) {
    return date.weekday == DateTime.tuesday;
  }

  bool _isFriday(DateTime date) {
    return date.weekday == DateTime.friday;
  }
}

// Trainer Section
class TrainerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.6),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          print("Trainer button pressed");
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("Images/PnM.png"),
                radius: 30,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Trainer: PnM",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("Subscription ends in 10 days",
                      style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Nutritionist Section
class NutritionistSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.6),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          print("Nutritionist button pressed");
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("Images/kisha.png"),
                radius: 30,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nutritionist: Kisha",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("Subscription ends in 3 days",
                      style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Gym Section
class GymSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.6),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          print("Gym button pressed");
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("Images/gordon.png"),
                radius: 30,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gym: Gordon's Gym",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("Subscription ends in 20 days",
                      style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Nutrition Info Section
class NutritionInfoSection extends StatefulWidget {
  @override
  _NutritionInfoSectionState createState() => _NutritionInfoSectionState();
}

class _NutritionInfoSectionState extends State<NutritionInfoSection> {
  final NutritionService _nutritionService = NutritionService();
  
  int totalCalories = 0;
  double proteins = 0.0;
  double carbs = 0.0;
  double fats = 0.0;
  double vitamins = 0.0;
  double minerals = 0.0;

  @override
  void initState() {
    super.initState();
    _loadNutritionData();
  }

  Future<void> _loadNutritionData() async {
    await _nutritionService.checkAndResetDaily();
    final data = await _nutritionService.getTodayNutrition();
    if (mounted) {
      setState(() {
        totalCalories = data['totalCalories'] ?? 0;
        proteins = data['proteins'] ?? 0.0;
        carbs = data['carbs'] ?? 0.0;
        fats = data['fats'] ?? 0.0;
        vitamins = data['vitamins'] ?? 0.0;
        minerals = data['minerals'] ?? 0.0;
      });
    }
  }

  void _showAddFoodDialog() {
    final nameController = TextEditingController();
    final caloriesController = TextEditingController();
    final proteinController = TextEditingController();
    final carbsController = TextEditingController();
    final fatsController = TextEditingController();
    final vitaminsController = TextEditingController();
    final mineralsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Food Entry"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Food Name"),
              ),
              TextField(
                controller: caloriesController,
                decoration: InputDecoration(labelText: "Calories (kcal)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: proteinController,
                decoration: InputDecoration(labelText: "Protein (g)"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: carbsController,
                decoration: InputDecoration(labelText: "Carbs (g)"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: fatsController,
                decoration: InputDecoration(labelText: "Fats (g)"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: vitaminsController,
                decoration: InputDecoration(labelText: "Vitamins (mg)"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: mineralsController,
                decoration: InputDecoration(labelText: "Minerals (g)"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty && caloriesController.text.isNotEmpty) {
                await _nutritionService.addFoodEntry(
                  name: nameController.text,
                  calories: int.tryParse(caloriesController.text) ?? 0,
                  proteins: double.tryParse(proteinController.text) ?? 0.0,
                  carbs: double.tryParse(carbsController.text) ?? 0.0,
                  fats: double.tryParse(fatsController.text) ?? 0.0,
                  vitamins: double.tryParse(vitaminsController.text) ?? 0.0,
                  minerals: double.tryParse(mineralsController.text) ?? 0.0,
                );
                _loadNutritionData();
                Navigator.pop(context);
              }
            },
            child: Text("Add"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nutrition Overview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle, color: Colors.white),
                onPressed: _showAddFoodDialog,
                tooltip: "Add Food",
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side with donut chart
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Calories Consumed",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "$totalCalories kcal",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          painter: DonutChartPainter(
                            proteins: proteins,
                            carbs: carbs,
                            fats: fats,
                            vitamins: vitamins,
                            minerals: minerals,
                          ),
                          size: Size(100, 100),
                        ),
                        Text(
                          "Daily",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLegendItem('Protein', Colors.blue),
                        _buildLegendItem('Carbs', Colors.green),
                        _buildLegendItem('Fats', Colors.orange),
                        _buildLegendItem('Vitamins', Colors.purple),
                        _buildLegendItem('Minerals', Colors.red),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(width: 40),

              // Right side with nutrition details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nutrition Details",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildNutrientInfo("Proteins", "${proteins.toStringAsFixed(1)} g",
                        Colors.grey[800]!),
                    SizedBox(height: 12),
                    _buildNutrientInfo("Carbohydrates",
                        "${carbs.toStringAsFixed(1)} g", Colors.grey[400]!),
                    SizedBox(height: 12),
                    _buildNutrientInfo("Fats",
                        "${fats.toStringAsFixed(1)} g", Colors.grey[600]!),
                    SizedBox(height: 12),
                    _buildNutrientInfo(
                        "Vitamins", "${vitamins.toStringAsFixed(1)} mg", Colors.grey),
                    SizedBox(height: 12),
                    _buildNutrientInfo(
                        "Minerals", "${minerals.toStringAsFixed(1)} g", Colors.black),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildNutrientInfo(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Calories Balance Section
class CaloriesBalanceSection extends StatefulWidget {
  @override
  _CaloriesBalanceSectionState createState() => _CaloriesBalanceSectionState();
}

class _CaloriesBalanceSectionState extends State<CaloriesBalanceSection> {
  final NutritionService _nutritionService = NutritionService();
  
  int caloriesConsumed = 0;
  int caloriesBurned = 0;
  int netCalories = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final nutrition = await _nutritionService.getTodayNutrition();
    final burned = await _nutritionService.getTodayCaloriesBurned();
    
    if (mounted) {
      setState(() {
        caloriesConsumed = nutrition['totalCalories'] ?? 0;
        caloriesBurned = burned;
        netCalories = caloriesConsumed - caloriesBurned;
      });
    }
  }

  void _showLogWorkoutDialog() {
    final typeController = TextEditingController();
    final caloriesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Log Workout"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: typeController,
              decoration: InputDecoration(labelText: "Workout Type"),
            ),
            TextField(
              controller: caloriesController,
              decoration: InputDecoration(labelText: "Calories Burned"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (typeController.text.isNotEmpty && caloriesController.text.isNotEmpty) {
                await _nutritionService.logWorkout(
                  type: typeController.text,
                  calories: int.tryParse(caloriesController.text) ?? 0,
                );
                _loadData();
                Navigator.pop(context);
              }
            },
            child: Text("Log"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Calories Balance",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(Icons.fitness_center, color: Colors.white),
                onPressed: _showLogWorkoutDialog,
                tooltip: "Log Workout",
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side with donut chart
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Net Balance",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "$netCalories kcal",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          painter: CaloriesBalanceChartPainter(
                            consumed: caloriesConsumed,
                            burned: caloriesBurned,
                          ),
                          size: Size(100, 100),
                        ),
                        Text(
                          "Daily",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLegendItem('Consumed', Colors.orangeAccent),
                        _buildLegendItem('Burned', Colors.lightBlueAccent),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(width: 40),

              // Right side with calorie balance details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Energy Balance",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildCalorieInfo(
                        "Consumed", "$caloriesConsumed kcal", Colors.orangeAccent),
                    SizedBox(height: 12),
                    _buildCalorieInfo("Burned", "$caloriesBurned kcal", Colors.lightBlueAccent),
                    SizedBox(height: 12),
                    Divider(color: Colors.grey[400]),
                    SizedBox(height: 12),
                    Text(
                      netCalories > 0 ? "Surplus" : "Deficit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: netCalories > 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCalorieInfo(String label, String value, Color color,
      {bool isHighlighted = false}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: isHighlighted ? 18 : 16,
                fontWeight: FontWeight.bold,
                color: isHighlighted ? color : Colors.grey[900],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SubscriptionsSection extends StatefulWidget {
  @override
  _SubscriptionsSectionState createState() => _SubscriptionsSectionState();
}

class _SubscriptionsSectionState extends State<SubscriptionsSection> {
  final NutritionService _nutritionService = NutritionService();
  List<Map<String, dynamic>> trainers = [];
  List<Map<String, dynamic>> nutritionists = [];
  List<Map<String, dynamic>> gyms = [];

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    final loadedTrainers = await _nutritionService.getSubscriptions('Trainer');
    final loadedNutritionists = await _nutritionService.getSubscriptions('Nutritionist');
    final loadedGyms = await _nutritionService.getSubscriptions('Gym');

    if (mounted) {
      setState(() {
        trainers = loadedTrainers;
        nutritionists = loadedNutritionists;
        gyms = loadedGyms;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCategorySection("Trainers", trainers),
        SizedBox(height: 20),
        _buildCategorySection("Nutritionists", nutritionists),
        SizedBox(height: 20),
        _buildCategorySection("Gyms", gyms),
      ],
    );
  }

  Widget _buildCategorySection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 10),
        if (items.isEmpty)
          Text(
            "No active $title subscriptions.",
            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          )
        else
          ...items.map((item) => _buildSubscriptionCard(item)).toList(),
      ],
    );
  }

  Widget _buildSubscriptionCard(Map<String, dynamic> item) {
    final id = item['id'] as int;
    final name = item['name'] as String;
    final imagePath = item['imagePath'] as String;
    final description = item['description'] as String;
    final price = item['price'] as double;

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Icon(Icons.person, color: Colors.grey[600]),
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  "Ksh${price.toStringAsFixed(0)}/month",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.red[400]),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Cancel Subscription"),
                  content: Text("Are you sure you want to cancel your subscription to $name?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Keep"),
                    ),
                    TextButton(
                      onPressed: () async {
                        await _nutritionService.removeSubscription(id);
                        _loadSubscriptions();
                        Navigator.pop(context);
                      },
                      child: Text("Cancel", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
