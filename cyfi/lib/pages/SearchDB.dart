import 'package:cyfi/pages/apiCall.dart';
import 'package:cyfi/pages/searchResults.dart';
import 'package:flutter/material.dart';
import 'package:cyfi/config/palette.dart';


class SearchDB extends StatefulWidget {
  const SearchDB({super.key});
  
  @override
  State<SearchDB> createState() => _SearchDBState();
}

class _SearchDBState extends State<SearchDB> {
  static TextEditingController ipAddress=TextEditingController();
  bool isChecked1=true;
  bool isChecked2=true;
  bool isChecked3=true; 
  String ip="";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return palette.fillColor;
      }
      return palette.fillColor;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: palette.barColor,
        iconTheme: IconThemeData(color: palette.barTextColor),
        title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color:palette.searchBarColor, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            controller: ipAddress,
            decoration: InputDecoration(
                prefixIcon:  Icon(Icons.search,color: palette.barTextColor,),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear,color: palette.barTextColor,),
                  onPressed: () {
                    ipAddress.text="";
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )
      ),
      backgroundColor: palette.bgColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(width/4, height/6, width/4, height/6),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: palette.ListColor,
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(width/11, height/15, width/9, height/15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Select Database",style: TextStyle(fontSize: width/33),),
                  SizedBox(height: width/33,),
                  Row(children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                      checkColor: palette.checkColor,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked1,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked1 = value!;
                        });
                      },
                                    ),
                    ),
                    SizedBox(width: 10,),
                  Text("AbuseIPDB",style: TextStyle(fontSize: 5*width/264),
                  )
                  ],
                  ),
                  SizedBox(height: width/66,),
                  Row(children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                      checkColor: palette.checkColor,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked2,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked2 = value!;
                        });
                      },
                                    ),
                    ),
                    SizedBox(width: 10,),
                  Text("VirusTotal",style: TextStyle(fontSize: 5*width/264),)
                  ],
                  ),
                  SizedBox(height: width/66,),
                  Row(children: [
                    Transform.scale(
                      scale:1.5 ,
                      child: Checkbox(
                      checkColor: palette.checkColor,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked3,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked3 = value!;
                        });
                      },
                                    ),
                    ),
                    SizedBox(width: 10,),
                  Text("WhatsMyIP",style: TextStyle(fontSize: 5*width/264),)
                  ],
                  ),
                  SizedBox(height: 2*width/99,),
                  Center(
                    child: TextButton(
                      onPressed: (){
                        ip=ipAddress.text;
                        ipAddress.text="";
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>searchResults(ch1:isChecked1,ch2:isChecked2,ch3:isChecked3,text:ip))
                        );
                        
                      },
                      style: TextButton.styleFrom(backgroundColor: Colors.white),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Search",style: TextStyle(fontSize: 25,color: Color.fromARGB(255, 0, 0, 0)),),
                      ),
                      
                    ),
                  ),
                ]
                ),
            ),
          ),
          ),
      ),
      );
  }
}

