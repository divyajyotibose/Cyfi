import 'package:cyfi/config/palette.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
     int _selectedIndex=2;
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index==0){
      Navigator.pushNamed(context, "/AbuseIPDB");
    }
    if(index==1){
      Navigator.pushNamed(context, "/VirusTotal");
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
    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
      drawer: Drawer(
        child: ListView(children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: palette.DrawerHeaderColor,              
              ),
              child: Text("The DataBases"),
            ),
            ListTile(
              title: Text("AbuseIPDB"),
              onTap: (){
                Navigator.pushNamed(context,"/AbuseIPDB");
              },
            ),
            ListTile(
              title: Text("VirusTotal"),
              onTap: (){
                Navigator.pushNamed(context,"/VirusTotal");
              },
            ),
            ListTile(
              title: Text("WhatsMyIP"),
              onTap: (){
                Navigator.pop(context);
              },
            )

        ]
        ),
      ),
      appBar: AppBar(
        title: Text("Cyfi",style:TextStyle(color: palette.barTextColor), ),
        titleTextStyle: palette.mainTitle,
        backgroundColor: palette.barColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: palette.barTextColor),
      ),
      backgroundColor:palette.bgColor ,
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