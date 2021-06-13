//import 'dart:ffi';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: "weather app",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=mumbai&appid=034df4b8266d10f910ddf73fe32612c4"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['rain']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.redAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "currently in mumbai",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + '\u00B0' : "loading..",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    currently != null ? currently.toString() : "loading..",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: [
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf,
                      color: Colors.redAccent),
                  title: Text("Temperature"),
                  trailing: Text(
                      temp != null ? temp.toString() + '\u00B0' : "loading.."),
                ),
                ListTile(
                  leading:
                      FaIcon(FontAwesomeIcons.cloud, color: Colors.blueAccent),
                  title: Text("Wheather"),
                  trailing: Text(description != null
                      ? description.toString()
                      : "loading.."),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun, color: Colors.amber),
                  title: Text("Humidity"),
                  trailing: Text(
                      humidity != null ? humidity.toString() : "loading.."),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind, color: Colors.black26),
                  title: Text("WindSpeed"),
                  trailing: Text(
                      windSpeed != null ? windSpeed.toString() : "loading.."),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
