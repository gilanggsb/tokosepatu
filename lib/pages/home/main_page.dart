import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokosepatu/main.dart';
import 'package:tokosepatu/pages/home/chat_page.dart';
import 'package:tokosepatu/pages/home/profile_page.dart';
import 'package:tokosepatu/pages/home/wishlist_page.dart';
import 'package:tokosepatu/providers/page_provider.dart';
import 'package:tokosepatu/theme.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    Widget cartButton() {
      return FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        child: Image.asset(
          'assets/icons/icon_cart.png',
          width: 20,
        ),
      );
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
              currentIndex: pageProvider.currentIndex,
              onTap: (index) {
                setState(() {
                  pageProvider.currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: backgroundColor4,
              items: [
                BottomNavigationBarItem(
                  label: '',
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'assets/icons/icon_home.png',
                      width: 21,
                      color: pageProvider.currentIndex == 0
                          ? primaryColor
                          : const Color(0xFF808191),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'assets/icons/icon_message.png',
                      width: 20,
                      color: pageProvider.currentIndex == 1
                          ? primaryColor
                          : const Color(0xFF808191),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'assets/icons/icon_favorit.png',
                      width: 20,
                      color: pageProvider.currentIndex == 2
                          ? primaryColor
                          : const Color(0xFF808191),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'assets/icons/icon_profile.png',
                      width: 18,
                      color: pageProvider.currentIndex == 3
                          ? primaryColor
                          : const Color(0xFF808191),
                    ),
                  ),
                ),
              ]),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return const HomePage();

        case 1:
          return const ChatPage();

        case 2:
          return const WishListPage();

        case 3:
          return const ProfilePage();

        default:
          return const HomePage();
      }
    }

    return Scaffold(
        backgroundColor: pageProvider.currentIndex == 0
            ? backgroundColor1
            : backgroundColor3,
        bottomNavigationBar: customBottomNav(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: cartButton(),
        body: body());
  }
}
