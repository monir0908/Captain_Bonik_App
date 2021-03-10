
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BottomSheetImagePicker extends StatefulWidget {
  final VoidCallback onCamera, onGallery;
  const BottomSheetImagePicker(
      {Key key, @required this.onCamera, @required this.onGallery})
      : super(key: key);

  @override
  _BottomSheetImagePickerState createState() => _BottomSheetImagePickerState();
}
class _BottomSheetImagePickerState extends State<BottomSheetImagePicker> with App {
  int selected = 0;
  bool _tapped = false;

  void _onSelect(int index) {
    if (!_tapped) {
      _tapped = true;
      setState(() {
        selected = index;
      });

      Future.delayed(Duration(milliseconds: 250)).then((x) {
        if (index == 1) {
          widget.onCamera();
        } else if (index == 2) {
          widget.onGallery();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.camera,
                  color: Color(0xff006A4E),
                  size: 24,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Pick image from",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff006A4E),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _onSelect(1),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: selected == 1
                                ? Color(0xff006A4E)
                                : Color(0xFF828282),
                            width: 1.2)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.photo_camera,
                          color: selected == 1
                              ? Color(0xff006A4E)
                              : Color(0xFF828282),
                          size: 32,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text("${'Camera'}",
                            style: TextStyle(
                                fontSize: 20,
                                color: selected == 1
                                    ? Color(0xff006A4E)
                                    : Color(0xFF828282))),
                      ],
                    ),
                  ),
                ),
                Text("${'or'}",
                    style: TextStyle(
                        fontSize: 24, color: Color(0xFF828282))),
                GestureDetector(
                  onTap: () => _onSelect(2),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: selected == 2
                                ? Color(0xff006A4E)
                                : Color(0xFF828282),
                            width: 1.2)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.image,
                          color: selected == 2
                              ? Color(0xff006A4E)
                              : Color(0xFF828282),
                          size: 32,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text("${'Gallery'}",
                            style: TextStyle(
                                fontSize: 20,
                                color: selected == 2
                                    ? Color(0xff006A4E)
                                    : Color(0xFF828282))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageThumbWidget extends StatefulWidget {
  final Function(int index) onRemove;
  final int index;
  final String path;

  const ImageThumbWidget({Key key, this.onRemove, this.path, @required this.index}) : super(key: key);
  @override
  _ImageThumbWidgetState createState() => _ImageThumbWidgetState();
}
class _ImageThumbWidgetState extends State<ImageThumbWidget> with App{
  StreamController<Uint8List> _streamController = StreamController();
  @override
  void initState() {
    super.initState();
    _compressImage();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  _compressImage()async{
    if(widget.path != null && widget.path.trim().isNotEmpty) {
      if(!_streamController.isClosed){
        _streamController.sink.add(null);
      }
      Uint8List originalUnit8List = File(widget.path).readAsBytesSync();
      var codec = await ui.instantiateImageCodec(originalUnit8List, targetHeight: (screen.devicePixelRatio * 86).toInt(), targetWidth: (screen.devicePixelRatio * 74).toInt());
      var frameInfo = await codec.getNextFrame();
      ui.Image targetUiImage = frameInfo.image;
      ByteData targetByteData = await targetUiImage.toByteData(format: ui.ImageByteFormat.png);
      if(!_streamController.isClosed && targetByteData != null){
        _streamController.sink.add(targetByteData.buffer.asUint8List());
      }
    }
  }

  @override
  void didUpdateWidget(covariant ImageThumbWidget oldWidget) {
    if(oldWidget.path != widget.path){
      _compressImage();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156,
      width: 124,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(8),
            child: StreamBuilder<Uint8List>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return Image.memory(
                      snapshot.data,
                      fit: BoxFit.cover,
                    );
                  }
                  else return Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.grey),strokeWidth: 2,),
                    ),
                  );
                }
            ),
          ),
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
  void _removeImage() {
    widget.onRemove?.call(widget.index);
  }
}