import 'package:flutter/material.dart';
import 'package:tiziappp2/presentation/productdetails.dart';
import 'package:tiziappp2/technicals/widgets/database.dart';
import 'package:tiziappp2/technicals/widgets/supportwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

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
                    Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
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
                    Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
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
                    Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
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
                              builder: (context) => const Productdetails(),
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
                              builder: (context) => Productdetails(),
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
                        builder: (context) => Productdetails(),
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
                        builder: (context) => Productdetails(),
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
                        builder: (context) => Productdetails(),
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

                // Fitness Zone Gym
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Productdetails(),
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
                                    "Fitness Zone Gym",
                                    style: AppWidget.smallBoldTextFieledStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Full Service Gym Facility",
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
                                    "\Ksh5,000 per month",
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
                              builder: (context) => Productdetails(),
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
                              builder: (context) => Productdetails(),
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
                        builder: (context) => Productdetails(),
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
                        builder: (context) => Productdetails(),
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
                              builder: (context) => Productdetails(),
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
                              builder: (context) => Productdetails(),
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
                        builder: (context) => Productdetails(),
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
                        builder: (context) => Productdetails(),
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
            elevation: 5.0,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: trainer2o ? Colors.grey : Colors.white,
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
            elevation: 5.0,
            color: nutritionist ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: Container(
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
            elevation: 5.0,
            color: gyms ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: Container(
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
