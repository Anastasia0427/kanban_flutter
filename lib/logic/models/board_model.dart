import 'package:flutter/widgets.dart';
import 'package:kanban_flutter/core/utils/utils.dart';

@immutable
class BoardModel {
  final int? boardId;
  final String name;
  final String description;
  final String userId;
  final String color;
  final DateTime creationDate;
  final DateTime editDate;

  const BoardModel({
    this.boardId,
    required this.name,
    required this.description,
    required this.userId,
    required this.color,
    required this.creationDate,
    required this.editDate,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      boardId: json['board_id'] as int?,
      name: json['name'],
      description: json['description'],
      userId: json['user_id'],
      color: json['color'],
      creationDate: DateTime.parse(json['creation_date']),
      editDate: DateTime.parse(json['edit_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'user_id': userId,
      'color': color,
      'creation_date': Utils.dateDBFormat.format(creationDate),
      'edit_date': Utils.dateDBFormat.format(editDate),
    };
  }
}
