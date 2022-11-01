// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:personal_expenses_new/screens/consts.dart';
import 'package:personal_expenses_new/screens/btm_bar_screen.dart';

// import 'package:personal_expenses/screens/salary_screen.dart';
import 'package:personal_expenses_new/screens/salary_screen.dart';
// import 'package:personal_expenses/screens/salary_screen.dart';
// import 'package:personal_expenses_new/screens/salary_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        // height:  MediaQuery.of(context).size.height / 1.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/savings.png'))),
            ),
            // ignore: avoid_unnecessary_containers
            SizedBox(height: 70),
            Align(
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  'قلل مصروفاتك وحسن من ادارة اموالك\n  وتنمية'
                  ' مدخراتك باستخدام مصاريف ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'SanFrancisco',
                    // textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (box.read('salary') != null) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return const BottomBarScreen();
                      },
                    ));
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return const SalaryScreen();
                        },
                      ),
                    );
                  }
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return const SalaryScreen();
                  //     },
                  //   ),
                  // );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: const Text('ابدأ  ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
