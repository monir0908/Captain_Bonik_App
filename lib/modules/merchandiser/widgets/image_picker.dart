

import 'dart:io';

import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:captain_bonik_app/common/utils/toasty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'bottom_sheet_image_picker.dart';
class ImagePickerWidget extends StatefulWidget {
  final Function(File file) onRemove;
  final Function(File file) onPicked;
  final File file;
  final int length;

  const ImagePickerWidget({Key key, this.onRemove, this.onPicked, this.file, this.length}) : super(key: key);
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}
class _ImagePickerWidgetState extends State<ImagePickerWidget> with App{
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showImagePicker,
      child: widget.file == null? _buildNoImageWidget():_buildImageWidget(),
    );
  }

  Container _buildNoImageWidget() {
    return Container(
      height: 156,
      width: 124,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(
          Icons.camera_alt_outlined,
          size: 42,
          color:color.primaryColor,
        ),
          Text('Upload\nPicture',style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: color.primaryColor),),
      ],)
    );
  }
  Container _buildImageWidget() {
    return Container(
      height: 86,
      width: 74,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(8),child: Image.file(widget.file, fit: BoxFit.cover,)),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: _removeImage,
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.redAccent,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showImagePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetImagePicker(
          onCamera: () => _onOptionSelected(ImageSource.camera),
          onGallery: () => _onOptionSelected(ImageSource.gallery),
        );
      },
    );
  }
  _onOptionSelected(ImageSource source) async{
    if(source==ImageSource.gallery){
      Navigator.of(context).pop();
      loadAssets();
    }else {
      Navigator.of(context).pop();
      try {
        var image = await ImagePicker().getImage(
            source: source, imageQuality: 80);
        if (image != null) {
          widget.onPicked?.call(File(image.path));
        }
      } catch (_) {
        Toasty.of(context).showError("Failed to pick image!");
      }
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: widget.length??3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat",),
        materialOptions: MaterialOptions(
          statusBarColor: '#006A4E',
          actionBarColor: "#006A4E",
          actionBarTitle: "Captain Bonik App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted)
      return;
    setState(() {
      images = resultList;
      _error = error;

    });
    images.forEach((imageAsset) async {
    final filePath = await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
      File tempFile = File(filePath);
      if (tempFile.existsSync()) {
        widget.onPicked?.call(File(tempFile.path));
      }});
  }
  void _removeImage() {
    widget.onRemove?.call(widget.file);
  }
}