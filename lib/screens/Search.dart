// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:api/widgets/tabview.dart';
import 'package:api/home.dart';
import 'package:api/screens/NewsInfoScreen.dart';
import 'package:api/models/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class Search extends StatefulWidget {
  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool processing = false;
  List<datamodel> gotdata = [];

  void getdata(String val) async {
    setState(() {
      processing = true;
    });
    final url = Uri.parse(
        'https://newsapi.org/v2/everything?q=${val}&apiKey=${Api_Key}');
    final Response = await http.get(url);
    if (Response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(Response.body);
      final List<dynamic> news = data["articles"];
      final list = news.map((e) => datamodel.fromJson(e)).toList();
      setState(() {
        gotdata = list;
      });
    } else {
      print(Response.statusCode);
    }
    setState(() {
      processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          Expanded(
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Search yor News"),
                onChanged: (value) => getdata(value),
              ),
            ),
          )
        ],
      ),
      body: processing
          ? Center(
              child: CircularProgressIndicator(),
            )
          : gotdata.isEmpty
              ? Center(
                  child: Text("No Results Found"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: gotdata.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: NewsInfoScreen(News: gotdata[index]),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        height: 120,
                        width: MediaQuery.of(context).size.width * .90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(162, 56, 255, 0.612),
                                  borderRadius: BorderRadius.circular(50)),
                              width: 7,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10),
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        gotdata[index].urlToImage)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 0, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      gotdata[index]
                                          .title
                                          .characters
                                          .take(110)
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  216, 180, 248, 100),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            gotdata[index].author == "null"
                                                ? "Not Avilable"
                                                : gotdata[index]
                                                    .author
                                                    .characters
                                                    .take(20)
                                                    .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            Text(
                                              gotdata[index].publishedAt ==
                                                      "null"
                                                  ? "Not Available"
                                                  : formatterForTime.format(
                                                      DateTime.parse(
                                                          gotdata[index]
                                                              .publishedAt)),
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(
                                                    162, 56, 255, 0.612),
                                              ),
                                            ),
                                            Text(
                                              gotdata[index].publishedAt ==
                                                      "null"
                                                  ? "Not Available"
                                                  : formatterForDate.format(
                                                      DateTime.parse(
                                                          gotdata[index]
                                                              .publishedAt)),
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(
                                                    162, 56, 255, 0.612),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
