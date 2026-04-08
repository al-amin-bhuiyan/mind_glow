class QuoteResponseModel {
  final String quote;
  final String author;

  const QuoteResponseModel({
    required this.quote,
    required this.author,
  });

  factory QuoteResponseModel.fromJson(Map<String, dynamic> json) {
    return QuoteResponseModel(
      quote: json['quote']?.toString() ?? '',
      author: json['author']?.toString() ?? '',
    );
  }
}
