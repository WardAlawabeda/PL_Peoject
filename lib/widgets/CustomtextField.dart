import 'package:flutter/material.dart';

class Customformfield extends StatefulWidget {
  const Customformfield(
      {super.key,
      required this.hint,
      required this.iconname,
      required this.valid,
      required this.Textformfield,
      required this.globalKey,
      this.suff,
      required this.show});
  final String hint;
  final Icon iconname;
  final valid;
  final TextEditingController Textformfield;
  final GlobalKey<FormState> globalKey;
  final suff;
  final bool show;
  @override
  State<Customformfield> createState() => _CustomformfieldState();
}

class _CustomformfieldState extends State<Customformfield> {
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.globalKey,
        child: TextFormField(
            obscureText: widget.show,
            validator: widget.valid,
            controller: widget.Textformfield,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.pink[50],
              hintText: widget.hint,
              hintStyle: const TextStyle(
                  fontFamily: "PTSerif-Regular",
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              prefixIcon: widget.iconname,
              suffix: widget.suff,
            )));
  }
}