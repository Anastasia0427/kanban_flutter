class ColumnModel {
  final int? columnId;
  final String columnName;
  final int boardId;
  final String color;
  final bool isEditable;

  ColumnModel({
    this.columnId,
    required this.columnName,
    required this.boardId,
    required this.color,
    required this.isEditable,
  });

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
