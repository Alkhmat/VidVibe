import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vidvibe/src/core/firebase/firebase_collections/firebase_collections.dart';
import 'package:vidvibe/src/repository/contents/model/content_model.dart';

class LoadUpgradeCubit extends Cubit<List<ContentModel>> {
  LoadUpgradeCubit() : super([]);

  Future<void> refreshContent() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(
              FirebaseCollections.content) // Replace with your collection name
          .get();

      final newContentList =
          snapshot.docs.map((doc) => ContentModel.fromFirestore(doc)).toList();

      newContentList.shuffle(); // Shuffle the list

      emit(newContentList); // Emit the new list to update UI
    } catch (e) {
      // Handle error
      print('Error refreshing content: $e');
    }
  }
}
