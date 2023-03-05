
import 'package:flutter/material.dart';
import 'package:cyfi/config/palette.dart';


class VirusTotal extends StatefulWidget {

  const VirusTotal({super.key});

  @override
  State<VirusTotal> createState() => _VirusTotalState();
}

class _VirusTotalState extends State<VirusTotal> {
   int _selectedIndex=1;
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index==0){
      Navigator.pushNamed(context, "/AbuseIPDB");
    }
    if(index==2){
      Navigator.pushNamed(context, "/");
    }
    else if(index==3){
      Navigator.pushNamed(context,"/search");
    }
  }
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("VirusTotal",style:TextStyle(color: palette.barTextColor), ),
        titleTextStyle: palette.mainTitle,
        backgroundColor: palette.barColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: palette.barTextColor),
      ),
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: palette.barColor,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/index-removebg-preview.png",width: 30,height: 30,),     
            label: "AbDB",      
            ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/vt_icon-removebg-preview.png",width: 30,height: 30,),     
            label: "VT",      
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search"
            ),            
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      )
    );
}
}