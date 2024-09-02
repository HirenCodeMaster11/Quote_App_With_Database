class QuoteModal {
  int? id;
  final String category;
  final String quote;
  final String author;
  String isLiked;

  QuoteModal({
    this.id,
    required this.category,
    required this.quote,
    required this.author,
    required this.isLiked,
  });

  factory QuoteModal.fromJson(Map<String, dynamic> json) {
    return QuoteModal(
      id: json['id'] as int?,
      category: json['category'],
      quote: json['quote'],
      author: json['author'] ?? 'Unkown',
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