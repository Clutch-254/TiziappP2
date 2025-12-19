import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminDietecianhomepage extends StatefulWidget {
  const AdminDietecianhomepage({super.key});

  @override
  State<AdminDietecianhomepage> createState() => _AdminDietecianhomepageState();
}

class _AdminDietecianhomepageState extends State<AdminDietecianhomepage> {
  // Mutable state variables
  String dieticianName = "Sarah Wanjiru";
  String jobTitle = "Clinical Dietician";
  String location = "Nairobi, Kenya";
  String description =
      "A dedicated nutrition specialist with over 6 years of experience in clinical dietetics, "
      "weight management, and therapeutic meal planning. Specializes in creating customized "
      "nutrition programs for various health conditions including diabetes, heart disease, and "
      "digestive disorders. Passionate about empowering clients to make sustainable dietary changes "
      "that improve overall health and well-being through evidence-based nutritional guidance.";

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Map<String, String> institution = {
    'name': 'Wellness Nutrition Center',
    'description': 'Leading nutrition consultation and counseling center',
    'duration': '2020 - Present · 4 years',
  };

  List<Map<String, String>> certificates = [
    {
      'title': 'Bachelor of Science in Food Science and Nutrition',
      'institution': 'University of Nairobi',
      'year': '2017'
    },
    {
      'title': 'Registered Dietician Nutritionist (RDN)',
      'institution': 'Kenya Nutritionists and Dieticians Institute',
      'year': '2018'
    },
    {
      'title': 'Certified Diabetes Educator',
      'institution': 'Diabetes Kenya Association',
      'year': '2020'
    },
    {
      'title': 'Sports Nutrition Certification',
      'institution': 'International Society of Sports Nutrition',
      'year': '2022'
    }
  ];

  List<Map<String, dynamic>> skills = [
    {'name': 'Clinical Nutrition', 'endorsements': 18},
    {'name': 'Diabetes Management', 'endorsements': 15},
    {'name': 'Therapeutic Meal Planning', 'endorsements': 12},
    {'name': 'Sports Nutrition', 'endorsements': 9},
  ];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: dieticianName);
    final titleController = TextEditingController(text: jobTitle);
    final locationController = TextEditingController(text: location);
    final descController = TextEditingController(text: description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  await _pickImage();
                  Navigator.pop(context);
                  _showEditProfileDialog();
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? const Icon(Icons.add_a_photo, size: 30, color: Colors.grey)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Occupation/Title'),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'About'),
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
                dieticianName = nameController.text;
                jobTitle = titleController.text;
                location = locationController.text;
                description = descController.text;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEditInstitutionDialog() {
    final nameController = TextEditingController(text: institution['name']);
    final descController = TextEditingController(text: institution['description']);
    final durationController = TextEditingController(text: institution['duration']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Institution'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Institution Name'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 2,
            ),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(labelText: 'Duration'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                institution = {
                  'name': nameController.text,
                  'description': descController.text,
                  'duration': durationController.text,
                };
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddCertificateDialog() {
    final titleController = TextEditingController();
    final institutionController = TextEditingController();
    final yearController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Certificate'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Certificate Title'),
            ),
            TextField(
              controller: institutionController,
              decoration: const InputDecoration(labelText: 'Institution'),
            ),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(labelText: 'Year'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                certificates.add({
                  'title': titleController.text,
                  'institution': institutionController.text,
                  'year': yearController.text,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeCertificate(int index) {
    setState(() {
      certificates.removeAt(index);
    });
  }

  void _showAddSkillDialog() {
    final skillController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Skill'),
        content: TextField(
          controller: skillController,
          decoration: const InputDecoration(labelText: 'Skill Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                skills.add({
                  'name': skillController.text,
                  'endorsements': 0,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeSkill(int index) {
    setState(() {
      skills.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Green color scheme matching bottom nav
    final Color primaryColor = Colors.green[700]!;
    final Color secondaryColor = Colors.green[500]!;
    final Color backgroundColor = Colors.green[50]!;
    final Color cardColor = Colors.white;
    final Color accentColor = Colors.green[700]!;
    final Color borderColor = Colors.green[200]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dietician Profile'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.message_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header stack
            Stack(
              clipBehavior: Clip.none,
              children: [
                const SizedBox(
                  height: 180,
                  width: double.infinity,
                ),
                
                // Cover image/background
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 120,
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      border: Border(
                        bottom: BorderSide(color: borderColor, width: 1),
                      ),
                    ),
                  ),
                ),

                // Profile image positioned to overlap
                Positioned(
                  left: 16,
                  top: 60,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: cardColor, width: 4),
                        color: backgroundColor,
                        image: _profileImage != null
                            ? DecorationImage(
                                image: FileImage(_profileImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _profileImage == null
                          ? Center(
                              child: Icon(
                                Icons.person,
                                size: 70,
                                color: primaryColor,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),

                // Edit and share buttons
                Positioned(
                  right: 16,
                  top: 130,
                  child: Wrap(
                    spacing: 8,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _showEditProfileDialog,
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Profile'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: accentColor,
                          side: BorderSide(color: borderColor),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: accentColor,
                          side: BorderSide(color: borderColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Main content area
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dieticianName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    jobTitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Connection info
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: secondaryColor),
                      const SizedBox(width: 4),
                      Text(location, style: TextStyle(color: secondaryColor)),
                      const SizedBox(width: 16),
                      Icon(Icons.people, size: 16, color: secondaryColor),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: secondaryColor,
                        ),
                        child: Text(
                          '8 clients',
                          style: TextStyle(
                            color: secondaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Institution section
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Institution',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: secondaryColor),
                                onPressed: _showEditInstitutionDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: borderColor),
                                ),
                                child: Icon(
                                  Icons.local_hospital,
                                  color: secondaryColor,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      institution['name']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      institution['description']!,
                                      style: TextStyle(color: secondaryColor),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      institution['duration']!,
                                      style: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // About section
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'About',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: secondaryColor),
                                onPressed: _showEditProfileDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(description, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Education & Certificates section
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Education & Certificates',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: secondaryColor),
                                onPressed: _showAddCertificateDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...certificates.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, String> cert = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Icon(Icons.school, color: secondaryColor),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cert['title']!,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          cert['institution']!,
                                          style: TextStyle(color: secondaryColor),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          cert['year']!,
                                          style: TextStyle(color: secondaryColor, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                    onPressed: () => _removeCertificate(index),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Skills section
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Skills',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: secondaryColor),
                                onPressed: _showAddSkillDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...skills.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> skill = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle, size: 16, color: primaryColor),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      skill['name'],
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    '${skill['endorsements']} endorsements',
                                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 16, color: Colors.red),
                                    onPressed: () => _removeSkill(index),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
