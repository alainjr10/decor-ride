import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/ideabook/data/data_sources/ideabook_firestore.dart';
import 'package:decor_ride/features/ideabook/data/data_sources/ideabook_firestore_impl.dart';
import 'package:decor_ride/features/ideabook/domain/entities/get_ideabook_entity.dart';
import 'package:decor_ride/features/ideabook/presentation/states/get_ideabook_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getIdeabooksNotifierProvider =
    StateNotifierProvider.autoDispose<GetIdeabooksNotifier, GetIdeabooksState>(
        (ref) {
  final ideabookFirestore = ref.watch(ideabooksFirestoreProvider);
  return GetIdeabooksNotifier(ideabookFirestore);
});

final getAllIdeabooksProvider =
    FutureProvider.autoDispose<Either<List<GetIdeabookEntity>, String>>(
        (ref) async {
  final getIdeabooksNotifier = ref.watch(getIdeabooksNotifierProvider.notifier);
  return getIdeabooksNotifier.getAllIdeabooks();
});

class GetIdeabooksNotifier extends StateNotifier<GetIdeabooksState> {
  final IdeabookFirestore _ideabookFirestore;
  GetIdeabooksNotifier(this._ideabookFirestore)
      : super(const GetIdeabooksState.initial());

  // Future<void> getAllIdeabooks() async {
  //   state = const GetIdeabooksState.loading();
  //   final response = await _ideabookFirestore.getAllIdeabooks();
  //   response.fold(
  //     (ideabooks) => state = GetIdeabooksState.loaded(ideabooks),
  //     (error) => state = GetIdeabooksState.error(error),
  //   );
  // }
  Future<Either<List<GetIdeabookEntity>, String>> getAllIdeabooks() async {
    // state = const GetIdeabooksState.loading();
    final response = await _ideabookFirestore.getAllIdeabooks();
    return response;
  }
}
