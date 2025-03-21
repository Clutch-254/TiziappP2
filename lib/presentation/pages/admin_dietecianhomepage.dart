import 'package:flutter/material.dart';

class AdminDietecianhomepage extends StatefulWidget {
  const AdminDietecianhomepage({super.key});

  @override
  State<AdminDietecianhomepage> createState() => _AdminDietecianhomepageState();
}

class _AdminDietecianhomepageState extends State<AdminDietecianhomepage> {
  // Sample dietician data - this would typically come from a database
  final String dieticianName = "Sarah Wanjiru";
  final String jobTitle = "Clinical Dietician";
  final String description =
      "A dedicated nutrition specialist with over 6 years of experience in clinical dietetics, "
      "weight management, and therapeutic meal planning. Specializes in creating customized "
      "nutrition programs for various health conditions including diabetes, heart disease, and "
      "digestive disorders. Passionate about empowering clients to make sustainable dietary changes "
      "that improve overall health and well-being through evidence-based nutritional guidance.";

  final List<Map<String, String>> certificates = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dietician Profile'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dietician name - centered at the top
              Center(
                child: Text(
                  dieticianName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Dietician image - centered
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green[700]!, width: 3),
                    image: const DecorationImage(
                      image: AssetImage('Images/kisha.png'),
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
                            color: Colors.green[700],
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
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.green[200]!),
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
