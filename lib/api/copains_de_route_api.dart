import 'package:copains_de_route/model/create_evenement.dart';
import 'package:dio/dio.dart';

class CopainsDeRouteApi {
  static const baseUrl = "https://app-o5ei237sga-ew.a.run.app";
  final _dio = Dio(BaseOptions(
      baseUrl: baseUrl, headers: {"Content-Type": Headers.jsonContentType}));

  Future<Response> postItinerary(CreateEvenement evenement) async {
    try {
      var resp = await _dio.post("/events", data: evenement);
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> getEvents() async {
    try {
      var response = await _dio.get("/events");
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> participateToEvent(int idEvent) async {
    try {
      var resp = await _dio.post("/participate/$idEvent/login");
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }
}
