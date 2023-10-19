import 'package:api/screens/NewsInfoScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:api/models/datamodel.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animate_do/animate_do.dart';

final formatterForDate = DateFormat.yMd();
final formatterForTime = DateFormat('h:mm a');

class tabView extends StatelessWidget {
  final List<datamodel> news;
  tabView({super.key, required this.news});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(slivers: [
      SliverList(
          delegate: SliverChildBuilderDelegate(childCount: news.length,
              (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: NewsInfoScreen(News: news[index]),
                    type: PageTransitionType.rightToLeft));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            constraints: BoxConstraints(maxHeight: 130, minHeight: 100),
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
                CachedNetworkImage(
                  imageUrl: "${news[index].urlToImage}",
                  imageBuilder: (context, imageProvider) => Container(
                    margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(news[index].urlToImage)),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    width: 100,
                    child: Center(
                      child: LottieBuilder.asset(
                          "lib/Assets/pngicons/latestloading.json"),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    width: 100,
                    child: Center(
                      child: LottieBuilder.asset(
                          "lib/Assets/pngicons/latestloading.json"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 0, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            news[index].title.characters.take(110).toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(216, 180, 248, 100),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                news[index].author == "null"
                                    ? "Not Avilable"
                                    : news[index]
                                        .author
                                        .characters
                                        .take(20)
                                        .toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  news[index].publishedAt == "null"
                                      ? "Not Available"
                                      : formatterForTime.format(DateTime.parse(
                                          news[index].publishedAt)),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(162, 56, 255, 0.612),
                                  ),
                                ),
                                Text(
                                  news[index].publishedAt == "null"
                                      ? "Not Available"
                                      : formatterForDate.format(DateTime.parse(
                                          news[index].publishedAt)),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(162, 56, 255, 0.612),
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
      })),
    ]);
  }
}
