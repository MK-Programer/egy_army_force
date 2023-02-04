import 'package:flutter/cupertino.dart';

class ItemModel with ChangeNotifier {
  final String id;
  final String imageUrl;
  final String itemNameEN;
  final String itemDescriptionEN;

  final String itemNameAR;
  final String itemDescriptionAR;
  ItemModel({
    required this.id,
    required this.imageUrl,
    required this.itemNameEN,
    required this.itemDescriptionEN,
    required this.itemNameAR,
    required this.itemDescriptionAR,
  });
}
