import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/constant.dart';
import '../weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;

  const MainScreen({required this.weatherData});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage? backgroundImage;
  late String city;
  late String weatherDescription;
  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.temperature.round();
      city = weatherData.city;
      weatherDescription = weatherData.getMessage(temperature);

      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //Genişleyebilsin diye
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage!,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 60,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                '$temperature°',
                style: kTempTextStyle,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                city,
                style: kCityTextStyle,
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Center(
              child: Text(
                ' $weatherDescription ',
                style: kMessageTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
