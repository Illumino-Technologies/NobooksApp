// import 'package:flutter/material.dart';
//
// typedef ValueListenableSelectorCallback<T> = bool Function(T);
//
// class ValueListenableSelector<T> extends StatefulWidget {
//   final ValueNotifier<T> listenable;
//   final ValueListenableSelectorCallback<T> selector;
//
//   const ValueListenableSelector({
//     required this.listenable,
//     required this.selector,
//     Key? key,
//   }) : super(key:key);
//
//   @override
//   State<ValueListenableSelector<T>> createState() =>
//       _ValueListenableSelectorState<V, T>();
// }
//
// class _ValueListenableSelectorState<V, T>
//     extends State<ValueListenableSelector<V, T>> {
//   late T value = widget.listenable.value;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       widget.listenable.addListener(listenableChangeCallback);
//     });
//   }
//
//   @override
//   void dispose() {
//     widget.listenable.removeListener(listenableChangeCallback);
//     super.dispose();
//   }
//
//   void listenableChangeCallback() {}
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
