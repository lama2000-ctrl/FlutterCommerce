

import 'package:delivery/pages/account/account_page.dart';
import 'package:delivery/pages/cart/cart_history.dart';
import 'package:delivery/pages/home/main_food_page.dart';
import 'package:delivery/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;
  late PersistentTabController _controller;

  List pages=[
    MainFoodPage(),
    Container(child: Center(child: Text("Next Page")),),
    CartHistory(),
   AccountPage(),


  ];
  void onTapNav(int index){
    setState(() {
       _selectedIndex=index;
    });
   
  }

  @override
void initState(){
  super.initState();
  _controller = PersistentTabController(initialIndex: 0);
}
List<Widget> _buildScreens() {
        return [
            pages[0],
    pages[1],
    pages[2],
    pages[3],
        ];
    }
    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: Icon(Icons.home),
                title: ("Home"),
                activeColorPrimary: Colors.blueAccent,
                inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
                icon: Icon(Icons.archive),
                title: ("Archive"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
            ),
               PersistentBottomNavBarItem(
                icon: Icon(Icons.shopping_cart),
                title: ("Cart"),
                activeColorPrimary: Colors.blueAccent,
                inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
                icon: Icon(Icons.person),
                title: ("Me"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
            ),
        ];
    }
  @override
  Widget build(BuildContext context) {

  //   return Scaffold(
  //     body: pages[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       onTap: onTapNav,
  //       currentIndex: _selectedIndex,
  //       selectedItemColor: AppColors.mainColor,
  //       selectedFontSize: 0.0,
  //       unselectedFontSize: 0.0,
  //       unselectedItemColor: Colors.amberAccent,
  //       showSelectedLabels: false,
  //       showUnselectedLabels: false,
  //       items: const[
  //      BottomNavigationBarItem(icon: 
  //      Icon(Icons.home_outlined),label: "home"),
  //       BottomNavigationBarItem(icon: 
  //      Icon(Icons.archive),label: "archive"),
  //       BottomNavigationBarItem(icon: 
  //      Icon(Icons.shopping_cart),label: "Cart"),
  //       BottomNavigationBarItem(icon: 
  //      Icon(Icons.person),label: "Me"),
  //     ]),
  //   );
  // }
return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.grey.shade50, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style14, // Choose the nav bar style with this property.
    );

}
}