import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminVirtualhomepage extends StatefulWidget {
  const AdminVirtualhomepage({super.key});

  @override
  State<AdminVirtualhomepage> createState() => _AdminVirtualhomepageState();
}

class _AdminVirtualhomepageState extends State<AdminVirtualhomepage> {
  // Mutable trainer data
  String trainerName = "John Kamau";
  String jobTitle = "Personal Trainer";
  String description =
      "An experienced fitness professional with over 5 years of expertise in strength training, "
      "weight management, and nutritional counseling. Specializes in creating personalized "
      "fitness programs tailored to individual needs and goals. Passionate about helping "
      "clients achieve sustainable fitness results through balanced exercise routines and "
      "healthy lifestyle changes.";
  String location = "Nairobi, Kenya";
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  List<Map<String, String>> certificates = [
    {
      'title': 'Bachelor of Science in Exercise Science and Sports Medicine',
      'institution': 'Kenyatta University',
      'year': '2018'
    },
    {
      'title': 'Certified Strength and Conditioning Specialist (CSCS)',
      'institution': 'National Strength and Conditioning Association',
      'year': '2019'
    },
    {
      'title': 'Sports Nutrition Specialist Certification',
      'institution': 'University of Nairobi',
      'year': '2020'
    },
    {
      'title': 'First Aid and CPR/AED Certification',
      'institution': 'Kenya Red Cross Society',
      'year': '2023'
    }
  ];

  Map<String, String>? institution = {
    'name': 'Elite Fitness Center',
    'description': 'Premium fitness facility with state-of-the-art equipment',
    'period': '2019 - Present · 5 years'
  };

  List<Map<String, dynamic>> skills = [
    {'name': 'Strength Training', 'endorsements': 15},
    {'name': 'Nutrition Planning', 'endorsements': 12},
    {'name': 'Weight Management', 'endorsements': 10},
    {'name': 'Sports Rehabilitation', 'endorsements': 8},
  ];

  @override
  void initState() {
    super.initState();
    debugPrint('AdminVirtualhomepage initState called, hash: $hashCode');
  }

  @override
  void dispose() {
    debugPrint('AdminVirtualhomepage dispose called, hash: $hashCode');
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _showEditProfileDialog() {
    debugPrint('Entering _showEditProfileDialog, hash: $hashCode');
    final nameController = TextEditingController(text: trainerName);
    final titleController = TextEditingController(text: jobTitle);
    final locationController = TextEditingController(text: location);
    final aboutController = TextEditingController(text: description);

    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        debugPrint('Building dialog content, hash: $hashCode');
        return StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: const Text('Edit Profile'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _pickImage();
                          setDialogState(() {});
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                          child: _profileImage == null ? const Icon(Icons.camera_alt, size: 40) : null,
                        ),
                      ),
                      if (_profileImage != null)
                        Positioned(
                          right: -10,
                          top: -10,
                          child: IconButton(
                            icon: const Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _profileImage = null;
                              });
                              setDialogState(() {});
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name', hintText: 'Enter your name')),
                  TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Job Title', hintText: 'Enter your job title')),
                  TextField(controller: locationController, decoration: const InputDecoration(labelText: 'Location', hintText: 'Enter your location')),
                  TextField(
                    controller: aboutController,
                    decoration: const InputDecoration(labelText: 'About', hintText: 'Tell us about yourself'),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    trainerName = "";
                    jobTitle = "";
                    location = "";
                    description = "";
                  });
                  Navigator.pop(context);
                },
                child: const Text('Clear All', style: TextStyle(color: Colors.red)),
              ),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    trainerName = nameController.text;
                    jobTitle = titleController.text;
                    location = locationController.text;
                    description = aboutController.text;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddCertificateDialog() {
    final titleController = TextEditingController();
    final instController = TextEditingController();
    final yearController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Certificate'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: instController, decoration: const InputDecoration(labelText: 'Institution')),
            TextField(controller: yearController, decoration: const InputDecoration(labelText: 'Year')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                certificates.add({
                  'title': titleController.text,
                  'institution': instController.text,
                  'year': yearController.text,
                });
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditInstitutionDialog() {
    final nameController = TextEditingController(text: institution?['name'] ?? "");
    final descController = TextEditingController(text: institution?['description'] ?? "");
    final periodController = TextEditingController(text: institution?['period'] ?? "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Institution'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
            TextField(controller: periodController, decoration: const InputDecoration(labelText: 'Period')),
          ],
        ),
        actions: [
          if (institution != null)
            TextButton(
              onPressed: () {
                setState(() {
                  institution = null;
                });
                Navigator.pop(context);
              },
              child: const Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                institution = {
                  'name': nameController.text,
                  'description': descController.text,
                  'period': periodController.text,
                };
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddSkillDialog() {
    final skillController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Skill'),
        content: TextField(controller: skillController, decoration: const InputDecoration(labelText: 'Skill Name')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                skills.add({'name': skillController.text, 'endorsements': 0});
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    debugPrint('AdminVirtualhomepage build called, hash: $hashCode');
    final Color primaryColor = Colors.grey[700]!;
    final Color secondaryColor = Colors.grey[500]!;
    final Color backgroundColor = Colors.grey[100]!;
    final Color cardColor = Colors.white;
    final Color accentColor = Colors.grey[800]!;
    final Color borderColor = Colors.grey[300]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Trainer Profile'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Explicit height to ensure hit testing works for all children
                const SizedBox(height: 200, width: double.infinity),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border(bottom: BorderSide(color: borderColor, width: 1)),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 60,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: cardColor, width: 4),
                      image: _profileImage != null
                          ? DecorationImage(image: FileImage(_profileImage!), fit: BoxFit.cover)
                          : const DecorationImage(image: AssetImage('Images/Juma.png'), fit: BoxFit.cover),
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 130,
                  child: Material(
                    color: Colors.transparent,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        debugPrint('Edit Profile button pressed');
                        _showEditProfileDialog();
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: accentColor,
                        side: BorderSide(color: borderColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (trainerName.isNotEmpty)
                    Text(trainerName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  if (jobTitle.isNotEmpty)
                    Text(jobTitle, style: TextStyle(fontSize: 16, color: secondaryColor, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 16),
                  if (location.isNotEmpty)
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: secondaryColor),
                        const SizedBox(width: 4),
                        Text(location, style: TextStyle(color: secondaryColor)),
                      ],
                    ),
                  const SizedBox(height: 24),
                  
                  // Institution Section
                  if (institution != null)
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: borderColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Institution', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: Icon(Icons.edit, color: secondaryColor),
                                  onPressed: () {
                                    debugPrint('Edit Institution button pressed');
                                    _showEditInstitutionDialog();
                                  },
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
                                  child: Icon(Icons.fitness_center, color: secondaryColor, size: 30),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(institution!['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      const SizedBox(height: 4),
                                      Text(institution!['description']!, style: TextStyle(color: secondaryColor)),
                                      const SizedBox(height: 4),
                                      Text(institution!['period']!, style: TextStyle(color: secondaryColor, fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Center(
                      child: TextButton.icon(
                        onPressed: _showEditInstitutionDialog,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Institution'),
                      ),
                    ),
                    
                  const SizedBox(height: 16),
                  
                  // About Section
                  if (description.isNotEmpty)
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: borderColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('About', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: Icon(Icons.edit, color: secondaryColor),
                                  onPressed: () {
                                    debugPrint('About Edit button pressed');
                                    _showEditProfileDialog();
                                  },
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
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: borderColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Education & Certificates', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: Icon(Icons.add, color: secondaryColor),
                                  onPressed: () {
                                    debugPrint('Add Certificate button pressed');
                                    _showAddCertificateDialog();
                                  },
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...certificates.asMap().entries.map((entry) {
                            int idx = entry.key;
                            var cert = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(4)),
                                    child: Icon(Icons.school, color: secondaryColor),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(cert['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 4),
                                        Text(cert['institution']!, style: TextStyle(color: secondaryColor)),
                                        const SizedBox(height: 4),
                                        Text(cert['year']!, style: TextStyle(color: secondaryColor, fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                    onPressed: () => setState(() => certificates.removeAt(idx)),
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
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: borderColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Skills', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: Icon(Icons.add, color: secondaryColor),
                                  onPressed: () {
                                    debugPrint('Add Skill button pressed');
                                    _showAddSkillDialog();
                                  },
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...skills.asMap().entries.map((entry) {
                            int idx = entry.key;
                            var skill = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle, size: 16, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text(skill['name'], style: const TextStyle(fontWeight: FontWeight.w500)),
                                  const Spacer(),
                                  Text('${skill['endorsements']} endorsements', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                                    onPressed: () => setState(() => skills.removeAt(idx)),
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
