class Trip {
  final int id;
  final String startStation;
  final String endStation;
  final DateTime startTime;
  final DateTime endTime;
  final String type;
  final double? co2Saved;
  final double? creditsEarned;
  final double? distanceCovered;
  final bool inProgress;

  Trip({
    required this.id,
    required this.startStation,
    required this.endStation,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.inProgress,
    this.co2Saved = 0,
    this.creditsEarned = 0,
    this.distanceCovered = 0,
  });

  static Trip fromJson(Map<dynamic, dynamic> json) {
    return Trip(
      id: json['id'],
      startStation: json['start_stop'],
      endStation: json['end_stop'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      type: json['type'],
      co2Saved: json['emission_saved']?.toDouble(),
      creditsEarned: json['credits']?.toDouble(),
      distanceCovered: json['distance']?.toDouble(),
      inProgress: json['in_progress'],
    );
  }
}
