import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Toasty{
  OverlayState _overlayState;
  static OverlayEntry _uiLockOverlayEntry;
  static bool _isUiLocked = false;

  // constructor
  Toasty.of(BuildContext context){
    try {
      _overlayState = Overlay.of(context);
      if (_uiLockOverlayEntry == null)
        _uiLockOverlayEntry = OverlayEntry(builder: _buildUiLockOverlayEntry);
    }
    catch(_)
    {
      print(_);
    }
  }


  // public methods
  showSuccess(String message, {Duration duration = const Duration(milliseconds: 3000)}){
    _showToast(message,duration,"success");
  }
  showWarning(String message, {Duration duration = const Duration(milliseconds: 3000)}){
    _showToast(message,duration,"warning");
  }
  showError(String message, {Duration duration = const Duration(milliseconds: 3000)}){
    _showToast(message,duration,"error");
  }
  _showToast(String message, Duration duration, String type){
    ToastOverlayEntry overlay = ToastOverlayEntry(
      message: message,
      duration: duration,
      type: type,
    );
    _overlayState?.insert(overlay.overlayEntry);
  }



  // block touch screen
  lockUI({bool blockBackPress=false}){
    if(!_isUiLocked) {
      _overlayState.insert(_uiLockOverlayEntry);
      _isUiLocked = true;
    }
  }
  releaseUI(){
    if(_isUiLocked) {
      _uiLockOverlayEntry.remove();
      _isUiLocked = false;
    }
  }
  Widget _buildUiLockOverlayEntry(BuildContext context) {
    var screen = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: ()=> Future<bool>.value(false),
      child: Container(
        color: Colors.transparent,
        height: screen.size.height,
        width: screen.size.width,
      ),
    );
  }


}

class ToastOverlayEntry{
  final String message;
  final Duration duration;
  final String type;

  // constructor
  ToastOverlayEntry({
    @required this.message,
    @required this.duration,
    @required this.type,
  });


  // overlay entry getter
  OverlayEntry _overlayEntry;
  OverlayEntry get overlayEntry {
    _overlayEntry = OverlayEntry(
        builder: (x)=> _Toast(
          context: x,
          message: message,
          duration: duration,
          type: type,
          onRemove:_onRemove,
        )
    );
    return _overlayEntry;
  }

  void _onRemove() {
    if(_overlayEntry != null)
    {
      try{
        _overlayEntry.remove();
      }
      catch (e)
      {
        print(e);
      }
    }
  }
}
class _Toast extends StatefulWidget {
  final BuildContext context;
  final String message;
  final Duration duration;
  final String type;
  final VoidCallback onRemove;

  const _Toast({Key key,
    @required this.context,
    @required this.message,
    @required this.duration,
    @required this.type,
    @required this.onRemove,
  }) : super(key: key);

  @override
  __ToastState createState() => __ToastState();
}
class __ToastState extends State<_Toast> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation<double> _offsetAnimation;

  final double _padding = 12;
  Color _color = Colors.red;
  IconData _icon;
  @override
  void initState() {
    super.initState();

    // animation initialization
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    _offsetAnimation = Tween(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInCubic));


    // color and icon initialization;
    if(widget.type == "success")
    {
      _color = Color(0xff028207);
      _icon = CupertinoIcons.check_mark_circled_solid;
    }
    else if(widget.type == "warning")
    {
      _color = Color(0xffFF6700);
      _icon = Icons.error;
    }
    else {
      _color = Color(0xffD10404);
      _icon = CupertinoIcons.clear_circled_solid;
    }


    // start animation
    SchedulerBinding.instance.addPostFrameCallback((x){
      _handleAnimation();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleAnimation()
  {
    try{
      _animationController.forward().then((x){
        return Future.delayed(widget.duration);
      }).then((x){
        try {
          return _animationController.reverse();
        }catch(_){}
      }).then((x){
        widget.onRemove();
      });
    }catch(_){}
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context);
    return Positioned(
      left: 0,
      top: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, Widget child){
          return FractionalTranslation(
            translation: Offset(0, _offsetAnimation.value),
            child: child,
          );
        },
        child: Material(
          child: Container(
            width: screen.size.width,
            padding: EdgeInsets.only(left: _padding, right: _padding, bottom: _padding, top: _padding + screen.padding.top),
            decoration: BoxDecoration(
              color: Color(0xffF2F2F2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  offset: Offset(0, 3),
                  blurRadius: 10,
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _icon,
                  color: _color,
                  size: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(
                      widget.message,
                      style: TextStyle(
                        fontSize: 16,
                        color: _color,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
