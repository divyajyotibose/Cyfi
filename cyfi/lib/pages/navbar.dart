import 'package:cyfi/pages/AbuseIPDB.dart';
import 'package:cyfi/pages/VirusTotal.dart';
import 'package:cyfi/pages/WhatsMyIP.dart';
import 'package:flutter/material.dart';
import 'package:cyfi/config/Palette.dart';

import 'SearchDB.dart';

class navbar extends StatefulWidget {
  final ind;
  const navbar({Key? key, this.ind}) : super(key: key);

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    List<Route> l=[_createRoute2(),_createRoute3(),_createRoute1(),_createRoute()];
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pushReplacement(l[index]);
  }
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const SearchDB(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300)
    );
  }
  Route _createRoute1() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const WhatsMyIP(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300)
    );
  }
  Route _createRoute2() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const AbuseIPDB(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300)
    );
  }
  Route _createRoute3() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const VirusTotal(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300)
    );
  }
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.ind;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Palette.mainPadding,
      child: BottomNavigationBar(
        elevation: 0,
        selectedLabelStyle: TextStyle(color: Palette.accentSubColor),

        items: [
          BottomNavigationBarItem(
            backgroundColor: Palette.accentColor,
            icon: AnimatedContainer(
              padding: EdgeInsets.all(5),
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Image.asset(
                "assets/index-removebg1-preview.png",
                width: 30,
                height: 30,
              ),
            ),
            label: "AbDB",

          ),
          BottomNavigationBarItem(
            backgroundColor: Palette.accentColor,
            icon: Image.asset(
              "assets/vt_icon-removebg-preview.png",
              width: 30,
              height: 30,
            ),
            label: "VT",
          ),
          BottomNavigationBarItem(
            backgroundColor: Palette.accentColor,
            icon: Image.asset(
              "assets/wip-removebg-preview.png",
              width: 30,
              height: 30,
            ),
            label: "WIP",
          ),
          BottomNavigationBarItem(
            backgroundColor: Palette.accentColor,
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
            label: "Search",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
