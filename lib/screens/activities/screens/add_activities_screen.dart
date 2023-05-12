import 'dart:io';
import '../../../providers/activities_provider.dart';
import '../../../resources/img_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/icon_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../utils/global_methods.dart';
import '../../../utils/utils.dart';
import '../../../widgets/loading_manager.dart';

class AddActivitiesScreen extends StatefulWidget {
  const AddActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<AddActivitiesScreen> createState() => _AddActivitiesScreenState();
}

class _AddActivitiesScreenState extends State<AddActivitiesScreen> {
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

  List<File> _pickedImage = [];
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
      final itemProvider =
          Provider.of<ActivitiesProvider>(context, listen: false);
      try {
        setState(() => _isLoading = true);
        itemProvider.addItem(
          imageUrl: _pickedImage,
          itemNameEN: _titleEditingControllerEN.text,
          itemDescriptionEN: _descriptionEditingControllerEN.text,
          itemNameAR: _titleEditingControllerAR.text,
          itemDescriptionAR: _descriptionEditingControllerAR.text,
        );
        Fluttertoast.showToast(
          msg: AppString.activityUploadedSuccessfully.localize(context),
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

  // void _pickImageCamera() async {
  //   final pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);
  //   final pickedImageFile = File(pickedImage!.path);
  //   setState(
  //     () {
  //       _pickedImage = pickedImageFile;
  //     },
  //   );
  //   // ignore: use_build_context_synchronously
  //   Navigator.pop(context);
  // }

  void _pickImageGallery() async {
    final pickedImage = await ImagePicker().pickMultiImage();

    // if atleast 1 images is selected it will add
    // all images in selectedImages
    // variable so that we can easily show them in UI
    // ignore: unnecessary_null_comparison
    if (pickedImage.isNotEmpty) {
      for (var i = 0; i < pickedImage.length; i++) {
        _pickedImage.add(File(pickedImage[i].path));
      }
      setState(
        () {},
      );
    } else {
      // If no image is selected it will show a
      // snackbar saying nothing is selected
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: LocaleText(
            AppString.nothing_selected,
          ),
        ),
      );
    }

    // final pickedImageFile = File(pickedImage!.path);
    // setState(
    //   () {
    //     _pickedImage = pickedImageFile;
    //   },
    // );
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void emptyForm() {
    _titleEditingControllerEN.clear();
    _descriptionEditingControllerEN.clear();
    _titleEditingControllerAR.clear();
    _descriptionEditingControllerAR.clear();
    _pickedImage.clear();
  }

  void _remove() {
    setState(
      () {
        _pickedImage.clear();
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
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: ColorManager.black),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                // InkWell(
                //   onTap: _pickImageCamera,
                //   splashColor: ColorManager.grey,
                //   child: Row(
                //     children: [
                //       const Padding(
                //         padding: EdgeInsets.all(AppPadding.p8),
                //         child: Icon(
                //           IconManager.camera,
                //           color: ColorManager.grey,
                //         ),
                //       ),
                //       LocaleText(
                //         AppString.camera,
                //         style: Theme.of(context)
                //             .textTheme
                //             .titleMedium!
                //             .copyWith(color: ColorManager.black),
                //       )
                //     ],
                //   ),
                // ),
                InkWell(
                  onTap: _pickImageGallery,
                  splashColor: ColorManager.grey,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(AppPadding.p8),
                        child: Icon(
                          IconManager.image,
                          color: ColorManager.grey,
                        ),
                      ),
                      LocaleText(
                        AppString.gallery,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: ColorManager.black),
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
    prefixIcon: const Icon(IconManager.addCircleOutlined),
    labelText: AppString.empty,
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
                      child: _pickedImage.isEmpty
                          ? CircleAvatar(
                              radius: AppSize.s70,
                              backgroundImage: AssetImage(
                                ImgManager.emptyBox,
                              ),
                            )
                          : CircleAvatar(
                              radius: AppSize.s70,
                              backgroundImage: FileImage(_pickedImage[0]),
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
                        child: const Icon(IconManager.gallery),
                      ),
                    )
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: _titleEditingControllerEN,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppString.enterActivityNameError
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
                          labelText: AppString.activityNameEN.localize(context),
                        ),
                      ),
                      SizedBox(
                        height: size.height * AppMargin.m0_02,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: AppSize.s2.toInt(),
                        controller: _descriptionEditingControllerEN,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppString.enterActivityDescriptionError
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
                              AppString.activityDescriptionEN.localize(context),
                        ),
                      ),
                      SizedBox(
                        height: size.height * AppMargin.m0_02,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: _titleEditingControllerAR,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppString.enterActivityNameError
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
                          labelText: AppString.activityNameAR.localize(context),
                        ),
                      ),
                      SizedBox(
                        height: size.height * AppMargin.m0_02,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: AppSize.s2.toInt(),
                        controller: _descriptionEditingControllerAR,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppString.enterActivityDescriptionError
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
                              AppString.activityDescriptionAR.localize(context),
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
