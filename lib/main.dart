// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chips_choice/chips_choice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:news_app/route.dart';
import 'package:news_app/screens/news_detail.dart';
import 'package:news_app/screens/pages/favourite.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'screens/pages/home.dart';


bool? isDarkMode;

Color primaryColor = Colors.red.shade900;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        shadowColor: Colors.grey,
        scaffoldBackgroundColor: (titlelst.isEmpty) ? Colors.white : Colors.grey[200],
        cardColor: Colors.white,
        indicatorColor: Colors.white,
        buttonColor: primaryColor,
        bottomAppBarColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: primaryColor,
          titleTextStyle: TextStyle(
            color: Colors.white,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
              fontSize: 19
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          unselectedItemColor: CupertinoColors.systemGrey,
          selectedItemColor: primaryColor
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        iconTheme: IconThemeData(
            color: Colors.grey
        ),
        shadowColor: Colors.transparent,
        cardColor: Colors.grey.shade800,
        scaffoldBackgroundColor: Colors.black,
        indicatorColor: Colors.white,
        buttonColor: Colors.grey.shade800,
        bottomAppBarColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(
              color: Colors.white,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
            fontSize: 19
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            unselectedItemColor: CupertinoColors.systemGrey,
            selectedItemColor: Colors.white
        ),
      ),
      themeMode: ThemeMode.system,
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  @override
  void initState() {
      var brightness = SchedulerBinding.instance!.window.platformBrightness;
      isDarkMode = brightness == Brightness.dark;
    super.initState();
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      Favourite(),
      RoutePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home, size: 30),
        title: "Home",
        activeColorPrimary: Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
        inactiveColorPrimary: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite, size: 30),
        title: "Favourite",
        activeColorPrimary: Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
        inactiveColorPrimary: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
      ),
      PersistentBottomNavBarItem(
        title: "Profile",
        icon: Icon(Icons.account_circle, size: 30),
        activeColorPrimary: Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
        inactiveColorPrimary: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      // decoration: NavBarDecoration(
      //   colorBehindNavBar: isDarkMode! ? Colors.black : Colors.white,
      // ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInCubic,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style13,
    );
  }
}
