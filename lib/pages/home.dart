import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trust_location/trust_location.dart';
import '../bottom_navigation_bar.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? latitude;
  String? longitude;
  bool? isMock;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  void _requestPermission() async {
    final permission = await Permission.location.request();

    if (permission == PermissionStatus.granted) {
      TrustLocation.start(10);
      _getLocation();
    } else if (permission == PermissionStatus.denied) {
      await Permission.location.request();
    }
  }

  void _getLocation() async {
    try {
      TrustLocation.onChange.listen((values) {
        setState(() {
          latitude = values.latitude.toString();
          longitude = values.longitude.toString();
          isMock = values.isMockLocation;
        });
        _geoCode();
      });
    } catch (e) {
      print('error');
    }
  }

  void _geoCode() async {
    if (latitude != null && longitude != null) {
      List<Placemark> placemark = await placemarkFromCoordinates(
          double.parse(latitude!), double.parse(longitude!));

      print(placemark[0].country);
      print(placemark[0].locality);
      print(placemark[0].postalCode);
      print(placemark[0].street);
    }
  }

  @override
  void dispose() {
    TrustLocation.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          latitude != null && latitude!.isNotEmpty
              ? 'Latitude: $latitude\nLongitude: $longitude\nIs Mock: $isMock'
              : 'No location data',
          style: const TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          }
        },
      ),
    );
  }
}
