import 'package:flutter/material.dart';

class ReusableTileWidget extends StatelessWidget {
  const ReusableTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Text(
        'Your Notes',
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
