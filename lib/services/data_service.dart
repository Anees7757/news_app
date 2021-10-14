// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_app/models/data_model.dart';

String? search;
String? language = 'en';

class DataService {
  final endPointUrl = "newsapi.org";
  final client = http.Client();

  Future<List<Article>> getArticle(int num) async {
    final queryParameters;
    String endpoint;
    String apiKey = '61f5a95919bf486fa7cb95066b72a0fc';
    if (num == 0) {
      queryParameters = {
        'language': language!,
        'sortBy': 'publishedAt',
        'apiKey': apiKey
      };
      endpoint = 'top-headlines';
    } else if (num == 1) {
      queryParameters = {
        'q': 'top',
        'sortBy': 'publishedAt',
        'language': language!,
        'apiKey': apiKey
      };
      endpoint = 'everything';
    } else if (num == 2) {
      queryParameters = {
        'q': 'headlines',
        'sortBy': 'publishedAt',
        'language': language!,
        'apiKey': apiKey
      };
      endpoint = 'everything';
    } else if (num == 3) {
      queryParameters = {
        'language': language!,
        'q': 'popular',
        'sortBy': 'publishedAt',
        'apiKey': apiKey
      };
      endpoint = 'everything';
    } else if (num == 4) {
      queryParameters = {
        'language': language!,
        'sortBy': 'publishedAt',
        'category': 'sports',
        'apiKey': apiKey
      };
      endpoint = 'top-headlines';
    } else {
      queryParameters = {
        'q': search,
        'sortBy': 'publishedAt',
        'language': language!,
        'apiKey': apiKey
      };
      endpoint = 'everything';
    }
    final uri = Uri.https(endPointUrl, '/v2/$endpoint', queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
  }
}
