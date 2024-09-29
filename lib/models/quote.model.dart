class Quote {
  final String quote;
  final String author;
  static const defaultQuote = Quote(
    quote:
        'Sustainability is no longer about doing less harm, it\'s about doing more good.',
    author: 'Jochen Jeitz',
  );

  const Quote({required this.quote, required this.author});

  static Quote fromJson(Map<String, dynamic> json) {
    return Quote(quote: json['quote']!, author: json['author']!);
  }
}
