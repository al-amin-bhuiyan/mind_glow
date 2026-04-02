/// Model class representing a Frequently Asked Question
class FaqModel {
  /// The question text
  final String question;

  /// The answer text
  final String answer;

  /// Whether this FAQ item is expanded
  final bool isExpanded;

  /// Constructor
  const FaqModel({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  /// Copy with method for state updates
  FaqModel copyWith({
    String? question,
    String? answer,
    bool? isExpanded,
  }) {
    return FaqModel(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  /// Create from JSON
  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      question: json['question'] as String,
      answer: json['answer'] as String,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'isExpanded': isExpanded,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FaqModel &&
              runtimeType == other.runtimeType &&
              question == other.question &&
              answer == other.answer &&
              isExpanded == other.isExpanded;

  @override
  int get hashCode => question.hashCode ^ answer.hashCode ^ isExpanded.hashCode;

  @override
  String toString() =>
      'FaqModel(question: $question, answer: $answer, isExpanded: $isExpanded)';
}
