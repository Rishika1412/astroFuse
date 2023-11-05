class AstroModel {
  final String astrologerName;
  final String astrologerImage;
  final int charge;

  AstroModel(
      {required this.astrologerName,
      required this.astrologerImage,
      required this.charge});

  factory AstroModel.fromJson(Map<String, dynamic> json) => AstroModel(
        astrologerImage: json['profileImage'].toString(),
        astrologerName: json['name'].toString(),
        charge: json['charge'],
      );
}
