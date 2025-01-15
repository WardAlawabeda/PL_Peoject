import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final GlobalKey<FormState>? globalKey;
  final String hint;
  final bool show;
  final Widget iconname;
  final String? Function(String?) valid;
  final TextEditingController Textformfield;

  const CustomFormField({
    required this.globalKey,
    required this.hint,
    required this.show,
    required this.iconname,
    required this.valid,
    required this.Textformfield,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: TextFormField(
        controller: Textformfield,
        obscureText: show,
        validator: valid,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: iconname,
        ),
      ),
    );
  }
}