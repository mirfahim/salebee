import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  String? buttonText;
  bool? buttonState ;


   CustomButton({this.buttonText, this.buttonState});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: widget.buttonState == true ? const CircularProgressIndicator() : Text("${widget.buttonText}", style: const TextStyle(color: Colors.white),),

      ),
    );
  }
}
