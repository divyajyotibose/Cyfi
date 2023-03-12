
import 'package:flutter/material.dart';
import 'package:cyfi/config/palette.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loadingPage extends StatefulWidget {
  const loadingPage({Key? key}) : super(key: key);

  @override
  State<loadingPage> createState() => _loadingPageState();
}

class _loadingPageState extends State<loadingPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;
    return Center(
      child: Container(
        height: height,
        width: width,
        child: SpinKitSquareCircle(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}
