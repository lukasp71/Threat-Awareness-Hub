import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senior_project/news_section/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      //navigate to home screen replacing the view
      Get.offAndToNamed('/homePage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.burgundy,
      body: Center(child: Image.asset('assets/flashNews.jpg')),
    );
  }
}
