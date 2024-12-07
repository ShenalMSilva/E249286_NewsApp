class NewsArticle {
  final String? id;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String? publishedAt;
  final String? category;

  NewsArticle({
    this.id,
    this.author,
    this.category,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['source']['id']?? 'Unknown',
      author: json['author'] ?? 'Unknown',
      category: json['category']??'Unknown',
      title: json['title']?? '' ,
      description: json['description'] ?? 'Unknown',
      url: json['url'] ?? 'Unknown',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? 'Unknown',
    );
  }
}