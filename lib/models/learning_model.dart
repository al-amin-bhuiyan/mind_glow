class LearningModel {
  final String id;
  final String date;
  final String title;
  final String description;

  LearningModel({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
  });

  factory LearningModel.fromJson(Map<String, dynamic> json) {
    return LearningModel(
      id: json['id'] ?? '',
      date: json['date'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'description': description,
    };
  }
}
