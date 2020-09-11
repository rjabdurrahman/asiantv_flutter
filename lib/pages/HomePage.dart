import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:tv_app/helpers/connection.dart';
import 'package:tv_app/pages/livetv.dart';
import 'package:tv_app/pages/no-internet.dart';
import '../widgets/hometoptabs.dart';
import '../constants/colors.dart' as ColorConstants;



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Adding internet connectivity functionality
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;


  // Variables
  bool isOnline = true;


  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  //  Working with stream

  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }


  void CheckConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isOnline =  true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isOnline = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Offline";
        setState(() {
          isOnline = false;
        });
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        CheckConnection();
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
        CheckConnection();
    }

    return DefaultTabController(
      length: 5,
      child: isOnline ? Scaffold(
        appBar:  AppBar(
                backgroundColor: ColorConstants.DEFAULT_MENU_COLOR,
                title: Padding(
                  padding: EdgeInsets.all(1.0),
                  child:TabBar(
                    isScrollable: true,
                    indicatorColor: ColorConstants.MAIN_TAB_INDICATOR_COLOR,
                    indicatorWeight: 3.0,
                    onTap: (index) {
                      //  TODO: Main tab bar onTap Function
                    },
                    tabs: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Tab(
                          child: Container(
                            child: Image(
                              image: AssetImage('lib/assets/icons/tv.png'),
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Tab(
                          child: Container(
                            child: Image(
                              image: AssetImage('lib/assets/icons/videos.png'),
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Tab(
                          child: Container(
                            child: Image(
                              image: AssetImage('lib/assets/icons/news.png'),
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Tab(
                          child: Container(
                            child: Image(
                              image: AssetImage('lib/assets/icons/pro.png'),
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Tab(
                          child: Container(
                            child: Image(
                              image: AssetImage('lib/assets/icons/profile.png'),
                              width: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )) ,
        body: TabBarView(
          children: <Widget>[
            LiveTV(),
            HomeTopTabs(),
            HomeTopTabs(),
            HomeTopTabs(),
            HomeTopTabs()
          ],
        ),
      ) : NoInternetConnection(),
    );
  }
}
