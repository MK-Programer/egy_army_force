import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import '../providers/app_version_provider.dart';
import '../providers/items_provider.dart';
import '../resources/route_manager.dart';
import '../resources/string_manager.dart';
import '../utils/global_methods.dart';

final String APP_VERSION = "1.0";

class FetchDataScreen extends StatefulWidget {
  const FetchDataScreen({Key? key}) : super(key: key);

  @override
  State<FetchDataScreen> createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
  bool _isLoading = false;
  String errorString = AppString.empty;

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        try {
          setState(() => _isLoading = true);
          await getAppVersion();
          var appVersion =
              Provider.of<AppVersionProvider>(context, listen: false)
                  .getAppVersion;
          // print(appVersion.version != APP_VERSION);
          if (appVersion.version != APP_VERSION) {
            errorString = AppString.anErrorOccured;
            throw appVersion.appUrl;
          } else {
            await await getItems();
            setState(() => _isLoading = false);
            // ignore: use_build_context_synchronously
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.menubarRoute,
              ModalRoute.withName(Routes.fetchDataRoute),
            );
          }
        } on FirebaseException catch (error) {
          setState(() => _isLoading = false);
          GlobalMethods.errorDialog(
              subTitle: error.message.toString(), context: context);
        } catch (error) {
          setState(() => _isLoading = false);
          GlobalMethods.errorDialog(
              subTitle: error.toString(), context: context);
        } finally {
          setState(() => _isLoading = false);
        }
      },
    );
    super.initState();
  }

  getItems() async {
    await Provider.of<ItemsProvider>(context, listen: false).fetchItems();
  }

  getAppVersion() async {
    await Provider.of<AppVersionProvider>(context, listen: false)
        .fetchAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: errorString != AppString.empty
          ? Center(
              child: LocaleText(
                errorString,
              ),
            )
          : Visibility(
              visible: _isLoading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
