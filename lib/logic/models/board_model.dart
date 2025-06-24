class BoardModel {
  final int? boardId;
  final String name;
  final String description;
  final String userId;
  final String color;

  BoardModel({
    this.boardId,
    required this.name,
    required this.description,
    required this.userId,
    required this.color,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      boardId: json['board_id'] as int?,
      name: json['name'],
      description: json['description'],
      userId: json['user_id'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'user_id': userId,
      'color': color,
    };
  }
}
