import 'package:flutter/material.dart';
import 'package:tv_app/pages/HomePage.dart';
import './constants/colors.dart' as ColorConstants;

void main() => runApp(MyApp());

//Application root widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asian TV',
      theme: ThemeData(primaryColor: ColorConstants.DEFAULT_BACKGROUND_COLOR),
      home: HomePage(),
    );
  }
}
