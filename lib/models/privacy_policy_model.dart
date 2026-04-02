/// Model class representing a Privacy Policy section
class PrivacyPolicySection {
  /// Section number
  final String number;

  /// Section title
  final String title;

  /// Section content (can be plain text or rich text)
  final String content;

  /// Optional bullet points
  final List<BulletPoint>? bulletPoints;

  /// Section type (heading, paragraph, list, etc.)
  final SectionType type;

  const PrivacyPolicySection({
    required this.number,
    required this.title,
    required this.content,
    this.bulletPoints,
    this.type = SectionType.paragraph,
  });

  /// Create from JSON
  factory PrivacyPolicySection.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicySection(
      number: json['number'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      bulletPoints: json['bulletPoints'] != null
          ? (json['bulletPoints'] as List)
          .map((item) => BulletPoint.fromJson(item))
          .toList()
          : null,
      type: SectionType.values.firstWhere(
            (e) => e.toString() == 'SectionType.${json['type']}',
        orElse: () => SectionType.paragraph,
      ),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'title': title,
      'content': content,
      'bulletPoints': bulletPoints?.map((item) => item.toJson()).toList(),
      'type': type.toString().split('.').last,
    };
  }
}

/// Bullet point model
class BulletPoint {
  /// Bullet point label (e.g., "Account Information:")
  final String label;

  /// Bullet point description
  final String description;

  /// Whether the label is bold
  final bool isBold;

  const BulletPoint({
    required this.label,
    required this.description,
    this.isBold = true,
  });

  /// Create from JSON
  factory BulletPoint.fromJson(Map<String, dynamic> json) {
    return BulletPoint(
      label: json['label'] as String,
      description: json['description'] as String,
      isBold: json['isBold'] as bool? ?? true,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'description': description,
      'isBold': isBold,
    };
  }
}

/// Section type enum
enum SectionType {
  heading,
  paragraph,
  bulletList,
  richText,
}
