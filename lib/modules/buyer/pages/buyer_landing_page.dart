import 'dart:async';
import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:captain_bonik_app/common/widgets/bottom_navigation_bar.dart';
import 'package:captain_bonik_app/common/widgets/rounded_corner.dart';
import 'package:flutter/material.dart';

import 'buyer_home_page.dart';

class UserLandPage extends StatefulWidget {
  @override
  _UserLandPageState createState() => _UserLandPageState();
}

class _UserLandPageState extends State<UserLandPage> with App{
  final _activeColor = Colors.blue;
  final _inactiveColor = Colors.grey.withOpacity(.6);
  StreamController<int> _tabBarController = StreamController.broadcast();
  PageController _pageViewController = PageController(initialPage: 0,keepPage: true,);

  @override
  void initState() {
    super.initState();
    AppEvents.instance.languageChangeEvent.listen((event) {
      if( mounted && !_tabBarController.isClosed)_tabBarController.sink.add(_pageViewController.page.round());
    });

    AppEvents.instance.tabChangeEvent.listen((event) {_onTabChange(event);});
  }

  @override
  void dispose() {
    _tabBarController.close();
    _pageViewController.dispose();
    super.dispose();
  }

  _onTabChange(int index){
    if(mounted && !_tabBarController.isClosed)_tabBarController.sink.add(index);
    _pageViewController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeOutCubic);
  }


  @override
  Widget build(BuildContext context) {
    App.initApp(context);
    return RoundedCorner(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: StreamBuilder<int>(
            stream: _tabBarController.stream,
            initialData: 0,
            builder: (context, snapshot) {
              return BottomNavBar(
                selectedIndex: snapshot.data,
                animationDuration: Duration(milliseconds: 550),
                containerHeight: 56,
                curve: Curves.easeOutCubic,
                iconSize: 27,
                onItemSelected: _onTabChange,
                items: [
                  BottomNavBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Home'),
                    activeColor: _activeColor,
                    inactiveColor: _inactiveColor,
                  ),
                  BottomNavBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Home'),
                    activeColor: _activeColor,
                    inactiveColor: _inactiveColor,
                  ),
                  BottomNavBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Home'),
                    activeColor: _activeColor,
                    inactiveColor: _inactiveColor,
                  ),
                  BottomNavBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Home'),
                    activeColor: _activeColor,
                    inactiveColor: _inactiveColor,
                  ),
                  BottomNavBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Home'),
                    activeColor: _activeColor,
                    inactiveColor: _inactiveColor,
                  ),

                ],
              );
            }
        ),
        body: PageView(
          controller: _pageViewController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            BuyerHomePage(),
            BuyerHomePage(),
            BuyerHomePage(),
            BuyerHomePage(),
            BuyerHomePage(),
          ],
        ),
      ),
    );
  }
}
