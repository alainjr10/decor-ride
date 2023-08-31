import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/ideabook/domain/entities/my_ideas_listtile_entity.dart';

abstract class GeneralIdeasDataSource {
  Future<Either<List<MyIdeasListtileEntity>, String>> getMyIdeasListtileItems();
}
