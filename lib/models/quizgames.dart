class quiz {
  final String image;
  final String name;
  String option = "";

  quiz({
    required this.image,
    required this.name,
  });

  factory quiz.fromJson(Map<String, dynamic> json) {
    return quiz(
      image:  json["image"],
      name:  json["name"],

    );
  }
}