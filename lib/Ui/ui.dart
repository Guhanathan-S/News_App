import 'package:flutter/material.dart';

ThemeData kThemes = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    platform: TargetPlatform.iOS);

AppBar kAppBar = AppBar(
  centerTitle: true,
  title: RichText(
    textAlign: TextAlign.center,
    text: TextSpan(children: <TextSpan>[
      TextSpan(text: "FLutter", style: TextStyle(color: Colors.blue)),
      TextSpan(text: "News", style: TextStyle(color: Colors.black)),
    ]),
  ),
);

var business = "assets/category/Business.jpg",
    entertainment = "assets/category/Entertainment.jpg",
    general = "assets/category/General.jpg",
    health = "assets/category/Health.jpg",
    sports = "assets/category/Sports.jpg",
    science = "assets/category/Science.jpg",
    technology = "assets/category/Technology.jpg";
