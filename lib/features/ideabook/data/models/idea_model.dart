class IdeaModel {
  final String? ideaName;
  final String? ideaImageUrl;

  IdeaModel({
    this.ideaName,
    this.ideaImageUrl,
  });

  IdeaModel copyWith({
    String? ideaName,
    String? ideaImageUrl,
  }) {
    return IdeaModel(
      ideaName: ideaName ?? this.ideaName,
      ideaImageUrl: ideaImageUrl ?? this.ideaImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ideaName': ideaName,
      'ideaImageUrl': ideaImageUrl,
    };
  }

  factory IdeaModel.fromMap(Map<String, dynamic> map) {
    return IdeaModel(
      ideaName: map['ideaName'],
      ideaImageUrl: map['ideaImageUrl'],
    );
  }
}
