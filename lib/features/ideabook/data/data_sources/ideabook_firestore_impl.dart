import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:decor_ride/features/ideabook/data/data_sources/ideabook_firestore.dart';
import 'package:decor_ride/features/ideabook/domain/entities/create_ideabook_entity.dart';
import 'package:decor_ride/features/ideabook/domain/entities/get_ideabook_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ideabooksFirestoreProvider =
    Provider.autoDispose((ref) => IdeabookFirestoreSourceImpl());

class IdeabookFirestoreSourceImpl implements IdeabookFirestore {
  // ignore: unused_field
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<List<GetIdeabookEntity>, String>> getAllIdeabooks() async {
    try {
      final response = await _firestore
          .collection('ideabooks')
          .doc(_auth.currentUser!.uid)
          .collection('user_ideabooks')
          .get();
      return response.docs.isNotEmpty
          ? left(response.docs
              .map((e) => GetIdeabookEntity.fromMap(e.data()))
              .toList())
          : left([]);
    } on FirebaseException catch (e, stackTrace) {
      "Error getting ideabooks ${e.toString()} with stacktrace ${stackTrace.toString()} "
          .log();
      return right(e.toString());
    }
  }

  @override
  Future<Either<GetIdeabookEntity, String>> createIdeabook(
      CreateIdeabookEntity ideabook) async {
    try {
      final createIdeabookRef = _firestore
          .collection('ideabooks')
          .doc(_auth.currentUser!.uid)
          .collection('user_ideabooks')
          .doc();
      ideabook = ideabook.copyWith(ideabookId: createIdeabookRef.id);
      await createIdeabookRef.set(ideabook.toMap());
      GetIdeabookEntity getIdeabookEntity = GetIdeabookEntity(
        ideabookName: ideabook.ideabookName,
        ideabookDescription: ideabook.ideabookDescription,
        ideabookPrivate: ideabook.ideabookPrivate,
        ideabookId: ideabook.ideabookId,
        ideas: [],
      );
      return left(getIdeabookEntity);
    } on FirebaseException catch (e, stackTrace) {
      "Error creating ideabook ${e.toString()} with stacktrace ${stackTrace.toString()} "
          .log();
      return right(e.toString());
    }
  }
}
