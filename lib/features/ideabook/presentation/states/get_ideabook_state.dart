import 'package:decor_ride/features/ideabook/domain/entities/get_ideabook_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: unnecessary_import, unused_import
import 'package:flutter/foundation.dart';

part 'get_ideabook_state.freezed.dart';

@freezed
class GetIdeabooksState with _$GetIdeabooksState {
  const factory GetIdeabooksState.initial() = _Initial;
  const factory GetIdeabooksState.loading() = _Loading;
  const factory GetIdeabooksState.loaded(List<GetIdeabookEntity> ideabooks) =
      _Loaded;
  const factory GetIdeabooksState.error(String message) = _Error;
}
