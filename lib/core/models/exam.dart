class ExamModel {
  String category, name;
  String? id;
  ExamModel({
    required this.category,
    required this.name,
    this.id,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
      category: json['category']!, name: json['name']!, id: json['_id']);

  Map<String, String> toJson() {
    return {
      'category': category,
      'name': name,
    };
  }
}
