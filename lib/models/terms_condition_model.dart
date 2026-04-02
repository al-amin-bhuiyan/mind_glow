/// Model class representing a Terms & Conditions section
class TermsConditionSection {
  /// Section number
  final String number;

  /// Section title
  final String title;

  /// Section content (can be plain text or rich text)
  final String content;

  /// Optional bullet points
  final List<String>? bulletPoints;

  /// Additional content after bullet points
  final String? additionalContent;

  /// Section type (heading, paragraph, list, etc.)
  final TermsSectionType type;

  const TermsConditionSection({
    required this.number,
    required this.title,
    required this.content,
    this.bulletPoints,
    this.additionalContent,
    this.type = TermsSectionType.paragraph,
  });

  /// Create from JSON
  factory TermsConditionSection.fromJson(Map<String, dynamic> json) {
    return TermsConditionSection(
      number: json['number'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      bulletPoints: json['bulletPoints'] != null
          ? List<String>.from(json['bulletPoints'])
          : null,
      additionalContent: json['additionalContent'] as String?,
      type: TermsSectionType.values.firstWhere(
            (e) => e.toString() == 'TermsSectionType.${json['type']}',
        orElse: () => TermsSectionType.paragraph,
      ),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'title': title,
      'content': content,
      'bulletPoints': bulletPoints,
      'additionalContent': additionalContent,
      'type': type.toString().split('.').last,
    };
  }
}

/// Section type enum
enum TermsSectionType {
  heading,
  paragraph,
  bulletList,
  mixed,
}
