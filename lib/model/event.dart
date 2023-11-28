class Event {
  final String name;
  final int distance;
  final String promoter;
  final int nbParticipants;
  final int maxParticipants;

  Event(this.distance, this.promoter, this.nbParticipants, this.maxParticipants,
      {required this.name});
}
