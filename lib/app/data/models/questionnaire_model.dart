class QuestionnaireModel {
  final String? id;
  final String? createdAt;
  final String? title;
  final String? description;

  QuestionnaireModel({
    this.id,
    this.createdAt,
    this.title,
    this.description,
  });

  factory QuestionnaireModel.fromJson(Map<String, dynamic> json) {
    return QuestionnaireModel(
      id: json['id'],
      createdAt: json['createdAt'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
