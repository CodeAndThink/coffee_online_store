import 'package:coffee_online_store/view/main/home/home_screen.dart';
import 'package:coffee_online_store/view/main/order/order_screen.dart';
import 'package:coffee_online_store/view/main/rewards/rewards_screen.dart';
import 'package:coffee_online_store/view/main/setting/setting_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const RewardsScreen(),
    const OrderScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).colorScheme.secondary,
        backgroundColor: Colors.transparent,
        index: _selectedIndex,
        items: [
          SvgPicture.asset('assets/icons/home.svg', width: 22, height: 22),
          SvgPicture.asset('assets/icons/gift.svg', width: 22, height: 22),
          SvgPicture.asset('assets/icons/list.svg', width: 22, height: 22),
          SvgPicture.asset('assets/icons/setting.svg', width: 22, height: 22),
        ],
        animationDuration: const Duration(milliseconds: 300),
        onTap: _onItemTapped,
      ),
    );
  }
}
