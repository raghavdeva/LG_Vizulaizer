import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lg_vis/Activity/appbar.dart';
import 'package:lg_vis/kml/India_kml.dart';
import 'package:lg_vis/kml/look_at.dart';
import 'package:lg_vis/kml/rocket_kml.dart';
import 'package:lg_vis/utils/device/device_utils.dart';
import 'package:lg_vis/utils/theme/button_theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lg_vis/utils/widget/confirm_dialog.dart';

import '../connections/ssh.dart';
import '../kml/kml_entity.dart';

bool connectionStatus = false;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SSH ssh;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ssh = SSH();
    _connectToLG;
  }

  Future<void> _connectToLG() async {
    bool? result = await ssh.connectToLG();
    setState(() {
      connectionStatus = result!;
    });
  }


  @override
  Widget build(BuildContext context) {
    double Screenheight = LgDeviceUtils.screenHeight(context);
    double Screenwidth = LgDeviceUtils.screenWidth(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: Screenheight,
                width: Screenwidth,
                padding: const EdgeInsets.all(0),
                color: Theme.of(context).colorScheme.surface,
              ),
              Container(
                height: Screenheight,
                width: Screenwidth,
                child: Column(
                  children: [
                    Container(
                      width: Screenwidth,
                      height: LgDeviceUtils.getAppBarHeight(),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0)
                        )

                      ),
                      child: Stack(
                        children: [
                          LgAppBar(title: Text("Galaxy Vizualizer", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: Theme.of(context).splashColor),),
                          actions: [
                            IconButton(onPressed: () async{
                              await Navigator.pushNamed(context, '/setting');
                              _connectToLG();
                            }, icon: Icon(Iconsax.setting_2_bold, color: Theme.of(context).splashColor, ))
                          ],)
                        ],
                      ),
                    ),
                    Spacer(),
                    Image.asset('assets/logos/LgLOGO.png',
                      width: 300,
                        height: Screenheight*0.3,

                    ),
                    Spacer(),
                    Container(
                      height: Screenheight*0.5,
                      width: Screenwidth,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                          )
                      ),
                      child: Column(
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 60.0),
                                child: ElevatedButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Iconsax.eye_bold, color: Colors.white, size: 20, ),
                                      SizedBox(width: 10,),
                                      Text('Show Logo'),
                                    ],
                                  ),
                                  onPressed: () async{
                                    await ssh.showLogo();
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 60.0),
                                child: ElevatedButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(IonIcons.rocket, color: Colors.white, size: 20,),
                                      SizedBox(width: 10,),
                                      Text('Nasa'),
                                    ],
                                  ),
                                  onPressed: () async {
                                    await ssh.showLogo();
                                    String Name = "Rocket_file";
                                    await ssh.uploadKmlAndAssets(RocketKml().rocket, Name);
                                    final kmlUrl = 'http://lg1:81/kmls/${Name}.kml';
                                    await ssh.displayKmlOnLiquidGalaxy(kmlUrl);
                                    await ssh.flyTo(LookAt(lng: -80.583633, lat: 28.578920, range: '500', tilt: '45', heading: '0', altitude: 667.36));
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 40.0),
                                child: ElevatedButton(
                                  
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Iconsax.map_1_bold, color: Colors.white, size: 20),
                                      SizedBox(width: 10,),
                                      Text('India'),
                                    ],
                                  ),
                                  onPressed: () async {

                                    String Name = "India_file";
                                    await ssh.uploadKmlAndAssets(IndiaKml().india, Name);
                                    final kmlUrl = "http://lg1:81/kmls/${Name}.kml";
                                    await ssh.displayKmlOnLiquidGalaxy(kmlUrl);
                                    await ssh.flyTo(LookAt(lng: 78.9629, lat: 20.5937, range: '7000000', tilt: '0', heading: '0'));
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40.0),
                                child: ElevatedButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Iconsax.brush_1_bold, color: Colors.white, size: 20,),
                                      SizedBox(width: 10,),
                                      Text('Clean Logo'),
                                    ],
                                  ),
                                  onPressed: () async {
                                    await ssh.clearKml(keepLogos: false);
                                    print("Logo cleaned");
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 40.0),
                                child: ElevatedButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(IonIcons.earth, color: Colors.white, size: 20,),
                                      SizedBox(width: 10,),
                                      Text('Clean KML'),
                                    ],
                                  ),
                                  onPressed: () async {
                                    await ssh.clearKml(keepLogos: true);
                                    print("KMl cleaned");
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40.0),
                                child: ElevatedButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(IonIcons.power, color: Colors.white, size: 20,),
                                      SizedBox(width: 10,),
                                      Text('Shutdown'),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 18),
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                                  ),
                                  onPressed: () async{
                                    showDialog(context: context, builder: (context) => ConfirmDialog(title: 'Are you Sure?',
                                        message: 'The system will shutdown',
                                        onCancel: (){
                                      Navigator.of(context).pop();
                                        }, onConfirm: () async {
                                      Navigator.of(context).pop();

                                      try{
                                        await ssh.shutdownLG();
                                      }catch(e){
                                        final snackbar = SnackBar(content: const Text('The system failed to shutdown'));
                                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                      }

                                        }));
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
