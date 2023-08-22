import 'package:decor_ride/features/ideabook/data/models/ideabook_model.dart';

abstract class IdeabookFirestore {
  Future<List<IdeabookModel>> getAllIdeabooks();
}
