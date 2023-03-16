import 'package:cyfi/config/Palette.dart';
import 'package:flutter/material.dart';



class mesage{
  final context;
  mesage({this.context});
   box(header,body){
    return showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: AlertDialog(
            backgroundColor: Palette.mainColor,
            title:  Text("$header"),
            content:  Text("$body"),
            titleTextStyle: TextStyle(color: Palette.accentSubColor,fontSize: 17),
            contentTextStyle: TextStyle(color: Palette.accentSubColor,fontSize: 17),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:  Text(
                    "ok",
                    style: TextStyle(color: Palette.accentSubColor, fontSize: 17),
                  ))
            ],
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}