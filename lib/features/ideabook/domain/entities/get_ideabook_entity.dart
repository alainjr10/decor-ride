import 'package:decor_ride/features/ideabook/data/models/idea_model.dart';

class GetIdeabookEntity {
  final String ideabookName;
  final String ideabookDescription;
  final bool ideabookPrivate;
  final String ideabookId;
  final List<IdeaModel>? ideas;

  GetIdeabookEntity({
    required this.ideabookName,
    required this.ideabookDescription,
    required this.ideabookPrivate,
    required this.ideabookId,
    this.ideas,
  });

  // from firestore and to firestore methods
  factory GetIdeabookEntity.fromMap(Map<String, dynamic> map) {
    return GetIdeabookEntity(
      ideabookName: map['ideabookName'],
      ideabookDescription: map['ideabookDescription'],
      ideabookPrivate: map['ideabookPrivate'],
      ideabookId: map['ideabookId'],
      ideas: map['ideas'] != null
          ? List<IdeaModel>.from(map['ideas'].map((x) => IdeaModel.fromMap(x)))
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ideabookName': ideabookName,
      'ideabookDescription': ideabookDescription,
      'ideabookPrivate': ideabookPrivate,
      'ideabookId': ideabookId,
      'ideas':
          ideas != null ? List<dynamic>.from(ideas!.map((x) => x.toMap())) : [],
    };
  }
}
