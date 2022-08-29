import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/location.dart';
import '../weather.dart';
import 'main_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      print("Konum bilgileri alınamadı.");
    } else {
      print("Enlem: ${locationData.latitude}");
      print("Boylam: ${locationData.longitude}");
    }
  }

  void getWeatherData() async {
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.temperature == null || weatherData.condition == null) {
      print("API den sıcaklık veya durum bilgisi boş dönüyor.");
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        weatherData: weatherData,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.blue]),
        ),
        child: const Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
