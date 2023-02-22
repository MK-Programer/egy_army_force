import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/items_provider.dart';
import '../resources/route_manager.dart';
import '../utils/global_methods.dart';

class FetchDataScreen extends StatefulWidget {
  const FetchDataScreen({Key? key}) : super(key: key);

  @override
  State<FetchDataScreen> createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        try {
          setState(() => _isLoading = true);
          await getItems();
          setState(() => _isLoading = false);
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.menubarRoute,
            ModalRoute.withName(Routes.fetchDataRoute),
          );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _isLoading,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
