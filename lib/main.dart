import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:servizo_vendor/AppBindings.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';
import 'package:servizo_vendor/app/theme/theme_data.dart';
import 'package:servizo_vendor/di.dart';
import 'package:servizo_vendor/firebase_options.dart';

@pragma('vm:entry-point')
bool isLocalAuth = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DenpendencyInjection.init();
  runApp(
    GetMaterialApp(
      title: "Servizo",
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.light,
      builder: EasyLoading.init(),
      defaultTransition: Transition.cupertino,
      initialBinding: AppBinding(),
    ),
  );
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
