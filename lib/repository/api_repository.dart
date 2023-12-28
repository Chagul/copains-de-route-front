import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/model/create_evenement.dart';

class CopainsDeRouteRepository {
  final CopainsDeRouteApi api;

  CopainsDeRouteRepository({required this.api});

  Future<void> postEvenement({required CreateEvenement evenement}) {
    return api.postItinerary(evenement);

  }

  Future<void> getUser() {
    return api.getUser();
  }
}
