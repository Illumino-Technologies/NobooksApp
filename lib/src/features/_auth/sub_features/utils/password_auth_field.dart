import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class PasswordAuthField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const PasswordAuthField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<PasswordAuthField> createState() => _PasswordAuthFieldState();
}

class _PasswordAuthFieldState extends State<PasswordAuthField> {
  bool visible = false;

  void toggleVisibility() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      style: TextStyles.paragraph2.copyWith(
        fontSize: 16.spMax,
        height: 1.5,
      ),
      obscureText: !visible,
      decoration: Ui.authFieldDecoration('Password').copyWith(
        suffixIcon: IconButton(
          onPressed: toggleVisibility,
          icon: SvgPicture.asset(
            visible ? VectorAssets.quillEyeClosed : VectorAssets.quillEye,
            width: 24.w,
            height: 24.h,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.l,
          vertical: 12.l,
        ),
      ),
    );
  }
}
