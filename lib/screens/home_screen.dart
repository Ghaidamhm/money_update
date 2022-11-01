import 'package:flutter/material.dart';
import 'package:personal_expenses_new/screens/consts.dart';
import 'package:personal_expenses_new/screens/history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//enum
//بعطيها مجموعة من العناصر
enum Basic {
  internet,
  car,
  medication,
  perfume,
  other,
}

enum Home {
  elec,
  rent,
  other,
}

enum Loan {
  loan,
}

class _HomeScreenState extends State<HomeScreen> {
  Basic? basicSelected = Basic.internet;
  Home? homeSelected = Home.elec;
  Loan? loanSelected = Loan.loan;

  bool othersEnabled = false;

  int salary = 0;
  int expenses = 0;
  int savings = 0;
  List historyList = [];

  @override
  void initState() {
    salary = box.read('salary');
    expenses = box.read('expenses');
    savings = box.read('savings');
    historyList = box.read('historyList');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final savingController = TextEditingController();
    final basicController = TextEditingController();
    final homeController = TextEditingController();
    final loanController = TextEditingController();
    final othersController = TextEditingController();
// المصاريف
// استدعيها في كل مرة اختار شي من المصاريف تحت في الا،ن بريس تطرح من الراتب و تزود المصاريف
    addToExpenses(
        {required int value, required String title, required String subtitle}) {
      setState(() {
        expenses += value;

        historyList.add({
          'value': value,
          'title': title,
          'subtitle': subtitle,
        });

        box.write('expenses', expenses);
        box.write('historyList', historyList);
      });
    }

// المدخرات
// تاخذ فاليو من نوع ارقام و تزود لي اذا كان فيها قيمة سابقة
//استدعيها في الاون بريس تحت حسب حاجتي
    addToSavings(int value) {
      setState(() {
        savings += value;
        box.write('savings', savings);
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(248, 248, 248, 0.92),
        elevation: 0,
        title: const Text(
          'المصاريف',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        //عشان يشيل لي الليدنق اللي فوق و يمنع اليوزر من العودة لصفحة بداية التطبيق بعد مايوصل لصفحة الهوم
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          // المين اكسس هو الاجاه الرئيسي في العمود نخليه سنتر
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 160,
                      child: Center(
                        child: Row(
                          children: [
                            const Text(
                              ' ر.س ',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              //فنكشن طرح الرصيد
                              // الرصيد = (الرصيد-(المدخرات+المصاريف)
                              '${salary - (expenses + savings)}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'الرصيد',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //تظهر لي ويندو الادخار بشودايلوج و تخليني استخدم الاون تاب
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const HistoryScreen();
                          },
                        ));
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        const Text(
                                          ' ر.س ',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '$expenses',
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.arrow_back_ios),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'المصاريف',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height: 140,
                                  width: 60,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextField(
                                        //تاخذ اوبجكت نعرفه فوق عشان بآي وقت احتاج الاشياء اللي خزنتها فيه و اقدر اتعامل معاها
                                        controller: savingController,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            hintText: 'اضف إلى مدخراتك'),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: 180,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                          ),
                                          onPressed: () {
                                            addToSavings(
                                              //ياخذ القيمة كنص و احولها الى رقم في  int.parse
                                              int.parse(savingController.text),
                                            );
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('اضافة'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        const Text(
                                          ' ر.س ',
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(0, 196, 140, 1),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '$savings',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Color.fromRGBO(0, 196, 140, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.arrow_back_ios),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'المدخرات',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(right: 25),
              child: const Text(
                'المصاريف',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    //عشان تظهر لي ويندو تحديد نوع المصاريف تحت
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          //statefullbuilder
                          //كآني اسوي ستيتفل ودجت داخلية جوا البتم شيت بحيث انها تظهر القيم
                          //من غيرها لازم نسوي هوت ريلود او كنترول سيف عشان القيمو تظهر معاي في المصاريف
                          return StatefulBuilder(builder: (context, state) {
                            return Container(
                              height: MediaQuery.of(context).size.height * .65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 30, right: 30, bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            //عشان لما اضغط على الاكس بالويندو تقفل لي الشاشة
                                            Navigator.of(context).pop();
                                          },
                                          child: const Icon(
                                            Icons.close_outlined,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      ' : اختر',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                    value: Basic.medication,
                                                    groupValue: basicSelected,
                                                    fillColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    onChanged: (Basic? value) {
                                                      state(() {
                                                        basicSelected = value;
                                                        othersEnabled = false;
                                                      });
                                                    }),
                                                Text(
                                                  'علاج',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                    //عشان تطلع لي اختيارات
                                                    //اعطيها فاليو مبدآية نت
                                                    value: Basic.internet,
                                                    groupValue: basicSelected,
                                                    fillColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    onChanged: (Basic? value) {
                                                      state(() {
                                                        // احط داخلها القيمة اللي راح اضغط عليها نت او سيارة
                                                        basicSelected = value;
                                                        othersEnabled = false;
                                                      });
                                                    }),
                                                Text(
                                                  'انترنت',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                    value: Basic.other,
                                                    groupValue: basicSelected,
                                                    fillColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    onChanged: (Basic? value) {
                                                      state(() {
                                                        basicSelected = value;
                                                        othersEnabled = true;
                                                      });
                                                    }),
                                                Text(
                                                  'أخرى',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                    value: Basic.car,
                                                    groupValue: basicSelected,
                                                    fillColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    onChanged: (Basic? value) {
                                                      state(() {
                                                        basicSelected = value;
                                                        othersEnabled = false;
                                                      });
                                                    }),
                                                Text(
                                                  'سيارة',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                    //عشان تطلع لي اختيارات
                                                    //اعطيها فاليو مبدآية نت
                                                    value: Basic.perfume,
                                                    groupValue: basicSelected,
                                                    fillColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    onChanged: (Basic? value) {
                                                      state(() {
                                                        // احط داخلها القيمة اللي راح اضغط عليها نت او سيارة
                                                        basicSelected = value;
                                                        othersEnabled = false;
                                                      });
                                                    }),
                                                Text(
                                                  'عطر',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      ' : أخرى',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextField(
                                      enabled: othersEnabled,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.text,
                                      controller: othersController,
                                      decoration: InputDecoration(
                                        hintText: 'أخرى',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 17),
                                    const Text(
                                      ' : المبلغ',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      controller: basicController,
                                      decoration: InputDecoration(
                                        hintText: '0.0',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        suffixText: ' ر.س ',
                                      ),
                                    ),
                                    const SizedBox(height: 21),
                                    SizedBox(
                                      height: 60,
                                      width: double.infinity,
                                      child: StatefulBuilder(
                                          builder: (context, sstate) {
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                          ),
                                          onPressed: () {
                                            if (basicController.text.isEmpty) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              200,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.1,
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            '!انتبه',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          Divider(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3),
                                                            thickness: 2,
                                                          ),
                                                          const Text(
                                                            'برجاء ادخال قيمة ',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              addToExpenses(
                                                value: int.parse(
                                                    basicController.text),
                                                title: 'التزامات شخصية',
                                                subtitle: basicSelected ==
                                                        Basic.internet
                                                    ? 'انترنت'
                                                    : basicSelected == Basic.car
                                                        ? 'سيارة'
                                                        : basicSelected ==
                                                                Basic.medication
                                                            ? 'علاج'
                                                            : basicSelected ==
                                                                    Basic
                                                                        .perfume
                                                                ? 'عطر'
                                                                : othersController
                                                                    .text,
                                              );
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: const Text(
                                            'اضافة',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width - 35,
                    child: Card(
                      elevation: 1.0,
                      margin: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Image.asset('assets/images/arrow-down.png'),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'التزامات شخصية',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/basicss.png',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, state) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 30, right: 30, bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Icon(
                                            Icons.close_outlined,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      ' : اختر',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                                value: Home.other,
                                                groupValue: homeSelected,
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                onChanged: (value) {
                                                  state(() {
                                                    homeSelected = value;
                                                    othersEnabled = true;
                                                  });
                                                }),
                                            Text(
                                              'أخرى',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                                value: Home.elec,
                                                groupValue: homeSelected,
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                onChanged: (value) {
                                                  state(() {
                                                    homeSelected = value;
                                                    othersEnabled = false;
                                                  });
                                                }),
                                            Text(
                                              'كهرباء',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                                value: Home.rent,
                                                groupValue: homeSelected,
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                onChanged: (value) {
                                                  state(() {
                                                    homeSelected = value;
                                                    othersEnabled = false;
                                                  });
                                                }),
                                            Text(
                                              'إيجار',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      ' : أخرى',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextField(
                                      enabled: othersEnabled,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.text,
                                      controller: othersController,
                                      decoration: InputDecoration(
                                        hintText: 'أخري',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 17),
                                    const Text(
                                      ' : المبلغ',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      controller: homeController,
                                      decoration: InputDecoration(
                                        hintText: '0.0',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        suffixText: ' ر.س ',
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      height: 60,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          if (homeController.text.isEmpty) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            200,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                    child: Column(
                                                      children: [
                                                        const Text(
                                                          '!انتبه',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Divider(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          thickness: 2,
                                                        ),
                                                        const Text(
                                                          'برجاء ادخال قيمة ',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            addToExpenses(
                                              value: int.parse(
                                                  homeController.text),
                                              title: 'البيت',
                                              subtitle: homeSelected ==
                                                      Home.elec
                                                  ? 'كهرباء'
                                                  : homeSelected == Home.rent
                                                      ? 'ايجار'
                                                      : othersController.text,
                                            );

                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: const Text(
                                          'اضافة',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width - 35,
                    child: Card(
                      elevation: 1.0,
                      margin: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Image.asset('assets/images/arrow-down.png'),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'البيت',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/homee.png',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, state) {
                            return Container(
                              height: 330,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 30, right: 30, bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Icon(
                                            Icons.close_outlined,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      ' : اختر',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Radio(
                                            value: Loan.loan,
                                            groupValue: loanSelected,
                                            fillColor:
                                                MaterialStateProperty.all(
                                              Theme.of(context).primaryColor,
                                            ),
                                            onChanged: (value) {
                                              state(() {
                                                loanSelected = value;
                                              });
                                            }),
                                        Text(
                                          'قرض',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      ' : المبلغ',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      controller: loanController,
                                      decoration: InputDecoration(
                                        hintText: '0.0',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        suffixText: ' ر.س ',
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      height: 60,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          if (loanController.text.isEmpty) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            200,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                    child: Column(
                                                      children: [
                                                        const Text(
                                                          '!انتبه',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Divider(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          thickness: 2,
                                                        ),
                                                        const Text(
                                                          'برجاء ادخال قيمة ',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            addToExpenses(
                                              value: int.parse(
                                                  loanController.text),
                                              title: 'القرض',
                                              subtitle: 'القرض',
                                            );
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: const Text(
                                          'اضافة',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width - 35,
                    child: Card(
                      elevation: 1.0,
                      margin: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Image.asset('assets/images/arrow-down.png'),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'القرض',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/loon.png',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
