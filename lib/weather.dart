import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hava_durumu_flutter/services/location.dart';
import 'package:http/http.dart';

const apiKey = "************************";

class WeatherDisplayData {
  late Icon weatherIcon;
  late AssetImage weatherImage;
  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  late String weatherDescription;

  WeatherData({required this.locationData});
  late LocationHelper locationData;
  late double temperature;
  late int condition;
  late String city;

  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric"));

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        temperature = currentWeather['main']['temp'];
        condition = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
        weatherDescription = getMessage(temperature.round());
      } catch (e) {
        print(e);
      }
    } else {
      print("API den değer gelmiyor!");
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    //hava iyi
    //gece gündüz kontrolü
    var now = new DateTime.now();
    if (now.hour >= 19) {
      if (condition < 300) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.cloudBolt,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gece.jpg'));
      } else if (condition < 400) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.cloudShowersHeavy,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gece.jpg'));
      } else if (condition < 600) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.umbrella,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gece.jpg'));
      } else if (condition < 700) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.snowflake,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gece.jpg'));
      } else if (condition < 800) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.cloudflare,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gece.jpg'));
      } else if (condition == 800) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.moon,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gece.jpg'));
      } else if (condition <= 804) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.cloud,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gece.jpg'));
      } else {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.cloud,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gece.jpg'));
      }
    } else {
      if (condition < 300) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.cloudBolt,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gunduz.jpg'));
      } else if (condition < 400) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.cloudShowersHeavy,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gunduz.jpg'));
      } else if (condition < 600) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.umbrella,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gunduz.jpg'));
      } else if (condition < 700) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.snowflake,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gunduz.jpg'));
      } else if (condition < 800) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.cloudflare,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gunduz.jpg'));
      } else if (condition == 800) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.sun,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gunduz.jpg'));
      } else if (condition <= 804) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.cloud,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gunduz.jpg'));
      } else {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.cloud,
                size: 75.0, color: Colors.white),
            weatherImage: const AssetImage('images/gunduz.jpg'));
      }
    }
  }
}
