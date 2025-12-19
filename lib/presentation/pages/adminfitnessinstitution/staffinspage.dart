import 'package:flutter/material.dart';

class Staffinspage extends StatefulWidget {
  const Staffinspage({super.key});

  @override
  State<Staffinspage> createState() => _StaffinspageState();
}

class _StaffinspageState extends State<Staffinspage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> facilities = [
    {'name': 'Main Gym Floor', 'image': 'assets/gym_floor.jpg', 'description': 'Fully equipped with latest Technogym machines'},
    {'name': 'Olympic Pool', 'image': 'assets/pool.jpg', 'description': '25m heated indoor pool with 6 lanes'},
    {'name': 'Yoga Studio', 'image': 'assets/yoga.jpg', 'description': 'Peaceful space for yoga and meditation'},
    {'name': 'CrossFit Zone', 'image': 'assets/crossfit.jpg', 'description': 'Dedicated area for high-intensity functional training'},
    {'name': 'Sauna & Steam', 'image': 'assets/sauna.jpg', 'description': 'Relaxation area with separate men\'s and women\'s sections'},
  ];

  final List<Map<String, dynamic>> trainers = [
    {'name': 'Juma Otieno', 'specialty': 'Strength & Conditioning', 'experience': '5 years'},
    {'name': 'Wanjiku Mwangi', 'specialty': 'Yoga & Pilates', 'experience': '8 years'},
    {'name': 'Kevin Omondi', 'specialty': 'HIIT & CrossFit', 'experience': '4 years'},
    {'name': 'Mercy Chebet', 'specialty': 'Nutrition & Weight Loss', 'experience': '6 years'},
  ];

  final List<String> galleryImages = [
    'assets/gallery1.jpg',
    'assets/gallery2.jpg',
    'assets/gallery3.jpg',
    'assets/gallery4.jpg',
    'assets/gallery5.jpg',
    'assets/gallery6.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facilities & Staff'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Facilities'),
            Tab(text: 'Trainers'),
            Tab(text: 'Gallery'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Facilities Tab
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: facilities.length,
            itemBuilder: (context, index) {
              final facility = facilities[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            facility['name'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            facility['description'],
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Trainers Tab
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: trainers.length,
            itemBuilder: (context, index) {
              final trainer = trainers[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Text(trainer['name'][0]),
                  ),
                  title: Text(trainer['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(trainer['specialty']),
                  trailing: Text(
                    trainer['experience'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              );
            },
          ),

          // Gallery Tab
          GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: galleryImages.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 40, color: Colors.grey),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}