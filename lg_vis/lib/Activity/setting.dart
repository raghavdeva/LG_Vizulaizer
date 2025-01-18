import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../connections/ssh.dart';
import '../utils/Connection/connectionFlag.dart';
import '../utils/device/device_utils.dart';
import 'package:lg_vis/utils/widget/button.dart';
import 'appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartssh2/dartssh2.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _sshPortController = TextEditingController();
  final TextEditingController _rigsController = TextEditingController();

  SSH ssh = SSH();
  @override
  void initState() {
    super.initState();

    _loadSettings();
    _connectToLG();
  }

  Future<void> _connectToLG() async {
    setState(() {
      isloading = true;
    });
    bool? result = await ssh.connectToLG();
    setState(() {
      connectionStatus = result!;
      isloading = false;
    });
  }

  @override
  void dispose() {
    _ipController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _sshPortController.dispose();
    _rigsController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ipController.text = prefs.getString('ipAddress') ?? '';
      _usernameController.text = prefs.getString('username') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      _sshPortController.text = prefs.getString('sshPort') ?? '';
      _rigsController.text = prefs.getString('numberOfRigs') ?? '';
    });
  }

  Future<void> _saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_ipController.text.isNotEmpty) {
      await prefs.setString('ipAddress', _ipController.text);
    }
    if (_usernameController.text.isNotEmpty) {
      await prefs.setString('username', _usernameController.text);
    }
    if (_passwordController.text.isNotEmpty) {
      await prefs.setString('password', _passwordController.text);
    }
    if (_sshPortController.text.isNotEmpty) {
      await prefs.setString('sshPort', _sshPortController.text);
    }
    if (_rigsController.text.isNotEmpty) {
      await prefs.setString('numberOfRigs', _rigsController.text);
    }
  }
  bool connectionStatus = false;
  bool isloading = false;
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
              SingleChildScrollView(
                child: Container(
                  height: Screenheight,
                  width: Screenwidth,
                  child: Column(
                    children: [
                      //App Bar
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
                            LgAppBar(title: Text("Settings", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Theme.of(context).splashColor),),
                              actions: [
                                Icon(IonIcons.settings, size: 28, color: Theme.of(context).splashColor,)
                              ],
                            showBackArrow: true,)
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Connectionflag(status: connectionStatus,),
                      SizedBox(height: 20.0,),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 30.0),
                           height: Screenheight*0.7,
                          width: Screenwidth*0.9,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                              )
                          ),
                          child: Column(
                            children: [
                              Spacer(),
                              TextField(
                                controller: _ipController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.computing_outline,),
                                  labelText: 'IP address',
                                  hintText: 'Enter Master IP',
                                  border: OutlineInputBorder(),
                        
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              Spacer(),
                              TextField(
                                controller: _usernameController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  labelText: 'LG Username',
                                  hintText: 'Enter your username',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              Spacer(),
                              TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  labelText: 'LG Password',
                                  hintText: 'Enter your password',
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                              ),
                              Spacer(),
                              TextField(
                                controller: _sshPortController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.settings_ethernet),
                                  labelText: 'SSH Port',
                                  hintText: '22',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              Spacer(),
                              TextField(
                                controller: _rigsController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.memory),
                                  labelText: 'No. of LG rigs',
                                  hintText: 'Enter the number of rigs',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              Spacer(),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Button(
                                    label: 'Connect',
                                    width: 150,
                                    height: 60,
                                    loading: isloading,
                                    icon: Icon(
                                      Icons.connected_tv_rounded,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      _saveSettings();
                                      setState(() {
                                        isloading = true;
                                      });
                                      await _saveSettings();
                                      SSH ssh = SSH();
                                      bool? result = await ssh.connectToLG();
                                      if (result == true) {
                                        setState(() {
                                          connectionStatus = true;
                                          isloading = false;
                                        });
                                      }else{
                                        setState(() {
                                          connectionStatus = false;
                                          isloading = false;
                                        });
                                      }
                                    }
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                    ]
                  )
                ),
              ),

            ],
          )
        ),
      ),
    );
  }
}
