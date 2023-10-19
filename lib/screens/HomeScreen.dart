import 'package:api/widgets/tabview.dart';
import 'package:api/widgets/BreakingNews.dart';
import 'package:api/screens/Search.dart';
import 'package:api/models/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class HomeScreen extends StatefulWidget {
  final List<List<datamodel>> news;
  HomeScreen({super.key, required this.news});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Color.fromRGBO(216, 180, 248, 100)),
                      child: Image.asset(
                        'lib/Assets/pngicons/menu.png',
                        color: Color.fromRGBO(175, 83, 255, 0.612),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Search();
                        },
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Color.fromRGBO(216, 180, 248, 100)),
                      child: SvgPicture.asset(
                        'lib/Assets/pngicons/IOS_search.svg',
                        color: Color.fromRGBO(165, 69, 249, 0.612),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Text(
                "Breaking News",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: BreakingNews(news: widget.news[0]),
          ),
          SliverAppBar(
              expandedHeight: 0,
              toolbarHeight: MediaQuery.of(context).size.height * .025,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: DefaultTabController(
                  length: 7,
                  child: TabBar(
                      controller: _tabController,
                      indicatorWeight: 3,
                      overlayColor: MaterialStatePropertyAll(
                          Color.fromRGBO(216, 180, 248, 100)),
                      indicatorColor: Color.fromRGBO(175, 83, 255, 0.612),
                      isScrollable: true,
                      labelColor: Color.fromRGBO(175, 83, 255, 0.612),
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Text(
                          "Technology",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text("Entertainment",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        Text("General",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        Text("Science",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        Text("Sports",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        Text("Business",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        Text("Health",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ]),
                ),
              )),
        ];
      },
      body: TabBarView(controller: _tabController, children: [
        tabView(news: widget.news[7]),
        tabView(news: widget.news[2]),
        tabView(news: widget.news[3]),
        tabView(news: widget.news[5]),
        tabView(news: widget.news[6]),
        tabView(news: widget.news[1]),
        tabView(news: widget.news[4]),
      ]),
    );
  }
}
