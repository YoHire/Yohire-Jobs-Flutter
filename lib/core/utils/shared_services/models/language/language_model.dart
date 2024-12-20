
import 'package:hive_flutter/hive_flutter.dart';
part 'language_model.g.dart';

@HiveType(typeId: 6)
class LanguageModel {

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  LanguageModel({
    required this.id,
    required this.name,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }
  static String fromNameJson(Map<String, dynamic> json) {
    return json['name'] ?? '';
  }

  String toStringList() {
    return name;
  }
      static String getId(LanguageModel data) {
    return data.id;
  }

}
