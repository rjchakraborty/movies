import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/app_config.dart';
import 'package:movies/module/base/provider/base_controller.dart';
import 'package:movies/module/top_movies/top_movies_page.dart';
import 'package:movies/utils/HexColor.dart';

class Base extends StatefulWidget {
  static const String routeName = "/base";

  int tabView = 0;

  Base({Key? key, this.tabView = 0}) : super(key: key);

  @override
  BaseState createState() => BaseState(tabView);
}

class BaseState extends State<Base> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int tabView = 0;

  BaseState(this.tabView);

  _handleTabSelection() {
    BaseController.to.selectedIndex.value = BaseController.to.tabController.index;
  }

  @override
  void initState() {
    super.initState();
    BaseController.to.tabController = TabController(vsync: this, length: 4, initialIndex: 0);
    BaseController.to.tabController.addListener(_handleTabSelection);
    BaseController.to.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Top Movies',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        backgroundColor: HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 26, 5),
            child: Image.asset(
              'assets/images/search_icon.png',
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() => TabBarView(controller: BaseController.to.tabController, children: [
              BaseController.to.genres.value != null &&
                      BaseController.to.genres.value!.genres != null &&
                      BaseController.to.genres.value!.genres!.isNotEmpty
                  ? const TopMoviesPage()
                  : Container(
                      color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                      child: Center(
                        child: Image.asset('assets/images/loading.gif'),
                      ),
                    ),
              Container(
                color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                child: Center(
                  child: Text('Coming Soon', style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
              Container(
                color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                child: Center(
                  child: Text('Coming Soon', style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
              Container(
                color: HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
                child: Center(
                  child: Text('Coming Soon', style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
            ])),
      ),
      bottomNavigationBar: Obx(() => Container(
            height: 56,
            color: HexColor.getColor('1B1C2A'),
            child: TabBar(
              controller: BaseController.to.tabController,
              physics: const BouncingScrollPhysics(),
              indicatorColor: Colors.transparent,
              indicatorWeight: 0.1,
              padding: const EdgeInsets.all(1),
              labelColor: Colors.white,
              labelStyle: Theme.of(context).textTheme.headline4,
              unselectedLabelColor: Colors.white.withOpacity(.8),
              unselectedLabelStyle: Theme.of(context).textTheme.headline5,
              tabs: [
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      'assets/images/home_icon.png',
                      color: (BaseController.to.selectedIndex.value == 0) ? HexColor.getColor('1F8CFF') : HexColor.getColor('CDCED1'),
                      height: 20,
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      'assets/images/reward_icon.png',
                      color: (BaseController.to.selectedIndex.value == 1) ? HexColor.getColor('1F8CFF') : HexColor.getColor('CDCED1'),
                      height: 20,
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      'assets/images/film_icon.png',
                      color: (BaseController.to.selectedIndex.value == 2) ? HexColor.getColor('1F8CFF') : HexColor.getColor('CDCED1'),
                      height: 20,
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      'assets/images/graph_icon.png',
                      color: (BaseController.to.selectedIndex.value == 3) ? HexColor.getColor('1F8CFF') : HexColor.getColor('CDCED1'),
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
