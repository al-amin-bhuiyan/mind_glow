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
    String formattedDate = '';
    if (json['created_at'] != null) {
      try {
        final parsedDate = DateTime.parse(json['created_at'].toString());
        final months = [
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December'
        ];
        formattedDate = '${months[parsedDate.month - 1]} ${parsedDate.day}';
      } catch (e) {
        formattedDate = '';
      }
    }

    return LearningModel(
      id: json['id']?.toString() ?? '',
      date: formattedDate,
      title: json['topic']?.toString() ?? '',
      description: json['content']?.toString() ?? '',
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