import 'package:flutter/material.dart';
import 'package:cyfi/config/palette.dart';

import 'SearchDB.dart';


class navbar extends StatefulWidget {
  final ind;
  const navbar({Key? key, this.ind}) : super(key: key);

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  int _selectedIndex=0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index==0){
      Navigator.pushReplacementNamed(context, "/AbuseIPDB");
    }
    else if (index == 1) {
      Navigator.pushReplacementNamed(context, "/VirusTotal");
    }
    else if (index == 2) {
      Navigator.pushReplacementNamed(context, "/WIP");
    }
    else if (index == 3) {
      Navigator.pushReplacementNamed(context, "/search");
    }
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
    );
  }
  @override
  void initState(){
    super.initState();
    _selectedIndex=widget.ind;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BottomNavigationBar(
        fixedColor: palette.selColor,

        items: [
          BottomNavigationBarItem(
            backgroundColor: palette.bgColor,
            icon: Image.asset(
              "assets/index-removebg1-preview.png",
              width: 30,
              height: 30,
            ),
            label: "AbDB",
          ),
          BottomNavigationBarItem(
            backgroundColor: palette.bgColor,
            icon: Image.asset(
              "assets/vt_icon-removebg-preview.png",
              width: 30,
              height: 30,
            ),
            label: "VT",
          ),
          BottomNavigationBarItem(
            backgroundColor: palette.bgColor,
            icon: Image.asset(
              "assets/wip-removebg-preview.png", width: 30, height: 30,),
            label: "WIP",
          ),
          BottomNavigationBarItem(
            backgroundColor: palette.bgColor,
            icon: const Icon(Icons.search,size: 30,)
            , label: "Search",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
