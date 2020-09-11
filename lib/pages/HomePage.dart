import 'package:flutter/material.dart';
import 'package:tv_app/pages/livetv.dart';
import '../widgets/hometoptabs.dart';
import '../constants/colors.dart' as ColorConstants;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAppbarActive = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: isAppbarActive
            ? AppBar(
                backgroundColor: ColorConstants.DEFAULT_MENU_COLOR,
                title: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: TabBar(
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
                ))
            : null,
        body: TabBarView(
          children: <Widget>[
            LiveTV(),
            HomeTopTabs(),
            HomeTopTabs(),
            HomeTopTabs(),
            HomeTopTabs()
          ],
        ),
      ),
    );
  }
}
