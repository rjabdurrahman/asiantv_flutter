import 'package:flutter/material.dart';
class MessageBox extends StatelessWidget {

  MessageBox(this.icon, this.iconColor, this.message);

  IconData icon;
  Color iconColor;
  String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 48,),
            SizedBox(
              height: 10,
            ),
            Text(message, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),)
          ],
        ),
      ),
    );
  }
}
