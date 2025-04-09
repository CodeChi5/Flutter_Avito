import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/home/views/homePage.dart';
import 'package:myapp/user/blocs/user_bloc.dart';
import 'package:myapp/user/blocs/user_state.dart';
import 'package:myapp/user/views/AskLoginView.dart';
import 'package:myapp/user/views/RegisterPage.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../user/data/user_repo.dart';

class PersistentNavBar {
  final PersistentTabController controller;
  final BuildContext context;

  PersistentNavBar({
    required this.context,
    int initialIndex = 0,
  }) : controller = PersistentTabController(initialIndex: initialIndex);

  List<Widget> buildScreens() {
    return [
      const HomePageView(),
      const SearchScreen(),
      const AskLoginView(),
      const MessagesScreen(),
      const SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: "Search",
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        title: "Add",
        activeColorPrimary: const Color.fromARGB(255, 109, 255, 5),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message),
        title: "Messages",
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  PersistentTabView build() {
    return PersistentTabView(
      context,
      padding: EdgeInsets.symmetric(vertical: 5),
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),
      backgroundColor: const Color.fromARGB(44, 0, 0, 0),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      isVisible: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}

// Placeholder screens - move these to separate files in a real app
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Home Screen')),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Search Screen')),
    );
  }
}

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Add Screen')),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Messages Screen')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Settings Screen')),
    );
  }
}
