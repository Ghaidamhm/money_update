// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:personal_expenses/screens/btm_bar_screen.dart';
import 'package:personal_expenses_new/screens/consts.dart';
import 'package:personal_expenses_new/screens/btm_bar_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(142, 84, 233, 1),
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromRGBO(142, 84, 233, 1),
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // int salary = 0;
  void setSalary(int salary) {
    setState(() {
      box.write('salary', salary);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController = TextEditingController(
        text: '${(selectedDate.toLocal())}'.split(' ')[0]);

    final salaryController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(248, 248, 248, 0.92),
        elevation: 0,
        title: const Text(
          'الاعدادات',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 1.0,
              margin: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/arrow-down.png'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'الراتب',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 196, 140, 1),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/money.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ' : الراتب',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 325,
                  child: TextField(
                    // لاجبار المستخدم علي ادخال قيم موجبة صحيحة
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                    controller: salaryController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: '0.0',
                      suffixText: ' ر.س ',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  ' : تاريخ الراتب',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 325,
                  child: TextField(
                    controller: dateController,
                    keyboardType: TextInputType.datetime,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                        ),
                      ),
                      hintText: 'd/m/y',
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Center(
                  child: SizedBox(
                    width: 135,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed: () {
                        if (salaryController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Column(
                                    children: [
                                      Text(
                                        '!انتبه',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Divider(
                                        color: Colors.grey.withOpacity(0.3),
                                        thickness: 2,
                                      ),
                                      Text(
                                        'برجاء ادخال قيمة للراتب',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          setSalary(int.parse(salaryController.text));
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return const BottomBarScreen();
                              },
                            ),
                          );
                        }
                      },
                      child: const Text('تغيير'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
