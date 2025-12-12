class Post {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final String authorName;
  final String authorAvatar;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.authorName,
    required this.authorAvatar,
    required this.createdAt,
  });
}
