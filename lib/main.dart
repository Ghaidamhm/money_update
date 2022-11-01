import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:personal_expenses_new/screens/onboarding_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() async {
  await GetStorage.init();
  FlutterNativeSplash.removeAfter(initialization);


  runApp(const MyApp());
}
Future initialization(BuildContext context)async{
  await Future.delayed(Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(142, 84, 233, 1),
      ),
      title: 'Personal Expenses',
      home: const OnBoardingScreen(),
    );
  }
}
