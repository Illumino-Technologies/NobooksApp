// ignore_for_file: non_constant_identifier_names, unused_element, must_be_immutable

import 'package:flutter/material.dart';

class Structure extends StatelessWidget {
  final Color? backgroundColor;
  final Color? bodyBackgroundColor;
  final Color? rightBarBackgroundColor;
  final Color? appBarBackgroundColor;
  final Color? leftBarBackgroundColor;
  final Widget? appBar;
  final Widget? leftBar;
  final Widget? rightBar;
  final Widget? body;
  final bool? expandLeftBar;
  const Structure(
      {this.backgroundColor,
      this.body,
      this.leftBar,
      this.expandLeftBar,
      this.rightBar,
      this.appBar,
      this.bodyBackgroundColor,
      this.leftBarBackgroundColor,
      this.rightBarBackgroundColor,
      this.appBarBackgroundColor,
      Key? key})
      : super(key: key);

  getwidth (expanded, top, left, right, size) {
    if (left == false && right == false) {
      return size.width;
    } else if (left == false && right == true) {
      return (size.width * 0.6) + (size.width * 0.2);
    } else if (left == true && right == false) {
      return (expanded
          ? (size.width * 0.6) + (size.width * 0.2)
          : (size.width * 0.6) + (size.width * 0.15) + (size.width * 0.2));
    } else {
      return (expanded
          ? (size.width * 0.6)
          : (size.width * 0.6) + (size.width * 0.15));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool left = leftBar == null ? false : true;
    bool right = rightBar == null ? false : true;
    bool top = appBar == null ? false : true;
    var Size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: Size.height,
        width: Size.width,
        color: backgroundColor ?? Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _LeftBar(
              color: leftBarBackgroundColor,
              expanded: expandLeftBar == null ? true : expandLeftBar!,
              child: leftBar,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _AppBar(
                  expanded: expandLeftBar == null ? true : expandLeftBar!,
                  color: appBarBackgroundColor,
                  top: top,
                  left: left,
                  right: right,
                  getwidth : getwidth,
                  child: appBar,

                ),
                _Body(
                  expanded: expandLeftBar == null ? true : expandLeftBar!,
                  color: bodyBackgroundColor,
                  top: top,
                  left: left,
                  getwidth : getwidth,
                  right: right,
                  child: body,
                ),
              ],
            ),
            _RightBar(
              color: rightBarBackgroundColor,
              child: rightBar,
            )
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final Color? color;
  final Widget? child;
  bool left;
  bool right;
  bool top;
  dynamic getwidth;
  bool expanded;
  _AppBar(
      {this.color,
      this.child,
      this.getwidth,
      this.left = false,
      this.right = false,
      this.top = false,
      this.expanded = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          border: Border.all(
            width: 0,
            color: color ?? Colors.white,
          )),
      height: Size.height * 0.1,
      width:  getwidth(expanded, top, left, right, Size),
      child: child,
    );
  }
}

class _Body extends StatelessWidget {
  final Color? color;
  final Widget? child;
  bool left;
  bool right;
  bool top;
  bool expanded;
  dynamic getwidth;
  _Body(
      {this.color,
      this.child,
      this.expanded = true,
      this.left = false,
      this.right = false,
      this.top = false,
      this.getwidth,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          border: Border.all(
            width: 0,
            color: color ?? Colors.white,
          )),
      height: Size.height * 0.9,
      width: getwidth(expanded, top, left, right, Size),
      child: child,
    );
  }
}

class _LeftBar extends StatelessWidget {
  final Color? color;
  final Widget? child;
  bool expanded;
  _LeftBar({this.color, this.child, this.expanded = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: color ?? Colors.red,
          border: Border.all(
            width: 0,
            color: color ?? Colors.white,
          )),
      height: Size.height,
      width: child == null
          ? Size.width * 0
          : (expanded ? Size.width * 0.2 : Size.width * 0.05),
      child: child,
    );
  }
}

class _RightBar extends StatelessWidget {
  final Color? color;
  final Widget? child;
  const _RightBar({this.color, this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          border: Border.all(
            width: 0,
            color: color ?? Colors.white,
          )),
      height: Size.height,
      width: child == null ? Size.width * 0 : Size.width * 0.2,
      child: child,
    );
  }
}
