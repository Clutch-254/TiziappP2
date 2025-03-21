import 'package:flutter/material.dart';

class AdminVirtualhomepage extends StatefulWidget {
  const AdminVirtualhomepage({super.key});

  @override
  State<AdminVirtualhomepage> createState() => _AdminVirtualhomepageState();
}

class _AdminVirtualhomepageState extends State<AdminVirtualhomepage> {
  // Sample trainer data - this would typically come from a database
  final String trainerName = "John Kamau";
  final String jobTitle = "Personal Trainer";
  final String description =
      "An experienced fitness professional with over 5 years of expertise in strength training, "
      "weight management, and nutritional counseling. Specializes in creating personalized "
      "fitness programs tailored to individual needs and goals. Passionate about helping "
      "clients achieve sustainable fitness results through balanced exercise routines and "
      "healthy lifestyle changes.";

  final List<Map<String, String>> certificates = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trainer Profile'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trainer name - centered at the top
              Center(
                child: Text(
                  trainerName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Trainer image - centered
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue[800]!, width: 3),
                    image: const DecorationImage(
                      image: AssetImage('Images/Juma.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Main content area with job title, description, and certificates
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side - Job title
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 12.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            jobTitle,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right side - Description and certificates
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description section
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Text(
                            description,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Certificates and qualifications section
                        const Text(
                          'Certificates & Qualifications',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...certificates
                            .map((cert) => Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.blue[200]!),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cert['title']!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Institution: ${cert['institution']}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Year: ${cert['year']}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
