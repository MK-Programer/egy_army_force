import 'dart:io';
import 'package:egy_army_force/resources/img_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/items_provider.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/icon_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';
import '../utils/global_methods.dart';
import '../utils/utils.dart';
import '../widgets/loading_manager.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _titleEditingControllerEN =
      TextEditingController();
  final TextEditingController _descriptionEditingControllerEN =
      TextEditingController();

  final FocusNode _titleFocusNodeEN = FocusNode();
  final FocusNode _descriptionFocusNodeEN = FocusNode();

  final TextEditingController _titleEditingControllerAR =
      TextEditingController();
  final TextEditingController _descriptionEditingControllerAR =
      TextEditingController();

  final FocusNode _titleFocusNodeAR = FocusNode();
  final FocusNode _descriptionFocusNodeAR = FocusNode();

  File? _pickedImage;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleEditingControllerEN.dispose();
    _descriptionEditingControllerEN.dispose();

    _titleFocusNodeEN.dispose();
    _descriptionFocusNodeEN.dispose();

    _titleEditingControllerAR.dispose();
    _descriptionEditingControllerAR.dispose();

    _titleFocusNodeAR.dispose();
    _descriptionFocusNodeAR.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      final itemProvider = Provider.of<ItemsProvider>(context, listen: false);
      try {
        setState(() => _isLoading = true);
        itemProvider.addItem(
          imageUrl: _pickedImage!,
          itemNameEN: _titleEditingControllerEN.text,
          itemDescriptionEN: _descriptionEditingControllerEN.text,
          itemNameAR: _titleEditingControllerAR.text,
          itemDescriptionAR: _descriptionEditingControllerAR.text,
        );
        Fluttertoast.showToast(
          msg: AppString.productUploadedSuccessfully,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        emptyForm();
      } on FirebaseException catch (error) {
        setState(() => _isLoading = false);
        GlobalMethods.errorDialog(
            subTitle: error.message.toString(), context: context);
      } catch (error) {
        setState(() => _isLoading = false);
        GlobalMethods.errorDialog(subTitle: error.toString(), context: context);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _pickImageCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(
      () {
        _pickedImage = pickedImageFile;
      },
    );
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(
      () {
        _pickedImage = pickedImageFile;
      },
    );
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void emptyForm() {
    _titleEditingControllerEN.clear();
    _descriptionEditingControllerEN.clear();
    _titleEditingControllerAR.clear();
    _descriptionEditingControllerAR.clear();
    _pickedImage = null;
  }

  void _remove() {
    setState(
      () {
        _pickedImage = null;
      },
    );
    Navigator.pop(context);
  }

  void _showGalleryCameraPopupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: LocaleText(
            AppString.chooseOption,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                InkWell(
                  onTap: _pickImageCamera,
                  splashColor: ColorManager.grey,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Icon(
                          IconManager.camera,
                          color: ColorManager.grey,
                        ),
                      ),
                      LocaleText(
                        AppString.camera,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: _pickImageGallery,
                  splashColor: ColorManager.grey,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Icon(
                          IconManager.image,
                          color: ColorManager.grey,
                        ),
                      ),
                      LocaleText(
                        AppString.gallery,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: _remove,
                  splashColor: ColorManager.grey,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Icon(
                          IconManager.removeCircle,
                          color: ColorManager.red,
                        ),
                      ),
                      LocaleText(
                        AppString.remove,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: ColorManager.red),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var inputDecoration = InputDecoration(
    border: const UnderlineInputBorder(),
    filled: true,
    prefixIcon: Icon(IconManager.addCircleOutlined),
    labelText: '',
    fillColor: Colors.lightBlue.shade100,
  );

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * AppMargin.m0_02,
                ),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: AppMargin.m30,
                        horizontal: AppMargin.m30,
                      ),
                      child: _pickedImage == null
                          ? CircleAvatar(
                              radius: AppSize.s70,
                              backgroundImage: AssetImage(
                                ImgManager.emptyBox,
                              ),
                            )
                          : CircleAvatar(
                              radius: AppSize.s70,
                              backgroundImage: FileImage(_pickedImage!),
                            ),
                    ),
                    Positioned(
                      top: AppSize.s120,
                      left: AppSize.s110,
                      child: RawMaterialButton(
                        elevation: AppSize.s10,
                        fillColor: ColorManager.grey,
                        padding: const EdgeInsets.all(AppPadding.p15),
                        shape: const CircleBorder(),
                        onPressed: () {
                          _showGalleryCameraPopupDialog();
                        },
                        child: Icon(IconManager.gallery),
                      ),
                    )
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleEditingControllerEN,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppString.enterPlaneNameError
                                .localize(context);
                          } else {
                            return null;
                          }
                        },
                        focusNode: _titleFocusNodeEN,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_descriptionFocusNodeEN),
                        decoration: inputDecoration.copyWith(
                          labelText: AppString.planeNameEN.localize(context),
                        ),
                      ),
                      SizedBox(
                        height: size.height * AppMargin.m0_02,
                      ),
                      TextFormField(
                        maxLines: AppSize.s2.toInt(),
                        controller: _descriptionEditingControllerEN,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppString.enterPlaneDescriptionError
                                .localize(context);
                          } else {
                            return null;
                          }
                        },
                        focusNode: _descriptionFocusNodeEN,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_titleFocusNodeAR),
                        decoration: inputDecoration.copyWith(
                          labelText:
                              AppString.planeDescriptionEN.localize(context),
                        ),
                      ),
                      SizedBox(
                        height: size.height * AppMargin.m0_02,
                      ),
                      TextFormField(
                        controller: _titleEditingControllerAR,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppString.enterPlaneNameError
                                .localize(context);
                          } else {
                            return null;
                          }
                        },
                        focusNode: _titleFocusNodeAR,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_descriptionFocusNodeAR),
                        decoration: inputDecoration.copyWith(
                          labelText: AppString.planeNameAR.localize(context),
                        ),
                      ),
                      SizedBox(
                        height: size.height * AppMargin.m0_02,
                      ),
                      TextFormField(
                        maxLines: AppSize.s2.toInt(),
                        controller: _descriptionEditingControllerAR,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppString.enterPlaneDescriptionError
                                .localize(context);
                          } else {
                            return null;
                          }
                        },
                        focusNode: _descriptionFocusNodeAR,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          _submitForm();
                        },
                        decoration: inputDecoration.copyWith(
                          labelText:
                              AppString.planeDescriptionAR.localize(context),
                        ),
                      ),
                      SizedBox(
                        height: size.height * AppMargin.m0_02,
                      ),
                      SizedBox(
                        height: AppMargin.m40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: LocaleText(
                            AppString.upload,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s18,
                                  fontWeight: FontWeightManager.normal,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
