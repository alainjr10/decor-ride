import 'package:decor_ride/features/ideabook/data/models/idea_model.dart';

class IdeabookModel {
  final String ideabookName;
  final String ideabookDescription;
  final bool ideabookPrivate;
  final List<IdeaModel>? ideas;

  IdeabookModel({
    required this.ideabookName,
    required this.ideabookDescription,
    required this.ideabookPrivate,
    List<IdeaModel>? ideas,
  }) : ideas = ideas ?? [];
}
