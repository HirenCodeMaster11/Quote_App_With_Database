class QuoteModal {
  final String category;
  final String quote;
  final String author;
  String isLiked;

  QuoteModal({
    required this.category,
    required this.quote,
    required this.author,
    required this.isLiked,
  });

  factory QuoteModal.fromJson(Map<String, dynamic> json) {
    return QuoteModal(
      category: json['category'],
      quote: json['quote'],
      author: json['author'],
      isLiked: json['isLiked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'quote': quote,
      'author': author,
      'isLiked': isLiked,
    };
  }
}