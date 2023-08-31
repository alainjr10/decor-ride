import 'dart:convert';

class CreateIdeabookEntity {
  final String ideabookName;
  final String ideabookDescription;
  final String ideabookId;
  final bool ideabookPrivate;

  CreateIdeabookEntity({
    required this.ideabookName,
    required this.ideabookDescription,
    required this.ideabookPrivate,
    required this.ideabookId,
  });

  Map<String, dynamic> toMap() {
    return {
      'ideabookName': ideabookName,
      'ideabookDescription': ideabookDescription,
      'ideabookPrivate': ideabookPrivate,
      'ideabookId': ideabookId,
    };
  }

  factory CreateIdeabookEntity.fromMap(Map<String, dynamic> map) {
    return CreateIdeabookEntity(
      ideabookName: map['ideabookName'],
      ideabookDescription: map['ideabookDescription'],
      ideabookPrivate: map['ideabookPrivate'],
      ideabookId: map['ideabookId'],
    );
  }

  // to json and from json
  factory CreateIdeabookEntity.fromJson(String source) =>
      CreateIdeabookEntity.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CreateIdeabookEntity(ideabookName: $ideabookName, ideabookDescription: $ideabookDescription, ideabookPrivate: $ideabookPrivate, ideabookId: $ideabookId)';
  }

  // copywith
  CreateIdeabookEntity copyWith({
    String? ideabookName,
    String? ideabookDescription,
    bool? ideabookPrivate,
    String? ideabookId,
  }) {
    return CreateIdeabookEntity(
      ideabookName: ideabookName ?? this.ideabookName,
      ideabookDescription: ideabookDescription ?? this.ideabookDescription,
      ideabookPrivate: ideabookPrivate ?? this.ideabookPrivate,
      ideabookId: ideabookId ?? this.ideabookId,
    );
  }
}
