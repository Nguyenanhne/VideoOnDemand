import 'dart:convert';
import 'dart:developer';

import 'package:du_an_cntt/utils.dart';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';
const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPoint;

class ApiServices{
  Future<MovieModel> getUpcomingMovies() async{
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success response: ${response.body}");
      return MovieModel.fromJson(json.decode(response.body));
    }
    throw Exception("Failed to load films");
  }
  Future<MovieModel> getNowPlayingMovies() async{
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success response: ${response.body}");
      return MovieModel.fromJson(json.decode(response.body));
    }
    throw Exception("Failed to load films");
  }
}