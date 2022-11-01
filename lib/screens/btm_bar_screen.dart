import 'package:flutter/material.dart';
import 'package:personal_expenses_new/screens/chart_screen.dart';
import 'package:personal_expenses_new/screens/history_screen.dart';
import 'package:personal_expenses_new/screens/home_screen.dart';
import 'package:personal_expenses_new/screens/settings_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

// البوتون بار تحت عشان التنقلات
//نحط الاندكس عشان اعرف انا واقفة بأي صفحة حسب الاندكس
class _BottomBarScreenState extends State<BottomBarScreen> {
  int _currentIndex = 3;
  // الاندكس الاول زيرو عشان يبقى بالهوم

//list of map
// key:"value"
// انشأت الماب ذي عشان آخذ الpages
// و استخدمها في الbody تبع الscafold في البوتن سكرين باد نفسها
  final List<Map<String, dynamic>> _pages = const [
    {'title': 'الإعدادات', 'screen': SettingScreen()},
    {'title': 'السجل', 'screen': HistoryScreen()},
    {'title': 'الاحصائيات', 'screen': ChartScreen()},
    {'title': 'المصاريف', 'screen': HomeScreen()},
  ];
// انشآت الفنكشن هذي عشان تغير لي الاندكس لما اختار صفحة غير الهوم المبدآية
// راح احتاج هذي الفنكشن في الاون تاب تحت بحيث لما اضغط تكون مهمة الفنكشن تاخذني على الاندكس اللي صار عليه الاون تاب
  void _selectedPage(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //pages of index screen
      body: _pages[_currentIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        currentIndex: _currentIndex,
        // هنا استدعينا الفنكشن اللي تغير لي الاندكس مع الاون تاب
        onTap: _selectedPage,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? Image.asset(
                    'assets/images/14.png',
                    color: Theme.of(context).primaryColor,
                  )
                : Image.asset(
                    'assets/images/14.png',
                    color: Colors.grey,
                  ),
            label: 'الإعدادات',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Image.asset(
                    'assets/images/13.png',
                    color: Theme.of(context).primaryColor,
                  )
                : Image.asset(
                    'assets/images/13.png',
                    color: Colors.grey,
                  ),
            label: 'السجل',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? Image.asset(
                    'assets/images/12.png',
                    color: Theme.of(context).primaryColor,
                  )
                : Image.asset(
                    'assets/images/12.png',
                    color: Colors.grey,
                  ),
            label: 'الاحصائيات',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3
                ? Image.asset(
                    'assets/images/11.png',
                    color: Theme.of(context).primaryColor,
                  )
                : Image.asset(
                    'assets/images/11.png',
                    color: Colors.grey,
                  ),
            label: 'المصاريف',
          ),
        ],
      ),
    );
  }
}
