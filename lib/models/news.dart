class News {
  final String? id;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String? author;
  final String publishedAt;
  final String content;

  News({
    this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    this.author,
    required this.publishedAt,
    required this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] ?? 'No data',
      title: json['title'] ?? 'No data',
      description: json['description'] ?? 'No data',
      url: json['url'] ?? 'No data',
      urlToImage: json['urlToImage'] ?? 'https://upload.wikimedia.org/wikipedia/commons/7/75/No_image_available.png',
      author: json['author'] ?? 'Unknown' ?? 'No data',
      publishedAt: json['publishedAt'] ?? 'No data',
      content: json['content'] ?? 'No data',
    );
  }
}