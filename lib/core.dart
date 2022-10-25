// ignore_for_file: non_constant_identifier_names, unused_element

import 'package:flutter/material.dart';

class AppStructure extends StatelessWidget {
  final Color? backgroundColor;
  final Color? bodyBackgroundColor;
  final Color? rightBarBackgroundColor;
  final Color? appBarBackgroundColor;
  final Color? leftBarBackgroundColor;
  final Widget? appBar;
  final Widget? leftBar;
  final Widget? rightBar;
  final Widget? body;
  const AppStructure(
      {this.backgroundColor,
      this.body,
      this.leftBar,
      this.rightBar,
      this.appBar,
      this.bodyBackgroundColor,
      this.leftBarBackgroundColor,
      this.rightBarBackgroundColor,
      this.appBarBackgroundColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: leftBar,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _AppBar(
                  color: appBarBackgroundColor,
                  child: appBar,
                ),
                _Body(
                  color: bodyBackgroundColor,
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
  const _AppBar({this.color, this.child, Key? key}) : super(key: key);

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
      width: (Size.width * 0.6),
      child: child,
    );
  }
}

class _Body extends StatelessWidget {
  final Color? color;
  final Widget? child;
  const _Body({this.color, this.child, Key? key}) : super(key: key);

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
      width: (Size.width * 0.6),
      child: child,
    );
  }
}

class _LeftBar extends StatelessWidget {
  final Color? color;
  final Widget? child;
  const _LeftBar({this.color, this.child, Key? key}) : super(key: key);

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
      width: Size.width * 0.2,
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
      width: Size.width * 0.2,
      child: child,
    );
  }
}
