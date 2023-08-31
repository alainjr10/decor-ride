import 'package:decor_ride/features/ideabook/data/data_sources/ideabook_firestore.dart';
import 'package:decor_ride/features/ideabook/data/data_sources/ideabook_firestore_impl.dart';
import 'package:decor_ride/features/ideabook/domain/entities/create_ideabook_entity.dart';
import 'package:decor_ride/features/ideabook/presentation/states/create_ideabook_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final createIdeabookNotifierProvider = StateNotifierProvider.autoDispose<
    CreateIdeabooksNotifier, CreateIdeabookState>((ref) {
  final ideabookFirestore = ref.watch(ideabooksFirestoreProvider);
  return CreateIdeabooksNotifier(ideabookFirestore);
});

class CreateIdeabooksNotifier extends StateNotifier<CreateIdeabookState> {
  final IdeabookFirestore _ideabookFirestore;
  CreateIdeabooksNotifier(this._ideabookFirestore)
      : super(const CreateIdeabookState.initial());

  Future<void> createIdeabook(CreateIdeabookEntity createIdeabookEntity) async {
    state = const CreateIdeabookState.loading();
    final response =
        await _ideabookFirestore.createIdeabook(createIdeabookEntity);
    response.fold(
      (ideabook) => state = const CreateIdeabookState.success(),
      (error) => state = CreateIdeabookState.error(error),
    );
  }
}
