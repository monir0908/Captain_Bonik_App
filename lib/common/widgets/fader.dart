


// Fader
import 'package:flutter/material.dart';

class Fader extends StatefulWidget {
  final int index;
  final List<Widget> children;

  const Fader({Key key, this.index, this.children}) : super(key: key);

  @override
  _FaderState createState() => _FaderState();
}
class _FaderState extends State<Fader> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _opacityAnimation;
  Widget _widget;

  @override
  void initState() {
    _widget = widget.children.elementAt(widget.index);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCubic));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Fader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      _animationController.forward().then((x) {
        // set new widget
        _widget = widget.children.elementAt(widget.index);
      }).then((x) {
        _animationController.reverse();
      });
    }
    setState(() {
      _widget = widget.children.elementAt(widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: _widget,
        );
      },
    );
  }
}
