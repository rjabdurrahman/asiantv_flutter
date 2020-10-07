import 'package:flutter/material.dart';
import 'package:tv_app/pages/category-video-list.dart';
import '../constants/colors.dart' as ColorConstants;

class HomeTopTabs extends StatefulWidget {
  Color colorVal;

  @override
  _HomeTopTabsState createState() => _HomeTopTabsState();
}

class _HomeTopTabsState extends State<HomeTopTabs>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 6, vsync: this);
    _tabController.addListener(_handleTabSelection);
    widget.colorVal = ColorConstants.PRIMARY_COLOR;
  }

  void _handleTabSelection() {
    // TODO: implement handletabselection
    setState(() {
      widget.colorVal = ColorConstants.PRIMARY_COLOR;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.DEFAULT_WHITE_COLOR,
          elevation: 0.0,
          title: Padding(
            padding: EdgeInsets.all(0.0),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: ColorConstants.PRIMARY_COLOR,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "Natok",
                    style: TextStyle(
                        color: _tabController.index == 0
                            ? widget.colorVal
                            : Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    "Movie",
                    style: TextStyle(
                        color: _tabController.index == 1
                            ? widget.colorVal
                            : Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    "Music",
                    style: TextStyle(
                        color: _tabController.index == 2
                            ? widget.colorVal
                            : Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    "Talkshow",
                    style: TextStyle(
                        color: _tabController.index == 3
                            ? widget.colorVal
                            : Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    "News",
                    style: TextStyle(
                        color: _tabController.index == 4
                            ? widget.colorVal
                            : Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    "News",
                    style: TextStyle(
                        color: _tabController.index == 5
                            ? widget.colorVal
                            : Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(
              height: 200.0,
              child: CategoryVideoList(categoryName: 'natok'),
            ),
            Container(
              height: 200.0,
              child: Center(child: CategoryVideoList(categoryName: 'natok')),
            ),
            Container(
              height: 200.0,
              child: Center(child: CategoryVideoList(categoryName: 'natok')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Editor Choice')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Editor Choice')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Editor Choice')),
            ),
          ],
        ),
      ),
    );
  }
}
