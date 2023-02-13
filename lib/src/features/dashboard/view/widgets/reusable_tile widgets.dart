// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReusableTileWidget1 extends ConsumerWidget {
  const ReusableTileWidget1({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return ListTile(
      leading: const Text(
        'Your Notes',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      trailing: InkWell(
          child: GestureDetector(
        onTap: (() {}),
        child: Text(
          'Veiw all >',
          style: TextStyle(
              color: Colors.blue[500],
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
      )),
    );
  }
}

class ReusableTileWidget2 extends ConsumerWidget {
  const ReusableTileWidget2({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return ListTile(
      leading: const Text(
        'Your Assignments',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      trailing: InkWell(
          child: GestureDetector(
        // ignore: sort_child_properties_last
        child: Text(
          'Veiw all >',
          style: TextStyle(
              color: Colors.blue[500],
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
        onTap: (() {}),
      )),
    );
  }
}
