class BlogModel {
  final String blogImage;
  final String previewImage;
  final String blogname;
  final String views;
  final String date;
  final String authorName;

  BlogModel({
    required this.blogname,
    required this.views,
    required this.date,
    required this.authorName,
    required this.blogImage,
    required this.previewImage,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        blogImage: json['blogImage'].toString(),
        previewImage :json['previewImage'].toString(),
        views: json['viewer'].toString(),
        date: json['postedOn'].toString(),
        authorName: json['author'].toString(),
        blogname: json['title'].toString(),
      );
}
