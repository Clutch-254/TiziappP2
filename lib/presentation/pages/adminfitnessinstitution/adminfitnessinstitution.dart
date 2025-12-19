import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Adminfitnessinstitution extends StatefulWidget {
  const Adminfitnessinstitution({super.key});

  @override
  State<Adminfitnessinstitution> createState() => _AdminfitnessinstitutionState();
}

class _AdminfitnessinstitutionState extends State<Adminfitnessinstitution> {
  // Mutable state variables
  String institutionName = "Elite Fitness Center";
  String businessType = "Fitness & Health Facility";
  String description =
      "A premier fitness facility established in 2015, offering state-of-the-art equipment and "
      "personalized training programs. Our center specializes in strength training, cardio fitness, "
      "group classes, and nutritional guidance. We pride ourselves on our team of certified trainers and "
      "dieticians who are dedicated to helping our clients achieve their fitness goals through "
      "customized workout plans and expert guidance in a motivating environment.";
  
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  List<Map<String, dynamic>> facilities = [
    {
      'title': 'Training Areas',
      'details':
          'Modern gymnasium with cardio, strength, and functional training zones',
      'icon': Icons.fitness_center
    },
    {
      'title': 'Swimming Pool',
      'details': 'Olympic-sized heated indoor pool with dedicated lanes',
      'icon': Icons.pool
    },
    {
      'title': 'Group Studios',
      'details':
          'Multiple studios for yoga, spin, aerobics, and other group classes',
      'icon': Icons.groups
    },
    {
      'title': 'Consultation Rooms',
      'details':
          'Private spaces for nutrition consulting and fitness assessments',
      'icon': Icons.medication
    }
  ];

  List<Map<String, dynamic>> licenses = [
    {
      'title': 'Fitness Facility Operating License',
      'issuer': 'Kenya Sports Authority',
      'validUntil': 'December 2025'
    },
    {
      'title': 'Health and Safety Compliance Certificate',
      'issuer': 'Nairobi County Health Department',
      'validUntil': 'March 2026'
    },
    {
      'title': 'Professional Fitness Training Accreditation',
      'issuer': 'International Fitness Association - Kenya Chapter',
      'validUntil': 'August 2025'
    },
    {
      'title': 'Nutritional Advisory Services Permit',
      'issuer': 'Kenya Nutritional Services Board',
      'validUntil': 'October 2025'
    }
  ];

  List<Map<String, String>> businessHours = [
    {'day': 'Monday - Friday', 'hours': '5:30 AM - 10:00 PM'},
    {'day': 'Saturday', 'hours': '7:00 AM - 8:00 PM'},
    {'day': 'Sunday', 'hours': '8:00 AM - 6:00 PM'},
    {'day': 'Public Holidays', 'hours': '8:00 AM - 4:00 PM'},
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
    final nameController = TextEditingController(text: institutionName);
    final typeController = TextEditingController(text: businessType);
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
                decoration: const InputDecoration(labelText: 'Institution Name'),
              ),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Business Type'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
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
                institutionName = nameController.text;
                businessType = typeController.text;
                description = descController.text;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddFacilityDialog() {
    final titleController = TextEditingController();
    final detailsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Facility'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Facility Name'),
            ),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(labelText: 'Details'),
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
                facilities.add({
                  'title': titleController.text,
                  'details': detailsController.text,
                  'icon': Icons.star, // Default icon
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeFacility(int index) {
    setState(() {
      facilities.removeAt(index);
    });
  }

  void _showAddLicenseDialog() {
    final titleController = TextEditingController();
    final issuerController = TextEditingController();
    final validController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add License'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'License Name'),
            ),
            TextField(
              controller: issuerController,
              decoration: const InputDecoration(labelText: 'Issuer'),
            ),
            TextField(
              controller: validController,
              decoration: const InputDecoration(labelText: 'Valid Until'),
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
                licenses.add({
                  'title': titleController.text,
                  'issuer': issuerController.text,
                  'validUntil': validController.text,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeLicense(int index) {
    setState(() {
      licenses.removeAt(index);
    });
  }

  void _showEditBusinessHoursDialog() {
    List<TextEditingController> controllers = businessHours.map((e) => TextEditingController(text: e['hours'])).toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Business Hours'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(businessHours.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: controllers[index],
                  decoration: InputDecoration(labelText: businessHours[index]['day']),
                ),
              );
            }),
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
                for (int i = 0; i < businessHours.length; i++) {
                  businessHours[i]['hours'] = controllers[i].text;
                }
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Black color scheme to match bottom navigation
    final Color primaryColor = Colors.black;
    final Color secondaryColor = Colors.grey[700]!;
    final Color backgroundColor = Colors.grey[100]!;
    final Color cardColor = Colors.white;
    final Color accentColor = Colors.black;
    final Color borderColor = Colors.grey[300]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Institution Profile'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          // Notifications icon
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          // Messages icon
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
            // Profile header stack - LinkedIn style
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Invisible container to set the stack height to accommodate buttons
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

                // Institution logo positioned to overlap
                Positioned(
                  left: 16,
                  top: 60, // Position to overlap with the cover image
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
                                Icons.add_a_photo,
                                size: 40,
                                color: primaryColor,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),

                // Edit and share buttons positioned on the right side
                Positioned(
                  right: 16,
                  top: 130,
                  child: Wrap(
                    spacing: 8,
                    children: [
                      // Edit Profile Button
                      OutlinedButton.icon(
                        onPressed: _showEditProfileDialog,
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Profile'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: accentColor,
                          side: BorderSide(color: borderColor),
                        ),
                      ),
                      // Share Profile Button
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

            // No extra spacing needed as Stack now reserves the space
            // const SizedBox(height: 70),

            // Main content area
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and headline - positioned below the profile image
                  Text(
                    institutionName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Business type
                  Text(
                    businessType,
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Basic info
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: secondaryColor),
                      const SizedBox(width: 4),
                      Text(
                        'Nairobi, Kenya',
                        style: TextStyle(color: secondaryColor),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.people, size: 16, color: secondaryColor),
                      const SizedBox(width: 4),
                      // Client button
                      TextButton(
                        onPressed: () {
                          // Handle button press here
                          print('Clients button pressed');
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: secondaryColor,
                        ),
                        child: Text(
                          '125 clients',
                          style: TextStyle(
                            color: secondaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // About section - LinkedIn style card
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
                          Text(
                            description,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Facilities section
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
                                'Facilities',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: secondaryColor),
                                onPressed: _showAddFacilityDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...facilities.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> facility = entry.value;
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Facility icon
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Icon(
                                        facility['icon'],
                                        color: secondaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Facility details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            facility['title'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            facility['details'],
                                            style: TextStyle(
                                              color: secondaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                      onPressed: () => _removeFacility(index),
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

                  // Licenses section (replacing Staff section)
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
                                'Licenses & Certifications',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: secondaryColor),
                                onPressed: _showAddLicenseDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...licenses.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> license = entry.value;
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // License icon
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Icon(
                                        Icons.verified,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // License details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            license['title'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Issued by: ${license['issuer']}',
                                            style: TextStyle(
                                              color: secondaryColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Valid until: ${license['validUntil']}',
                                            style: TextStyle(
                                              color: secondaryColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                      onPressed: () => _removeLicense(index),
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

                  // Business hours section
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
                                'Business Hours',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: secondaryColor),
                                onPressed: _showEditBusinessHoursDialog,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...businessHours.map((e) => _buildBusinessHoursItem(e['day']!, e['hours']!)),
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

  // Helper method to build business hours items
  Widget _buildBusinessHoursItem(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(Icons.schedule, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            day,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            hours,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
