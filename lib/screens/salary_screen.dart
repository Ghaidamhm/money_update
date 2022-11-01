import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses_new/screens/btm_bar_screen.dart';
import 'package:personal_expenses_new/screens/consts.dart';

// int globalSalary = 0;
// int expenses = 0;
// int savings = 0;
// List<Map> historyList = [];

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({super.key});

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
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

  int expenses = 0;
  int savings = 0;
  List historyList = [];

  void setSalary(int salary) {
    setState(() {
      box.write('salary', salary);
      box.write('expenses', expenses);
      box.write('savings', savings);
      box.write('historyList', historyList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController salaryController = TextEditingController();

    final TextEditingController dateController = TextEditingController(
        text: '${(selectedDate.toLocal())}'.split(' ')[0]);

    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              SizedBox(
                // width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 36, left: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      // width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height * .50,
                      child: Image.asset(
                        'assets/images/wallet.png',
                      ),
                    ),
                    const Text(
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
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            // globalSalary = int.parse(salaryController.text);
                            // في حالة كانت قيمة الراتب فارغة يظهر تحذير للمستخدم
                            if (salaryController.text.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: Column(
                                        children: [
                                          const Text(
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
                                          const Text(
                                            'لقد ادخلت رقم خاطئ',
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
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) {
                                  return const BottomBarScreen();
                                },
                              ));
                            }
                          },
                          child: const Text('متابعة'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}










// SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: Image.asset(
//               'assets/images/background.png',
//               fit: BoxFit.fill,
//             ),
//           ),