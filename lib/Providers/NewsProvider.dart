import 'dart:convert';

import 'package:api/models/datamodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class NewsNotifier extends StateNotifier<List<datamodel>> {
  NewsNotifier() : super(const []);

  Future<List<datamodel>> getData(Uri url) async {
    List<datamodel> news = [];

    // final url = Uri.parse(link);
    final response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> mappedData = data["articles"];
      news = mappedData.map((e) => datamodel.fromJson(e)).toList();
    }
    return news;

    // final url2 = Uri.parse(
    //     'https://newsapi.org/v2/top-headlines/sources?category=businessapiKey=${Api_Key}');
    // final url3 = Uri.parse(
    //     'https://newsapi.org/v2/top-headlines/sources?category=entertainmentapiKey=${Api_Key}');
    // final url4 = Uri.parse(
    //     'https://newsapi.org/v2/top-headlines/sources?category=generalapiKey=${Api_Key}');
    // final url5 = Uri.parse(
    //     'https://newsapi.org/v2/top-headlines/sources?category=healthapiKey=${Api_Key}');
    // final url6 = Uri.parse(
    //     'https://newsapi.org/v2/top-headlines/sources?category=scienceapiKey=${Api_Key}');
    // final url7 = Uri.parse(
    //     'https://newsapi.org/v2/top-headlines/sources?category=sportsapiKey=${Api_Key}');
    // final url8 = Uri.parse(
    //     'https://newsapi.org/v2/top-headlines/sources?category=technologyapiKey=${Api_Key}');

    // final headLineResponse = http.get(url1);
    // final buisnessResponse = http.get(url1);
    // final entertainmentResponse = http.get(url1);
    // final generalResponse = http.get(url1);
    // final headLineResponse = http.get(url1);
    // final headLineResponse = http.get(url1);
    // final headLineResponse = http.get(url1);
  }
}

final NewsProvider = StateNotifierProvider<NewsNotifier, List<datamodel>>(
    (ref) => NewsNotifier());
