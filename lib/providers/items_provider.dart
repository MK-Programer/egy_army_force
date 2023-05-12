import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/items_model.dart';
import '../resources/language_manager.dart';
import '../resources/string_manager.dart';
import '../utils/global_methods.dart';
import '../utils/utils.dart';

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

  List<ItemModel> searchQuery(String searchText, BuildContext context) {
    String currentLang = Utils(context).getCurrentLocale ==
            LanguageType.ENGLISH.getValue().toUpperCase()
        ? AppString.enLang
        : AppString.arLang;
    return _itemsList.where((element) {
      dynamic result = currentLang == AppString.enLang
          ? element.itemNameEN
          : element.itemNameAR;

      return result.toLowerCase().contains(
            searchText.toLowerCase(),
          );
    }).toList();
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
          folderName: 'Products Images',
          image: image,
        ),
      ),
    );
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
