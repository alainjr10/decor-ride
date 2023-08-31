import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/ideabook/data/data_sources/general_ideas_datasource.dart';
import 'package:decor_ride/features/ideabook/domain/entities/my_ideas_listtile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final generalIdeasDataSourceProvider =
    Provider.autoDispose<GeneralIdeasDataSource>(
        (ref) => GeneralIdeasDataSourceImpl());

final getMyIdeasListtileItemsProvider = FutureProvider.autoDispose(
  (ref) {
    final generalIdeasDataSource = ref.watch(generalIdeasDataSourceProvider);
    return generalIdeasDataSource.getMyIdeasListtileItems();
  },
);

class GeneralIdeasDataSourceImpl implements GeneralIdeasDataSource {
  @override
  Future<Either<List<MyIdeasListtileEntity>, String>>
      getMyIdeasListtileItems() async {
    try {
      await Future.delayed(const Duration(milliseconds: 2500));
      return left(myIdeasListItems);
    } catch (e) {
      return right("Sorry, something went wront");
    }
  }

  List<MyIdeasListtileEntity> myIdeasListItems = [
    MyIdeasListtileEntity(
      name: "Photos",
      route: "",
      avatarImageUrl: "assets/my_ideas_listtile_assets/photos.png",
    ),
    MyIdeasListtileEntity(
      name: "Products",
      route: "",
      avatarImageUrl: "assets/my_ideas_listtile_assets/products.png",
    ),
    MyIdeasListtileEntity(
      name: "Pros",
      route: "s",
      avatarImageUrl: "assets/my_ideas_listtile_assets/pros.png",
    ),
    MyIdeasListtileEntity(
      name: "Stories",
      route: "",
      avatarImageUrl: "assets/my_ideas_listtile_assets/stories.png",
    ),
    MyIdeasListtileEntity(
      name: "Discussions",
      route: "",
      avatarImageUrl: "assets/my_ideas_listtile_assets/discussions.png",
    ),
  ];
}
