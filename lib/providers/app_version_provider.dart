import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/app_version_model.dart';

class AppVersionProvider with ChangeNotifier {
  var appVersionModel;

  AppVersionModel get getAppVersion {
    return appVersionModel;
  }

  Future<void> fetchAppVersion() async {
    await FirebaseFirestore.instance
        .collection('app versions')
        .orderBy('created_at', descending: true)
        .limit(1)
        .get()
        .then(
      (QuerySnapshot itemSnapshot) {
        for (var element in itemSnapshot.docs) {
          appVersionModel = new AppVersionModel(
            version: element.get('version'),
            appUrl: element.get('app_url'),
          );
        }
      },
    );
    // log(appVersionModel);
    notifyListeners();
  }
}
