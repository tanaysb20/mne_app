import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mne/Modals/entry.dart';
import 'package:mne/Modals/party.dart';
import 'package:mne/Modals/user.dart';
import 'package:mne/Provider/auth_provider.dart';
import 'package:mne/Provider/entry_provider.dart';
import 'package:mne/Screens/Auth/login_screen.dart';
import 'package:mne/Screens/Home/landing_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EntryModelAdapter());
  Hive.registerAdapter(PartyModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(PictureAdapter());
  Hive.registerAdapter(BagsModelAdapter());
  await Hive.openBox<EntryModel>('entryBox');
  await Hive.openBox<PartyModel>('partyBox');

  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.hourGlass
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => EntryProvider()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: NavigationScreen(),
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
          );
        },
        designSize: const Size(360, 800),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<NavigationScreen> {
  bool splash = false;

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("userToken");
    log("$token");
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      splash = true;
    });
    if (token == null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LandingScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    navigationPage();
  }

  @override
  Widget build(BuildContext context) {
    return splash
        ? Container()
        : Scaffold(
            body: Container(
                width: double.infinity,
                child: Image.asset("assets/splash.png", fit: BoxFit.cover)),
          );
  }
}
