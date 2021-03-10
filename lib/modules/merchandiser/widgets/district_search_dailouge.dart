import 'dart:async';
import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:captain_bonik_app/common/utils/server.dart';
import 'package:captain_bonik_app/common/utils/toasty.dart';
import 'package:captain_bonik_app/common/widgets/loading_view.dart';
import 'package:captain_bonik_app/modules/merchandiser/model/division.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';


class DistrictSearchDialog<T> extends StatefulWidget {
  final Future<List<T>> Function() loadData;
  final String Function(dynamic data) bindTitle;
  final bool Function(dynamic data) isEnabled;
  final Function(dynamic value) onSelect;
  final String title;
  final String nameForSearch;
  final String type;
  final String divisionNameForArea;



  const DistrictSearchDialog({Key key,@required this.loadData,@required this.bindTitle, this.onSelect, this.title="",this.isEnabled,this.nameForSearch, this.type, this.divisionNameForArea}) : super(key: key);
  @override
  _DistrictSearchDialogState createState() => _DistrictSearchDialogState<T>();
}
class _DistrictSearchDialogState<T> extends State<DistrictSearchDialog>with App {
  StreamController<List<T>> _streamController = StreamController.broadcast();
  List<T> _dataList = [];
  List<Districts> district;

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
  void _loadData()async{
    _streamController.sink.add(null);
    widget.loadData().then((value){
      if(value.length==0){
        Server.instance.getRequest(url: "api/get-divisions-with-districts").then((value) {
          if(value != null){
            if(widget.type=='d'){
              List<Division> _dataListSub=[];
              _dataListSub.addAll(Division.listFromJson(value));
              var v=_dataListSub.firstWhere((element)=>
              widget.nameForSearch==element.name
              );
              _streamController.sink.add(v.districts.cast<T>());
            }else if (widget.type=='area'){
              List<Division> _dataListSubDivision=[];
              _dataListSubDivision.addAll(Division.listFromJson(value));
              var v=_dataListSubDivision.firstWhere((element)=>
              widget.divisionNameForArea==element.name
              );
              var a=v.districts.firstWhere((element) => widget.nameForSearch==element.name);
              _streamController.sink.add(a.thanas.cast<T>());
            }
          }
        }).catchError((e) {
          if(mounted)
            Navigator.pop(context);
          if(e.toString()=='internet')
            Toasty.of(context).showError('No internet connection !');
          else
            Toasty.of(context).showError(e.toString());
        });
      }
      if(value != null){
        _dataList.addAll(value.cast<T>());
        _streamController.sink.add(_dataList);
      }
    }).catchError((e){
      print(e);
    });
  }
  void _onSearchTermChanged(String value) {
    if(_dataList.length >0){
      if(value.isNotEmpty){
        _streamController.sink.add(_dataList.where((element) => widget.bindTitle(element).toLowerCase().contains(value.toLowerCase())).toList());
      }else{
        _streamController.sink.add(_dataList);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+16),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24)),
        ),
        child: Column(
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 22,
                  color: color.primaryColor,
                  fontWeight: FontWeight.bold
              ),
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: 32,right: 32, top: 24,bottom: 8),
              padding: EdgeInsets.only(left: 20, top: 12,bottom: 12,right: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: color.primaryColor,
                  width: 1.6,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: TextField(
                        onChanged: _onSearchTermChanged,
                        autocorrect: false,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search..",
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(.6),
                          ),
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child:Icon(Icons.search, size: 22,color: Colors.grey.withOpacity(.4),),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<T>>(
                  stream: _streamController.stream,
                  initialData: [],
                  builder: (context, snapshot) {
                    if(snapshot.data.length==0){
                      return LoadingView();
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal:8.0),
                      child: KeyboardAvoider(
                        autoScroll: true,
                        child: ListView.builder(
                          controller: ScrollController(),
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index){
                            return _buildItemButton(context, snapshot, index, index == snapshot.data.length);
                          },
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildItemButton(BuildContext context, AsyncSnapshot<List<T>> snapshot, int index, bool isOthers) {
    return GestureDetector(
      onTap: (){
        if(isOthers){
          Navigator.of(context).pop();
        }
        else {
          if(widget.isEnabled == null || widget.isEnabled(snapshot.data[index])) {
            Navigator.of(context).pop();
            widget.onSelect?.call(snapshot.data[index]);
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(index==0)Container(
            height: 1,
            width: double.maxFinite,
            color: Colors.grey.withOpacity(.2),
          ),
          Container(
            padding: EdgeInsets.only(top: 16,bottom: 16),
            width: double.maxFinite,
            color:Colors.transparent,
            child: Text(widget.bindTitle(snapshot.data[index]),
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: isOthers?Colors.redAccent: widget.isEnabled != null? widget.isEnabled(snapshot.data[index])? Colors.black.withOpacity(.64):Colors.black.withOpacity(.26):Colors.black.withOpacity(.64),
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.maxFinite,
            color: Colors.grey.withOpacity(.2),
          ),
        ],
      ),
    );
  }
}


