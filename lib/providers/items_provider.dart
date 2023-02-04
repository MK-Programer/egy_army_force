import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/items_model.dart';

class ItemsProvider with ChangeNotifier {
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
    await FirebaseFirestore.instance.collection('items').get().then(
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
    print(_itemsList);
    notifyListeners();
  }

  void addItem({
    required File imageUrl,
    required String itemNameEN,
    required String itemDescriptionEN,
    required String itemNameAR,
    required String itemDescriptionAR,
  }) async {
    final uuid = const Uuid().v4();
    Reference storageReference =
        FirebaseStorage.instance.ref().child("Products Images/${uuid}jpg");
    final UploadTask uploadTask = storageReference.putFile(imageUrl);
    final TaskSnapshot downloadUrl = (await uploadTask);
    String imageUri = await downloadUrl.ref.getDownloadURL();
    await FirebaseFirestore.instance.collection('items').doc(uuid).set(
      {
        'id': uuid,
        'titleEN': itemNameEN,
        'descriptionEN': itemDescriptionEN,
        'titleAR': itemNameAR,
        'descriptionAR': itemDescriptionAR,
        'imageUrl': imageUri,
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
