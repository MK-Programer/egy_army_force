import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/items_model.dart';
import '../utils/global_methods.dart';

class ActivitiesProvider with ChangeNotifier {
  static List<ItemModel> _itemsList = [];

  List<ItemModel> get getItems {
    return _itemsList;
  }

  ItemModel getItemById({
    required String id,
  }) {
    // ignore: unrelated_type_equality_checks
    return _itemsList.firstWhere((element) => element.id == id);
  }

  Future<void> fetchItems() async {
    await FirebaseFirestore.instance
        .collection('activities')
        .orderBy('createdAt')
        .get()
        .then(
      (QuerySnapshot itemSnapshot) {
        _itemsList = [];
        for (var element in itemSnapshot.docs) {
          _itemsList.insert(
            0,
            ItemModel(
              id: element.get('id'),
              itemNameEN: element.get('titleEN'),
              itemDescriptionEN: element.get('descriptionEN'),
              itemNameAR: element.get('titleAR'),
              itemDescriptionAR: element.get('descriptionAR'),
              imageUrl: element.get('imageUrl'),
            ),
          );
        }
      },
    );
    notifyListeners();
  }

  void addItem({
    required List<File> imageUrl,
    required String itemNameEN,
    required String itemDescriptionEN,
    required String itemNameAR,
    required String itemDescriptionAR,
  }) async {
    final uuid = const Uuid().v4();
    List<String> imageUri = [];
    imageUri = await Future.wait(
      imageUrl.map(
        (image) => GlobalMethods.uploadImage(
          folderName: 'Activities Images',
          image: image,
        ),
      ),
    );
    await FirebaseFirestore.instance.collection('activities').doc(uuid).set(
      {
        'id': uuid,
        'titleEN': itemNameEN,
        'descriptionEN': itemDescriptionEN,
        'titleAR': itemNameAR,
        'descriptionAR': itemDescriptionAR,
        'imageUrl': imageUri,
        'createdAt': Timestamp.now(),
      },
    );
    _itemsList.add(
      ItemModel(
        id: uuid,
        imageUrl: imageUri,
        itemNameEN: itemNameEN,
        itemDescriptionEN: itemDescriptionEN,
        itemNameAR: itemNameAR,
        itemDescriptionAR: itemDescriptionAR,
      ),
    );
    notifyListeners();
  }

  void clearAllItems() {
    _itemsList.clear();
    notifyListeners();
  }
}
