import 'package:api/widgets/tabview.dart';
import 'package:api/models/datamodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_pixels/image_pixels.dart';

class NewsInfoScreen extends StatelessWidget {
  final datamodel News;
  NewsInfoScreen({super.key, required this.News});
  _launchURL() async {
    Uri _url = Uri.parse('https://www.google.com');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                )),
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            stretch: true,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * .35,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              stretchModes: [StretchMode.blurBackground],
              background: CachedNetworkImage(
                errorWidget: (context, url, error) => Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Center(
                    child: LottieBuilder.asset(
                      frameRate: FrameRate.max,
                      "lib/Assets/pngicons/imageplaceholder.json",
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                imageUrl: News.urlToImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: 10,
          //   ),
          // ),

          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            toolbarHeight: 15,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(216, 180, 248, 100),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(6),
                      child: Text(
                        News.author == "null"
                            ? "Not Avilable"
                            : News.author.characters.take(10).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.height * .023),
                      ),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(216, 180, 248, 100),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(6),
                      child: Row(
                        children: [
                          Icon(Icons.timer),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            News.publishedAt == "null"
                                ? "Not Available"
                                : formatterForTime
                                    .format(DateTime.parse(News.publishedAt)),
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * .018,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(216, 180, 248, 100),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(6),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month_rounded),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            News.publishedAt == "null"
                                ? "Not Available"
                                : formatterForDate
                                    .format(DateTime.parse(News.publishedAt)),
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * .017,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child:
          // ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 25,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                News.title == "null" ? "No Info Available" : News.title,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                News.description == "null"
                    ? "No Info Available"
                    : News.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                News.content == "null" ? "No Info Available" : News.content,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: InkWell(
                onTap: () => launchUrl(Uri.parse(News.url),
                    mode: LaunchMode.externalApplication),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Click Here To See Full Info..!",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 21,
                      color: Color.fromRGBO(160, 51, 255, 0.612),
                    ),
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 500,
            ),
          ),
        ],
      ),
      // body: Stack(
      //   children: [
      //     Container(
      //       height: MediaQuery.of(context).size.height,
      //     ),
      //     Container(
      //       width: MediaQuery.of(context).size.width,
      //       height: MediaQuery.of(context).size.height * .4,
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //             fit: BoxFit.fill, image: NetworkImage(News.urlToImage)),
      //       ),
      //     ),
      //     Positioned(
      //       top: 30,
      //       left: 10,
      //       child: InkWell(
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //         child: Container(
      //           padding: EdgeInsets.all(6),
      //           height: 55,
      //           width: 55,
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(13),
      //               color: Color.fromRGBO(247, 239, 255, 0.612)),
      //           child: Icon(
      //             Icons.arrow_back_ios_rounded,
      //             size: 30,
      //           ),
      //         ),
      //       ),
      //     ),
      //     Positioned(
      //       bottom: 0,
      //       left: 0,
      //       child: Container(
      //         padding: EdgeInsets.only(top: 40, left: 15, right: 15),
      //         height: MediaQuery.of(context).size.height * .65,
      //         width: MediaQuery.of(context).size.width,
      //         decoration: BoxDecoration(
      //             color: Colors.white, borderRadius: BorderRadius.circular(30)),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Row(
      //               children: [
      //                 Container(
      //                   decoration: BoxDecoration(
      //                       color: Color.fromRGBO(216, 180, 248, 100),
      //                       borderRadius: BorderRadius.circular(10)),
      //                   padding: EdgeInsets.all(6),
      //                   child: Text(
      //                     News.author == "null"
      //                         ? "Not Avilable"
      //                         : News.author.characters.take(10).toString(),
      //                     style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         fontSize:
      //                             MediaQuery.of(context).size.height * .023),
      //                   ),
      //                 ),
      //                 Spacer(),
      //                 Container(
      //                   decoration: BoxDecoration(
      //                       color: Color.fromRGBO(216, 180, 248, 100),
      //                       borderRadius: BorderRadius.circular(10)),
      //                   padding: EdgeInsets.all(6),
      //                   child: Row(
      //                     children: [
      //                       Icon(Icons.timer),
      //                       SizedBox(
      //                         width: 5,
      //                       ),
      //                       Text(
      //                         News.publishedAt == "null"
      //                             ? "Not Available"
      //                             : formatterForTime
      //                                 .format(DateTime.parse(News.publishedAt)),
      //                         style: TextStyle(
      //                           fontSize:
      //                               MediaQuery.of(context).size.height * .018,
      //                           fontWeight: FontWeight.w500,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 Spacer(),
      //                 Container(
      //                   decoration: BoxDecoration(
      //                       color: Color.fromRGBO(216, 180, 248, 100),
      //                       borderRadius: BorderRadius.circular(10)),
      //                   padding: EdgeInsets.all(6),
      //                   child: Row(
      //                     children: [
      //                       Icon(Icons.calendar_month_rounded),
      //                       SizedBox(
      //                         width: 5,
      //                       ),
      //                       Text(
      //                         News.publishedAt == "null"
      //                             ? "Not Available"
      //                             : formatterForDate
      //                                 .format(DateTime.parse(News.publishedAt)),
      //                         style: TextStyle(
      //                           fontSize:
      //                               MediaQuery.of(context).size.height * .017,
      //                           fontWeight: FontWeight.w500,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             Text(
      //               News.title == "null" ? "No Info Available" : News.title,
      //               style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             Text(
      //               News.description == "null"
      //                   ? "No Info Available"
      //                   : News.description,
      //               style: TextStyle(fontSize: 16),
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             Text(
      //               News.content == "null" ? "No Info Available" : News.content,
      //               style: TextStyle(fontSize: 16),
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             InkWell(
      //                 onTap: () => launchUrl(Uri.parse(News.url),
      //                     mode: LaunchMode.externalApplication),
      //                 child: Text(
      //                   "Click Here To See Full Info..!",
      //                   style: TextStyle(
      //                     fontWeight: FontWeight.w600,
      //                     fontSize: 21,
      //                     color: Color.fromRGBO(160, 51, 255, 0.612),
      //                   ),
      //                 )),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
