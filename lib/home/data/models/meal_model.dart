class MealModel {
  final String title;
  final String desc;

  MealModel({
    required this.title,
    required this.desc,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      title: json['title'],
      desc: json['desc'],
    );
  }
}