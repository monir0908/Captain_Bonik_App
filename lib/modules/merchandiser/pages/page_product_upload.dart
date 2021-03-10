import 'dart:io';

import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:captain_bonik_app/common/utils/toasty.dart';
import 'package:captain_bonik_app/common/utils/toasty_v2.dart';
import 'package:captain_bonik_app/modules/merchandiser/model/division.dart';
import 'package:captain_bonik_app/modules/merchandiser/widgets/bottom_sheet_image_picker.dart';
import 'package:captain_bonik_app/modules/merchandiser/widgets/district_search_dailouge.dart';
import 'package:captain_bonik_app/modules/merchandiser/widgets/division_search_dailouge.dart';
import 'package:captain_bonik_app/modules/merchandiser/widgets/image_picker.dart';
import 'package:captain_bonik_app/modules/merchandiser/widgets/navigator_menu_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductUploadPage extends StatefulWidget {
  @override
  _ProductUploadPageState createState() =>
      _ProductUploadPageState();
}

class _ProductUploadPageState extends State<ProductUploadPage>
    with App {
  List<String> _files=[];
  ScrollController _scrollController = ScrollController();
  final TextEditingController _divisionController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  int _divisionId;
  int _districtId;
  int _areaId;
  List<Districts> _districtsList = [];
  List<Thanas> _areasList = [];

  _addImage(String x) {
    try {
      if(mounted)setState(() {
        if(x != null){
          _files.add(x);
        }
        _scrollToBottom();
      });
    } catch (_) {debugPrint(_);}
  }

  void _scrollToBottom() {
    if(_scrollController.position != null && _scrollController.position.maxScrollExtent>0){
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
  _removeImage(int key) {
    try {
      if(mounted)setState(() {
        _files.removeAt(key);
        _scrollToBottom();
      });
    }catch (_) {debugPrint(_);}
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screen.padding.top + 16,
            ),
            Icon(
                Icons.arrow_back,
                color: Color(0xff006A4E),
                size: 32,
              ),

            Padding(
              padding: const EdgeInsets.only(
                top: 10, ),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: color.primaryColor,
                    width: 1,
                  ),
                ),
                child: GestureDetector(
                  onTap: _showDivisionSelectionDialog,
                  child: TextFormField(
                    controller: _divisionController,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    enabled: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '${'This Field Not Empty'}';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding:  EdgeInsets.symmetric( vertical: 12),
                        border: InputBorder.none,
                        suffixIconConstraints: BoxConstraints(
                          minWidth: 25,
                          minHeight: 25,
                        ),

                        suffixIcon: Icon(Icons.arrow_drop_down,size: 32,
                          color: color.primaryColor,
                        ),
                        isDense: true,
                        icon: Icon(
                          Icons.add_location,
                          size: 24,
                          color: color.primaryColor,
                        ),
                        hintText: "Select your division",
                        labelStyle: TextStyle( color:Colors.black.withOpacity(.6),)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only( top: 10, ),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: color.primaryColor,
                    width: 1,
                  ),
                ),
                child: GestureDetector(
                  onTap: _showDistrictSelectionDialog,
                  child: TextFormField(
                    controller: _districtController,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    enabled: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '${'This Field Not Empty'}';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding:  EdgeInsets.symmetric( vertical: 12),
                        suffixIconConstraints: BoxConstraints(
                          minWidth: 25,
                          minHeight: 25,
                        ),

                        suffixIcon: Icon(Icons.arrow_drop_down,size: 32,
                          color: color.primaryColor,
                        ),
                        isDense: true,
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.add_location,
                          size: 24,
                          color: color.primaryColor,
                        ),
                        hintText: "Select your district",
                        labelStyle: TextStyle(color:Colors.black.withOpacity(.6),)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: color.primaryColor,
                    width: 1,
                  ),
                ),
                child: GestureDetector(
                  onTap: _showAreaSelectionDialog,
                  child: TextFormField(
                    controller: _areaController,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    enabled: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '${'This Field Not Empty'}';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding:  EdgeInsets.symmetric( vertical: 12),
                        suffixIconConstraints: BoxConstraints(
                          minWidth: 25,
                          minHeight: 25,
                        ),

                        suffixIcon: Icon(Icons.arrow_drop_down,size: 32,
                          color: color.primaryColor,
                        ),
                        isDense: true,
                        border:InputBorder.none,
                        icon: Icon(
                          Icons.add_location,
                          size: 24,
                          color: color.primaryColor,
                        ),
                        hintText: "Select your area",
                        labelStyle: TextStyle(color:Colors.black.withOpacity(.6),)),
                  ),
                ),
              ),
            ),
            Center(
              child: _files.length >0 ?Container(
                margin: EdgeInsets.only(top: 16,bottom: 16,left: 16,right: 16),
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    ..._files.asMap().map((key, value) => MapEntry(key,GestureDetector(
                      onTap:() =>_showImage(value),
                      child: ImageThumbWidget(
                          key: ObjectKey(value),
                          path: value,
                          index: key,
                          onRemove: (x)=> _removeImage(x),
                      ),
                    ))).values.toList(),
                    _files.length!=3?ImagePickerWidget(
                      length: 3-_files.length,
                      onPicked: (x)=> _addImage(x.path),
                    ):Container(),

                  ],
                ),
              ):Center(
                child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 16,bottom: 16,),
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  decoration: BoxDecoration(
                    color: color.primaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: ImagePickerWidget(
                      onPicked: (x)=> _addImage(x.path),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16,),
          ],
        ),
      ),
    );
  }


  _showImage(String value){
  showDialog(context: context, builder: (context)=> Dialog(
    child: AspectRatio(
      aspectRatio: 1,
      child: Container(
        child: Image.memory(File(value).readAsBytesSync()),
      ),
    ),
  ));
}
  void _showDivisionSelectionDialog() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return DivisionSearchDialog(
            isEnabled: (x) => true,
            title: 'Select Division',
            bindTitle: (x) => x.name,
            onSelect:(x){
              _onDivisionSelect(x);
            },

          );
        });
  }
  _onDivisionSelect(Division division) {
    _districtsList.clear();
    _districtController.clear();
    _areaController.clear();
    _areasList.clear();
    _divisionController.text=division.name;
    _districtsList.addAll(division.districts);
    _divisionId=division.id;
    _areaId=null;
    _districtId=null;
  }

  void _showDistrictSelectionDialog() {
    if( _divisionController.text.isNotEmpty)
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return DistrictSearchDialog(
              isEnabled: (x) => true,
              loadData: () async => _districtsList,
              title: 'Select District',
              bindTitle: (x) => x.name,
              nameForSearch: _divisionController.text,
              type: 'd',
              onSelect:(x){
                _onDistrictSelect(x);
              },
            );
          });
    else
      Toasty.of(context).showWarning('Please select division !');
  }
  _onDistrictSelect(Districts district) {
    _areasList.clear();
    _areaController.clear();
    _areaId=null;
    _districtController.text=district.name;
    _areasList.addAll(district.thanas);
    _districtId=district.id;
  }

  void _showAreaSelectionDialog() {
    if(_districtController.text.isNotEmpty)
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return DistrictSearchDialog(
              isEnabled: (x) => true,
              loadData: () async => _areasList,
              title: 'Select Area',
              bindTitle: (x) => x.name,
              type: 'area',
              nameForSearch: _districtController.text,
              divisionNameForArea: _divisionController.text,
              onSelect:(x){
                _onAreaSelect(x);
              },
            );
          });
    else{
      if (_divisionController.text.isEmpty){
        Toasty.of(context).showWarning('Please select division !');
      }else {
        Toasty.of(context).showWarning('Please select district !');
      }
    }

  }
  _onAreaSelect(Thanas area) {
    _areaController.text=area.name;
    _areaId=area.id;
  }

}
