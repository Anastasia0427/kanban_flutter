import 'package:kanban_flutter/logic/models/task_model.dart';

class ColumnModel {
  final int? columnId;
  final String columnName;
  final int boardId;
  final String color;
  final bool isEditable;
  final List<TaskModel> tasks;

  ColumnModel({
    this.columnId,
    required this.columnName,
    required this.boardId,
    required this.color,
    required this.isEditable,
    this.tasks = const [],
  });

  ColumnModel copyWith({List<TaskModel>? tasks}) {
    return ColumnModel(
      columnId: columnId,
      columnName: columnName,
      boardId: boardId,
      color: color,
      isEditable: isEditable,
      tasks: tasks ?? this.tasks,
    );
  }

  factory ColumnModel.fromJson(Map<String, dynamic> json) {
    return ColumnModel(
      columnId: json['column_id'] as int?,
      columnName: json['column_name'],
      boardId: json['board_id'],
      color: json['color'],
      isEditable: json['is_editable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'column_name': columnName,
      'board_id': boardId,
      'color': color,
      'is_editable': isEditable,
    };
  }
}
