import 'package:flutter/material.dart';
import 'package:lg_vis/utils/constants/colors.dart';
import 'package:lg_vis/utils/device/device_utils.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void startApp() async{
    Future.delayed(Duration(seconds: 4), (){
      print("Splash Screen Loaded");
      Navigator.pushReplacementNamed(context, "/home");
    });
  }



  @override
  Widget build(BuildContext context) {
    startApp();
    double screenHeight= LgDeviceUtils.screenHeight(context);
    double screenWidth = LgDeviceUtils.screenWidth(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              children: <Widget>[
                Image.asset('assets/logos/earth_image.png',
                  height: screenHeight*0.25,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("GALAXY", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
                          Text("VIZUALIZER", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Image.asset('assets/logos/Mascot.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.fitWidth,)
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Image.asset('assets/logos/LgLOGO.png',
                      width: screenWidth*0.5,
                      height: screenHeight*0.15,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Image.asset('assets/logos/GsocLogo.png',
                      width: screenWidth * 0.3,
                          height: screenHeight*0.15,
                      fit: BoxFit.fill,)
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Image.asset('assets/logos/lgLab.png',
                        width: screenWidth*0.5,
                        height: screenHeight*0.15,
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Image.asset('assets/logos/lgeu_logo.png',
                        width: screenWidth * 0.3,
                          height: screenHeight*0.15,
                      fit: BoxFit.fitWidth,)
                    ],
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
