import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'fader.dart';

typedef FutureAction = Future Function();
typedef _CheckBuilder = bool Function();
class DefaultActionButton extends StatefulWidget {
  final String title;
  final FutureAction tapAction;
  final VoidCallback onStartWorking;
  final VoidCallback onFinishWorking;
  final _CheckBuilder onCheck;
  final DefaultActionButtonController controller;
  final Function(dynamic value) onSuccess;
  final Function(dynamic error) onError;
  final bool enabled;

  DefaultActionButton({
    Key key,
    @required this.title,
    @required this.tapAction,
    @required this.onSuccess,
    @required this.onError,
    this.onCheck,
    this.onStartWorking,
    this.onFinishWorking,
    this.controller,
    this.enabled=true,
  }) : super(key: key);


  @override
  _DefaultActionButtonState createState() => _DefaultActionButtonState();
}
class _DefaultActionButtonState extends State<DefaultActionButton> with App{
  final _buttonTextColor = Colors.white;
  bool _expanded;
  int _stateIndex;


  @override
  void initState() {
    _expanded = true;
    _stateIndex = 0;
    super.initState();
    if(widget.controller != null) widget.controller._setAutoTapEventHandler(_onTap);
    if(widget.controller != null) widget.controller._setForceTapEventHandler(_executeRequest);
  }

  void _onTap() {
    if( mounted && _stateIndex == 0 && widget.enabled)
    {
      if(widget.onCheck == null || widget.onCheck()) {
        _executeRequest();
      }
    }
  }

  void _executeRequest() {
    if (widget.onStartWorking != null) widget.onStartWorking();

    // // set state to working
    if(mounted)
      setState(() {
        _expanded = false;
        _stateIndex = 1;
      });
    widget.tapAction().then((x) {
      // set state to success
      if(mounted)
        setState(() {
          try{
            if(x.status.toLowerCase() == "ok".toLowerCase()) {
              _stateIndex = 2;
              Future.delayed(Duration(milliseconds: 700)).then((_){
                widget.onSuccess(x);
              });
            }else{
              _stateIndex = 3;
              widget.onError(x.messages);
            }
          }catch(e){
            _stateIndex = 3;
            widget.onError("Something error occurred!");
          }
        });
    }).catchError((x) {
      // set state to error
      if(mounted)
        setState(() {
          _stateIndex = 3;
        });
      widget.onError(x);
    }).whenComplete(() {
      // reset state to normal
      Future.delayed(Duration(milliseconds: 1200)).then((x) {
        if(mounted)
          setState(() {
            _expanded = true;
            _stateIndex = 0;
          });
        if (widget.onFinishWorking != null) widget.onFinishWorking();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          height: 55,
          width: _expanded?MediaQuery.of(context).size.width:44,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.primaryWhite.withOpacity(widget.enabled?1.0:.5),
            gradient: style.textColorGradient,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Fader(
              index: _stateIndex,
              children: <Widget>[
                // title text
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _buttonTextColor,
                  ),
                ),

                // progressbar
                SizedBox(
                  height: 24,
                  width: 24,
                  child:
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(_buttonTextColor),
                    strokeWidth: 2,
                  ),
                ),

                // Success icon
                Icon(Icons.check, color: _buttonTextColor,size: 24),

                // Error icon
                Icon(Icons.close, color: _buttonTextColor,size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultActionButtonController{
  VoidCallback _autoTapEvent;
  VoidCallback _forceTapEvent;
  void _setAutoTapEventHandler(VoidCallback event)
  {
    _autoTapEvent = event;
  }
  void _setForceTapEventHandler(VoidCallback event)
  {
    _forceTapEvent = event;
  }

  void tap(){
    if(_autoTapEvent != null)
      _autoTapEvent();
  }
  void forceTap(){
    _forceTapEvent?.call();
  }
}


