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
}
