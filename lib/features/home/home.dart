import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/features//messaging_page.dart';
import 'package:nursing_mother_medical_app/features/professional_page.dart';
import 'package:nursing_mother_medical_app/features/profile_page.dart';
import 'package:nursing_mother_medical_app/features/supportlibrary/support_library.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  static final List<Widget> _pages = <Widget>[
    const SupportLibraryPage(),
    const MessagingPage(),
    const ProfessionalPageList(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/home_icon_unselected.png'),
              ),
            activeIcon: Image(
              image: AssetImage('assets/images/home_icon.png'),
            ), label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline), label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), label: ''
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}

