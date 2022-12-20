import 'package:flutter/material.dart';

class InputDateTime extends StatefulWidget {
  InputDateTime({Key? key, this.label, this.onPressed, this.icon})
      : super(key: key);
  var label;
  var onPressed;
  var icon;

  @override
  State<InputDateTime> createState() => _InputDateTimeState();
}

class _InputDateTimeState extends State<InputDateTime> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        children: [
          Icon(widget.icon, color: Colors.black45),
          Padding(padding: EdgeInsets.only(right: 10.0)),
          Expanded(
              child: Text(widget.label,
                  style: const TextStyle(color: Colors.black45))),
        ],
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: const Size.fromHeight(60),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black45, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: widget.onPressed,
    );
  }
}
