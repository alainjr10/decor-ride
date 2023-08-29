import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_ideabook_state.freezed.dart';

@freezed
class CreateIdeabookState with _$CreateIdeabookState {
  const factory CreateIdeabookState.initial() = _Initial;
  const factory CreateIdeabookState.loading() = _Loading;
  const factory CreateIdeabookState.success() = _Success;
  const factory CreateIdeabookState.error(String message) = _Error;
}
