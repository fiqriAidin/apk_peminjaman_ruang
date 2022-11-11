import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  InputForm(
      {Key? key,
      this.label,
      this.hint,
      this.controller,
      this.maxLines,
      this.onChenged})
      : super(key: key);
  var label;
  var hint;
  var controller;
  var maxLines;
  var onChenged;

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChenged,
      controller: widget.controller,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );
  }
}
