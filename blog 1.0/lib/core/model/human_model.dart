import 'package:uuid/uuid.dart';

final uuid = Uuid();

class HumanModel {
  final String id;
  final String name;
  final String text;
  final String imagePath;

  HumanModel({
    uid,
    required this.text,
    required this.name,
    required this.imagePath,
  }) : id = uid ?? uuid.v4();
}
