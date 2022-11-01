import 'package:flutter/material.dart';
import 'package:personal_expenses_new/screens/btm_bar_screen.dart';
import 'package:personal_expenses_new/screens/consts.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List historyList = [];

  @override
  void initState() {
    historyList = box.read('historyList');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(248, 248, 248, 0.92),
        elevation: 0,
        title: const Text(
          'السجل',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return const BottomBarScreen();
                },
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
      ),
      body: historyList.isEmpty
          ? const Center(
              child: Text(
                'لا يوجد مصاريف حاليا',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 0.0,
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    ' ر.س ',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Text(
                                    '${historyList[index]['value']}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    (historyList[index]['title']).toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    (historyList[index]['subtitle']).toString(),
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(0.5),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  (historyList[index]['title'].toString()) ==
                                          'التزامات شخصية'
                                      ? 'assets/images/history1.png'
                                      : (historyList[index]['title']
                                                  .toString()) ==
                                              'البيت'
                                          ? 'assets/images/history2.png'
                                          : (historyList[index]['title']
                                                      .toString()) ==
                                                  'القرض'
                                              ? 'assets/images/history3.png'
                                              : 'assets/images/history1.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
