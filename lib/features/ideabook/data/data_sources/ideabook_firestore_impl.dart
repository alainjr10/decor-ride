import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/features/ideabook/data/data_sources/ideabook_firestore.dart';
import 'package:decor_ride/features/ideabook/data/models/ideabook_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IdeabookFirestoreSourceImpl implements IdeabookFirestore {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<List<IdeabookModel>> getAllIdeabooks() async {
    try {
      await _firestore.collection('ideabooks').get();
      return [];
    } catch (e, stackTrace) {
      "Error getting ideabooks ${e.toString()} with stacktrace ${stackTrace.toString()} "
          .log();
      rethrow;
    }
  }
}
