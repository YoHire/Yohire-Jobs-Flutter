
import 'package:hive_flutter/hive_flutter.dart';
part 'country_model.g.dart';

@HiveType(typeId: 7)
class CountryModel {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  CountryModel({required this.id, required this.name});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<String> toIdStringList(List<CountryModel> data) {
    return data.map((e) {
      return e.id;
    }).toList();
  }

  static List<String> toNameList(List<CountryModel> data) {
    return data.map((e) {
      return e.name;
    }).toList();
  }
}
