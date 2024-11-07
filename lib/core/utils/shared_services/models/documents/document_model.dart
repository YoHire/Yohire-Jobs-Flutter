import 'package:hive_flutter/hive_flutter.dart';

part 'document_model.g.dart';

@HiveType(typeId: 7)
class DocumentModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String link;

  DocumentModel({
    required this.id,
    required this.name,
    required this.link,
  });

  // Factory method to create an instance of DocumentModel from a JSON map
  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      link: json['link'] as String,
    );
  }

  // Method to convert DocumentModel instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'link': link,
    };
  }
}
