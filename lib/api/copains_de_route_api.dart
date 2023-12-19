import 'dart:convert';

import 'package:copains_de_route/model/create_evenement.dart';
import 'package:copains_de_route/model/create_user_dto.dart';
import 'package:copains_de_route/model/login_dto.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CopainsDeRouteApi {
  static const baseUrl = "http://localhost:8080";
  final _dio = Dio(BaseOptions(
      baseUrl: baseUrl, headers: {"Content-Type": Headers.jsonContentType}));

  String _getAuthorization(String? token) {
    return 'Bearer $token';
  }

  Future<Response> verifyToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    try {
      var resp = await _dio
          .post("/auth/verifyToken", queryParameters: {"token": "$token"},
              options: Options(validateStatus: (status) {
        return status == 400 || status == 200;
      }));
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> register(CreateUserDTO createUser) async {
    try {
      var resp = await _dio.post("/auth/register", data: createUser);
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> login(LoginDTO loginDTO) async {
    try {
      var resp = await _dio.post("/auth/login", data: loginDTO);
      // save token
      var json = jsonDecode(resp.data);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", json["token"]);
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> postItinerary(CreateEvenement evenement) async {
    try {
      var resp = await _dio.post("/events", data: evenement);
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> getEvents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    try {
      var response = await _dio.get("/events",
          options:
              Options(headers: {'Authorization': _getAuthorization(token)}));
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> participateToEvent(int idEvent, String login) async {
    try {
      var resp = await _dio.post("/events/participate/$idEvent/$login");
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> unsubscribeToEvent(int idEvent, String login) async {
    try {
      var resp = await _dio.post("/events/participate/$idEvent/$login");
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }
}
