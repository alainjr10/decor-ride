import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/ideabook/domain/entities/create_ideabook_entity.dart';
import 'package:decor_ride/features/ideabook/domain/entities/get_ideabook_entity.dart';

abstract class IdeabookFirestore {
  Future<Either<List<GetIdeabookEntity>, String>> getAllIdeabooks();
  Future<Either<GetIdeabookEntity, String>> createIdeabook(
      CreateIdeabookEntity ideabook);
}
