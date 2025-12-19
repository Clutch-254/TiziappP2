import 'package:flutter/material.dart';
import 'package:tiziappp2/presentation/productdetails.dart';
import 'package:tiziappp2/technicals/widgets/database.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:io';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Sets trainer2o to true by default
  bool trainer2o = true, nutritionist = false, gyms = false;

  // We no longer need the dynamic title getter as we're using conditional widgets

  Stream? subItemStream;
  onLoad() async {
    subItemStream = await DatabaseMethods().getSubItem("Trainer");
  }

  // Google Maps Controller
  final Completer<GoogleMapController> _controller = Completer();

  // Default position (Kenya - Nairobi coordinates)
  static const CameraPosition _defaultPosition = CameraPosition(
    target: LatLng(-1.286389, 36.817223),
    zoom: 13,
  );

  // Current position
  CameraPosition? _currentPosition;

  // Set of markers
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    onLoad();
    _determinePosition();
  }

  // Method to get current location
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    if (!Platform.isAndroid && !Platform.isIOS) {
      return;
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, don't continue
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return;
    }

    // When permissions are granted, get the current position
    Position position = await Geolocator.getCurrentPosition();

    final GoogleMapController controller = await _controller.future;

    // Update camera position to current location
    CameraPosition currentPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14,
    );

    // Add user's location marker
    setState(() {
      _currentPosition = currentPosition;

      // Add markers for demo
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );

      // Add trainer markers
      _markers.add(
        const Marker(
          markerId: MarkerId('trainer1'),
          position: LatLng(-1.289, 36.817),
          infoWindow: InfoWindow(title: 'Jina - Personal Trainer'),
        ),
      );

      // Add nutritionist marker
      _markers.add(
        Marker(
          markerId: const MarkerId('nutritionist1'),
          position: const LatLng(-1.285, 36.821),
          infoWindow: const InfoWindow(title: 'David - Nutritionist'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );

      // Add gym marker
      _markers.add(
        Marker(
          markerId: const MarkerId('gym1'),
          position: const LatLng(-1.292, 36.819),
          infoWindow: const InfoWindow(title: 'Fitness Zone Gym'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });

    // Animate to current position
    controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 50.0,
            left: 20.0,
          ),
          child: Column(
            children: [
              // Title row is only shown for the selected category
              if (trainer2o) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Trainers",
                          style: AppWidget.boldTextFieledStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              if (nutritionist) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Nutritionist",
                          style: AppWidget.boldTextFieledStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              if (gyms) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Fitness Institution",
                          style: AppWidget.boldTextFieledStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(
                height: 20.0,
              ),
              Container(
                margin: const EdgeInsets.only(right: 20.0),
                child: showItem(),
              ),
              const SizedBox(
                height: 30.0,
              ),

              // GPS Map implementation
              Container(
                margin: const EdgeInsets.only(right: 20.0),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _currentPosition ?? _defaultPosition,
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ),

              const SizedBox(
                height: 30.0,
              ),

              // Only show trainer content when trainer2o is true
              if (trainer2o) ...[
                // Trainers section with horizontal scroll
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Productdetails(
                                product: Product(
                                  id: 1,
                                  name: "Jina - Personal Trainer",
                                  description:
                                      "I am a passionate and highly motivated personal trainer based in Kenya, dedicated to helping clients achieve their fitness goals through customized workout plans, nutritional guidance, and ongoing support. \n\n"
                                      "Known for my energetic coaching style and commitment to results, I empowers individuals of all fitness levels to build strength, improve mobility, and boost confidence—both in and out of the gym.",
                                  nutritionalValue: "N/A",
                                  price: 1000.0,
                                  imageAsset: "Images/Jina_Trainer.png",
                                  deliveryTime: 0,
                                  qualifications:
                                      '- Certified Personal Trainer (CPT)\n'
                                      '- Certified Nutrition Coach\n'
                                      '- CPR & First Aid Certified\n'
                                      '- Specializes in strength training, HIIT, weight loss, and mobility work\n\n',
                                  location: 'Nairobi, Kenya',
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Material(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "Images/Jina_Trainer.png",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Jina - Personal Trainer",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Personal Trainer",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "\Ksh1,000 per session",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Productdetails(
                                product: Product(
                                  id: 1,
                                  name:
                                      "Poly n Mike - Couple's \nPersonal Trainers",
                                  description:
                                      "Poly n Mike – Couple's Personal Trainers – are a dynamic fitness duo based in Kenya, specializing in partner-based coaching and personalized training for individuals, couples, and groups. \n\n"
                                      "With a strong focus on teamwork, accountability, and motivation, they deliver results-driven programs that combine strength, cardio, and mobility training for all fitness levels. \n\n"
                                      "Known for their infectious energy, real connection with clients, and passion for healthy living, Poly and Mike make fitness fun, challenging, and sustainable.",
                                  nutritionalValue: "N/A",
                                  price: 14000.0,
                                  imageAsset: "Images/PnM.png",
                                  deliveryTime: 0,
                                  qualifications:
                                      "- Certified Fitness & Strength Coaches\n"
                                      "- Group Training & Partner Workout Specialists\n"
                                      "- CPR & First Aid Certified\n"
                                      "- Experts in weight loss, body recomposition, and functional fitness\n\n",
                                  location:
                                      "Train out of Iron Core Fitness Center, Westlands, Nairobi, Kenya",
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          child: Material(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "Images/PnM.png",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Poly n Mike - Couple's \nPersonal Trainers",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Fitness Coaches",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "\Ksh14,000 per month",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),

                // Jin - Muay Thai Coach
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Productdetails(
                          product: Product(
                            id: 1,
                            name: "Jin - Muay Thai Coach",
                            description:
                                "Jin is a skilled and disciplined Muay Thai coach based in Kenya, known for blending traditional Thai techniques with modern fight conditioning. \n\n"
                                "With a strong background in competitive combat sports and years of coaching experience, Jin helps students develop striking precision, endurance, and mental toughness—whether you're training for fitness, self-defense, or the ring. \n\n"
                                "His sessions emphasize discipline, technique, and flow, making them ideal for beginners and advanced fighters alike.",
                            nutritionalValue: "N/A",
                            price: 1000.0,
                            imageAsset: "Images/jin_woo.png",
                            deliveryTime: 0,
                            qualifications: "- Certified Muay Thai Instructor\n"
                                "- Former Amateur Muay Thai Competitor\n"
                                "- First Aid & Sports Injury Certified\n"
                                "- Specializes in pad work, sparring drills, and fight conditioning\n\n",
                            location: "Nakuru Fight Club, Nakuru, Kenya",
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    child: Material(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                "Images/jin_woo.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Jin - Muay Thai Coach",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Muay Thai athlete",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "\Ksh2,000 per session",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20.0,
                ),

                // Sarah - Yoga Instructor
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Productdetails(
                          product: Product(
                            id: 1,
                            name: "Sarah - Yoga Instructor",
                            description:
                                "Akinyi is a passionate yoga instructor with over 5 years of experience guiding students in physical and spiritual wellness. "
                                "She combines traditional Hatha techniques with dynamic Vinyasa flows to help students improve flexibility, strength, and mindfulness. "
                                "Her sessions are inclusive, calming, and tailored for all levels.",
                            nutritionalValue: "N/A",
                            price: 1000.0,
                            imageAsset: "Images/miley.png",
                            deliveryTime: 0,
                            qualifications:
                                'Certified Yoga Instructor (RYT 200), Specialization in Hatha and Vinyasa Yoga, First Aid Certified',
                            location: 'Nairobi, Kenya',
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    child: Material(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                "Images/miley.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Sarah - Yoga Instructor",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Certified Yoga Expert",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "\Ksh1,500 per session",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20.0,
                ),

                // David - Nutritionist
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Productdetails(
                          product: Product(
                            id: 1,
                            name: "David - Nutritionist",
                            description:
                                "David is a dedicated nutritionist with over 7 years of experience in clinical and sports nutrition. "
                                "He offers personalized diet plans, wellness coaching, and nutrition education to help clients achieve sustainable health goals. "
                                "David believes in a holistic approach to health, combining science-based strategies with practical lifestyle changes.",
                            nutritionalValue: "N/A",
                            price: 3000.0,
                            imageAsset: "Images/Juma.png",
                            deliveryTime: 0,
                            qualifications:
                                '"Certified Clinical Nutritionist, BSc in Nutrition and Dietetics, Member of Kenya Nutritionists and Dieticians Institute (KNDI)',
                            location: '',
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    child: Material(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                "Images/Juma.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "David - Nutritionist",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Sports Nutrition Expert",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "\Ksh3,000 per consultation",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20.0,
                ),
              ],

              // Nutritionist content section
              if (nutritionist) ...[
                // Horizontal scroll section with two nutritionist items
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // First horizontal nutritionist placeholder
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Productdetails(
                                product: Product(
                                  id: 1,
                                  name: "Kisha Wanjiku - Nutrition Expert",
                                  description:
                                      "Kisha is a compassionate wellness coach focused on empowering individuals to lead balanced, healthy lives. "
                                      "With a background in nutrition, mindfulness, and holistic health, she offers personalized coaching that addresses both physical and emotional well-being. "
                                      "Her warm, supportive approach has helped countless clients make meaningful lifestyle transformations.",
                                  nutritionalValue: "N/A",
                                  price: 2500.0,
                                  imageAsset: "Images/kisha.png",
                                  deliveryTime: 0,
                                  qualifications:
                                      '"Certified Holistic Wellness Coach, Diploma in Nutrition and Wellness, Mental Health Advocate',
                                  location: 'Kisumu, Kenya',
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "Images/kisha.png",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Kisha Wanjiku - Nutrition Expert",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Sports Nutritionist",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "\Ksh2,500 per session",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Productdetails(
                                product: Product(
                                  id: 1,
                                  name: "Malon Rivers - Diet Specialist",
                                  description:
                                      "Certified Personal Trainer (NASM-CPT), Strength & Conditioning Specialist, BSc in Exercise Science",
                                  nutritionalValue: "N/A",
                                  price: 1000.0,
                                  imageAsset: "Images/malon.png",
                                  deliveryTime: 0,
                                  qualifications:
                                      'Malone is a results-driven fitness trainer with a passion for helping clients unlock their full potential. \n'
                                      'With over 8 years of experience, he specializes in strength training, athletic performance, and sustainable lifestyle changes.\n'
                                      'Known for his motivational coaching style and customized training plans, Malone supports clients of all levels on their fitness journey.',
                                  location: 'Austin, Texas, USA',
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "Images/malon.png",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Malon Rivers - Diet Specialist",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Clinical Nutritionist",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "\Ksh3,500 per consultation",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Productdetails(
                          product: Product(
                            id: 1,
                            name: "Juma Waweru - Weight Management",
                            description:
                                "John is a seasoned martial arts instructor with over a decade of experience in Taekwondo and self-defense training. "
                                "He focuses on discipline, physical fitness, and mental resilience, offering classes for both beginners and advanced students. "
                                "John's training sessions are engaging, empowering, and rooted in respect, tradition, and personal growth.",
                            nutritionalValue: "N/A",
                            price: 2800.0,
                            imageAsset: "Images/Juma.png",
                            deliveryTime: 0,
                            qualifications:
                                'Black Belt in Taekwondo (4th Dan), Certified Self-Defense Instructor, National Sports Council Accredited Coach',
                            location: '',
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                "Images/Juma.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Juma Waweru - Weight Management",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Weight Loss Specialist",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "\Ksh2,800 per session",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20.0,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Productdetails(
                          product: Product(
                            id: 1,
                            name: "Jina - Personal Trainer",
                            description:
                                "Professional personal trainer specializing in strength and conditioning.",
                            nutritionalValue: "N/A",
                            price: 4000.0,
                            imageAsset: "Images/Jina_Trainer.png",
                            deliveryTime: 0,
                            qualifications: '',
                            location: '',
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20.0, bottom: 30.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                "Images/Jina_Trainer.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Jina Wickets - Performance Nutrition",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Athletic Performance Specialist",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "\Ksh4,000 per consultation",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],

              // Gym content section
              if (gyms) ...[
                // Horizontal scroll section with two gym items
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // First horizontal gym placeholder
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Productdetails(
                                product: Product(
                                  id: 1,
                                  name: "Gordon's Gym",
                                  description:
                                      "Gordon's Gym is a premier fitness center committed to helping you achieve your health and strength goals. "
                                      "Equipped with state-of-the-art machines, free weights, and functional training zones, we cater to all fitness levels — from beginners to professional athletes. "
                                      "Our certified trainers, personalized programs, and vibrant fitness community make every workout count. "
                                      "Join us and become part of a movement that transforms bodies and empowers lives.",
                                  nutritionalValue: "N/A",
                                  price: 1000.0,
                                  imageAsset: "Images/gordon.png",
                                  deliveryTime: 0,
                                  qualifications: '',
                                  location: 'Westlands, Nairobi, Kenya',
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "Images/gordon.png",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Gordon's Gym",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Modern Fitness Center",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "\Ksh4,500 per month",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Productdetails(
                                product: Product(
                                  id: 1,
                                  name: "Fitness Hub",
                                  description:
                                      "Fitness Hub is a dynamic training space built for results, energy, and community. "
                                      "Whether you're into weightlifting, cardio, HIIT, or group classes, we’ve got the gear and guidance to match your goals. "
                                      "Our expert trainers, clean facilities, and motivating environment make Fitness Hub the go-to destination for anyone serious about getting fit, staying healthy, and having fun along the way.",
                                  nutritionalValue: "N/A",
                                  price: 6000.0,
                                  imageAsset: "Images/Zumba.png",
                                  deliveryTime: 0,
                                  qualifications: '',
                                  location: 'Karen, Nairobi, Kenya',
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "Images/Zumba.png",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "Fitness Hub",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Premium Gym Facility",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "\Ksh6,000 per month",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),

                // First vertical gym placeholder
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Productdetails(
                          product: Product(
                            id: 1,
                            name: "Tizi CrossFit Zone",
                            description:
                                "Tizi CrossFit Zone is the ultimate destination for high-intensity training and functional fitness. "
                                "Our workouts are designed to challenge your limits and build real strength, endurance, and agility. "
                                "Led by certified CrossFit coaches, every session is packed with energy, community spirit, and progress you can feel. "
                                "Whether you're a beginner or a seasoned athlete, Tizi is where sweat meets results.",
                            nutritionalValue: "N/A",
                            price: 1000.0,
                            imageAsset: "Images/Tizilogin.png",
                            deliveryTime: 0,
                            qualifications: '',
                            location: 'Lavington, Nairobi, Kenya',
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                "Images/Tizilogin.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Tizi CrossFit Zone",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "CrossFit & Functional Training",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "\Ksh7,000 per month",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20.0,
                ),

                // Second vertical gym placeholder
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Productdetails(
                          product: Product(
                            id: 1,
                            name: "Flex Fitness",
                            description:
                                "Flex Fitness is where dedication meets transformation. "
                                "From strength training and hypertrophy to functional workouts and personal coaching, we offer everything you need to level up your fitness game. "
                                "Our facility features top-tier equipment, elite trainers, and an environment built to push you beyond your limits. "
                                "At Flex Fitness, it’s not just about looking strong — it’s about being strong.",
                            nutritionalValue: "N/A",
                            price: 1000.0,
                            imageAsset: "Images/FC.png",
                            deliveryTime: 0,
                            qualifications: '',
                            location: 'Upper Hill, Nairobi, Kenya"',
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20.0, bottom: 30.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                "Images/FC.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Flex Fitness",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Boutique Gym & Studio Classes",
                                    style: AppWidget
                                        .smallSemiBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "\Ksh5,500 per month",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            trainer2o = true;
            nutritionist = false;
            gyms = false;

            setState(() {});
          },
          child: Material(
            elevation: 0,
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: trainer2o ? Colors.grey[800] : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "Images/trainer2o.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: trainer2o ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            trainer2o = false;
            nutritionist = true;
            gyms = false;
            setState(() {});
          },
          child: Material(
            elevation: 0,
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: nutritionist ? Colors.grey[800] : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "Images/nutritionist.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: nutritionist ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            trainer2o = false;
            nutritionist = false;
            gyms = true;
            setState(() {});
          },
          child: Material(
            elevation: 0,
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: gyms ? Colors.grey[800] : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "Images/gyms.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: gyms ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
