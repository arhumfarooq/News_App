import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/categories_news_model.dart';
import 'package:news_app/model/news_channels_headlines_model.dart';
import 'package:news_app/services/api_endpoints.dart';

class NewsRepositry {
  Future<NewsChannelsHeadlinesModel> fetchNewsChaneelHeadlinesApi(String channel) async {
    String url = ApiEndpoints.headlinesBySource(channel);
    
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception("Error fetching news.");
  }


 Future<CategoriesNewsModel> fetchcategoriesnewsapi(String category) async {
    String url = ApiEndpoints.headlinesByCategory(category);
    
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception("Error fetching news.");
  }



}
