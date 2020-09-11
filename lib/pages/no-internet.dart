import 'package:flutter/material.dart';

class NoInternetConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white10,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('lib/assets/asiantv.png'),
                height: 150,
              ),
              SizedBox(
                height: 40,
              ),
               Icon(
                 Icons.not_interested,
                 color: Colors.black45,
                 size: 48,
               ),
              SizedBox(
                height: 10,
              ),
              Text("No internet Connection!", textAlign: TextAlign.center, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.red,

              ),)
            ],
          ),
        ),
      ),
    );
  }
}
