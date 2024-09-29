import 'package:animated_custom_dropdown/custom_dropdown.dart';

class Station with CustomDropdownListFilter {
  final String name;
  final String type;
  final String id;

  Station({required this.id, required this.type, required this.name});

  static Station fromJson(Map<dynamic, dynamic> json) {
    return Station(id: json['id'], name: json['name'], type: json['type']);
  }

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}
