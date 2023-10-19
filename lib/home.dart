import 'dart:convert';

import 'package:api/Providers/NewsProvider.dart';
import 'package:api/screens/HomeScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:api/models/datamodel.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
//523997bfe8644e95bda05f80aa58ffbc
//bae41a80f71c440eafbe3e0e090da45e

const Api_Key = "523997bfe8644e95bda05f80aa58ffbc";

class home extends ConsumerStatefulWidget {
  home({super.key});

  @override
  ConsumerState<home> createState() => _homeState();
}

class _homeState extends ConsumerState<home> {
  String selText = "in";
  late Future<List<List<datamodel>>> Futuredata;

  bool _loading = false;

  List<Map<String, String>> countryList = [
    {"code": "ae", "name": "United Arab Emirates"},
    {"code": "ar", "name": "Argentina"},
    {"code": "at", "name": "Austria"},
    {"code": "au", "name": "Australia"},
    {"code": "be", "name": "Belgium"},
    {"code": "bg", "name": "Bulgaria"},
    {"code": "br", "name": "Brazil"},
    {"code": "ca", "name": "Canada"},
    {"code": "ch", "name": "Switzerland"},
    {"code": "cn", "name": "China"},
    {"code": "co", "name": "Colombia"},
    {"code": "cu", "name": "Cuba"},
    {"code": "cz", "name": "Czech Republic"},
    {"code": "de", "name": "Germany"},
    {"code": "eg", "name": "Egypt"},
    {"code": "fr", "name": "France"},
    {"code": "gb", "name": "United Kingdom"},
    {"code": "gr", "name": "Greece"},
    {"code": "hk", "name": "Hong Kong"},
    {"code": "hu", "name": "Hungary"},
    {"code": "id", "name": "Indonesia"},
    {"code": "ie", "name": "Ireland"},
    {"code": "il", "name": "Israel"},
    {"code": "in", "name": "India"},
    {"code": "it", "name": "Italy"},
    {"code": "jp", "name": "Japan"},
    {"code": "kr", "name": "South Korea"},
    {"code": "lt", "name": "Lithuania"},
    {"code": "lv", "name": "Latvia"},
    {"code": "ma", "name": "Morocco"},
    {"code": "mx", "name": "Mexico"},
    {"code": "my", "name": "Malaysia"},
    {"code": "ng", "name": "Nigeria"},
    {"code": "nl", "name": "Netherlands"},
    {"code": "no", "name": "Norway"},
    {"code": "nz", "name": "New Zealand"},
    {"code": "ph", "name": "Philippines"},
    {"code": "pl", "name": "Poland"},
    {"code": "pt", "name": "Portugal"},
    {"code": "ro", "name": "Romania"},
    {"code": "rs", "name": "Serbia"},
    {"code": "ru", "name": "Russia"},
    {"code": "sa", "name": "Saudi Arabia"},
    {"code": "se", "name": "Sweden"},
    {"code": "sg", "name": "Singapore"},
    {"code": "si", "name": "Slovenia"},
    {"code": "sk", "name": "Slovakia"},
    {"code": "th", "name": "Thailand"},
    {"code": "tr", "name": "Turkey"},
    {"code": "tw", "name": "Taiwan"},
    {"code": "ua", "name": "Ukraine"},
    {"code": "us", "name": "United States"},
    {"code": "ve", "name": "Venezuela"},
    {"code": "za", "name": "South Africa"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    put();
    // getdata();
  }

  void put() async {
    Futuredata = getdata();
  }

  Future<List<List<datamodel>>> getdata() async {
    setState(() {
      _loading = true;
    });

    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$selText&apiKey=$Api_Key');
    final url2 = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$selText&category=business&apiKey=$Api_Key');
    final url3 = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$selText&category=entertainment&apiKey=$Api_Key');
    final url4 = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$selText&category=general&apiKey=$Api_Key');
    final url5 = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$selText&category=health&apiKey=$Api_Key');
    final url6 = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$selText&category=science&apiKey=$Api_Key');
    final url7 = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$selText&category=sports&apiKey=$Api_Key');
    final url8 = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$selText&category=technology&apiKey=$Api_Key');
    print("got into");
    final breakingNewsList = await ref.read(NewsProvider.notifier).getData(url);
    final businessNewsList =
        await ref.read(NewsProvider.notifier).getData(url2);
    final entertainmentNewsList =
        await ref.read(NewsProvider.notifier).getData(url3);
    final generalNewsList = await ref.read(NewsProvider.notifier).getData(url4);
    final healthNewsList = await ref.read(NewsProvider.notifier).getData(url5);
    final scienceNewsList = await ref.read(NewsProvider.notifier).getData(url6);
    final sportsNewsList = await ref.read(NewsProvider.notifier).getData(url7);
    final technologyNewsList =
        await ref.read(NewsProvider.notifier).getData(url8);
    print(technologyNewsList);
    setState(() {
      _loading = false;
    });
    return [
      breakingNewsList,
      businessNewsList,
      entertainmentNewsList,
      generalNewsList,
      healthNewsList,
      scienceNewsList,
      sportsNewsList,
      technologyNewsList
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          width: 300,
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20))),
          child: Column(
            children: [
              Container(
                color: Color.fromRGBO(216, 180, 248, 100),
                height: MediaQuery.of(context).size.height * .33,
                width: 300,
                child: LottieBuilder.asset(
                    "lib/Assets/pngicons/sidebarimg.json",
                    frameRate: FrameRate.max),
              ),
              Container(
                color: Color.fromRGBO(216, 180, 248, 100),
                height: 60,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          underline: SizedBox(),
                          hint: Text("Choose Your Country"),
                          value: selText,
                          items: countryList
                              .map((e) => DropdownMenuItem(
                                    child: Text(e["name"]!),
                                    value: e["code"],
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            if (value != selText) {
                              Navigator.pop(context);

                              selText = value!;
                              Futuredata = getdata();
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/Assets/pngicons/flutterlogo.png")),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/Assets/pngicons/newsapilogo.png")),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        // body: HomeScreen(news: list),
        // body: HomeScreen(news: list),
        body: FutureBuilder(
          future: Futuredata,
          builder: (context, snapshot) {
            if (!_loading) {
              if (snapshot.hasData) {
                return HomeScreen(
                  news: snapshot.data!,
                );
              }
              return Center(
                  child: LottieBuilder.asset(
                      "lib/Assets/pngicons/loadingnew.json"));
            } else {
              return Center(
                  child: LottieBuilder.asset(
                      "lib/Assets/pngicons/loadingnew.json"));
            }
          },
        ));
  }
}
