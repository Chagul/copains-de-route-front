import 'package:copains_de_route/model/create_evenement.dart';
import 'package:copains_de_route/model/create_user_dto.dart';
import 'package:copains_de_route/model/edit_event_dto.dart';
import 'package:copains_de_route/model/filter_evenement.dart';
import 'package:copains_de_route/model/gps_coordinates_dto.dart';
import 'package:copains_de_route/model/login_dto.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CopainsDeRouteApi {
  static const baseUrl = "https://app-o5ei237sga-ew.a.run.app";
  final _dio = Dio(BaseOptions(
      baseUrl: baseUrl, headers: {"Content-Type": Headers.jsonContentType}));

  String _getAuthorization(String? token) {
    return 'Bearer $token';
  }

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }

  Future<Response> verifyToken() async {
    String? token = await _getToken();
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
      var resp = await _dio.post("/auth/login", data: loginDTO,
          options: Options(validateStatus: (status) {
        return status == 400 || status == 200;
      }));
      // save token
      if (resp.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", resp.data["token"]);
      }
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> postItinerary(CreateEvenement evenement) async {
    String? token = await _getToken();
    try {
      var resp = await _dio.post("/events",
          data: evenement,
          options:
              Options(headers: {'Authorization': _getAuthorization(token)}));
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> getEvents() async {
    String? token = await _getToken();
    try {
      var response = await _dio.get("/events",
          options:
              Options(headers: {'Authorization': _getAuthorization(token)}));
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> getMyEvents() async {
    String? token = await _getToken();
    try {
      var response = await _dio.get("/events/createdEvents",
          options:
              Options(headers: {'Authorization': _getAuthorization(token)}));
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> getEventsParticipated() async {
    String? token = await _getToken();
    try {
      var response = await _dio.get("/events/participatedEvents",
          options:
              Options(headers: {'Authorization': _getAuthorization(token)}));
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> participateToEvent(int idEvent) async {
    String? token = await _getToken();
    try {
      var resp = await _dio.post("/events/participate/$idEvent",
          options:
              Options(headers: {'Authorization': _getAuthorization(token)}));
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> unsubscribeToEvent(int idEvent) async {
    String? token = await _getToken();
    try {
      var resp = await _dio.post("/events/discard/$idEvent",
          options:
              Options(headers: {'Authorization': _getAuthorization(token)}));
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> editEvent(EditEvenementDto editEvent, int idEvent) async {
    String? token = await _getToken();
    try {
      var resp = await _dio.patch("/events/$idEvent",
          data: editEvent,
          options:
              Options(headers: {'Authorization': _getAuthorization(token)}));
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> deleteEvent(int idEvent) async {
    String? token = await _getToken();
    try {
      var resp = await _dio.delete("/events/$idEvent",
          options:
              Options(headers: {'Authorization': _getAuthorization(token)}));
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> getUser() async {
    String? token = await _getToken();
    try {
      var response = await _dio.get("/users/me",
          options:
              Options(headers: {'Authorization': _getAuthorization(token)}));
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> updateUser(String newLogin) async {
    try {
      String? token = await _getToken();
      var resp = await _dio.patch(
        "/users/me",
        queryParameters: {'login': newLogin},
        options: Options(headers: {'Authorization': _getAuthorization(token)}),
      );
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> getEventsAround(GpsCoordinateDto gpsCoordinates) async {
    String? token = await _getToken();
    try {
      var resp = await _dio.post(
        "/events/location",
        data: gpsCoordinates,
        options: Options(headers: {'Authorization': _getAuthorization(token)}),
      );
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  getUserProfilePicUrl(String profilePicPath) {
    return baseUrl + profilePicPath;
  }

  Future<Response> filterEvent(FilterEvenement filterEvenement) async {
    String? token = await _getToken();
    try {
      var resp = await _dio.post(
        "/events/eventsByFilter",
        data: filterEvenement,
        options: Options(headers: {'Authorization': _getAuthorization(token)}),
      );
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }
}
