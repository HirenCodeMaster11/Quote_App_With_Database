import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacementNamed('/home'));
    return Scaffold(
      backgroundColor: Color(0xff242D3C),
      body: Center(
        child: Container(
          width: w*0.631,
          height: h*0.308,
          child: Image.asset('assets/s.png',fit: BoxFit.cover,),
        )
      ),
    );
  }
}
