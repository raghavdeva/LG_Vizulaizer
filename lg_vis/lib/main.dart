import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lg_vis/Activity/loading.dart';
import 'package:lg_vis/Activity/home.dart';
import 'package:lg_vis/utils/theme/theme.dart';
import 'package:lg_vis/connections/file_create.dart';

import 'Activity/setting.dart';

void setupServices(){
  GetIt.I.registerLazySingleton(() => FileCreate());
}



void main() {
  setupServices();
  print("Get Instance Created");
  runApp(const App());

}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: LgAppTheme.lightTheme,
      darkTheme: LgAppTheme.DarkTheme,
      routes: {
        "/home" : (context) => const Home(),
        "/" : (context) => const Loading(),
        "/loading" : (context) => const Loading(),
        "/setting" : (context) => const Settings()
      },
    );
  }
}
