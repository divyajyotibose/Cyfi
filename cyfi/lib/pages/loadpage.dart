import 'package:flutter/material.dart';
import 'package:cyfi/config/Palette.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loadpage extends StatefulWidget {
  const loadpage({Key? key}) : super(key: key);

  @override
  State<loadpage> createState() => _loadpageState();
}

class _loadpageState extends State<loadpage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      color: Palette.accentColor,
      child: SpinKitSquareCircle(
        color: Palette.accentSubColor,
      ),
    ));
  }
}
