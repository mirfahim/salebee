import 'package:flutter/material.dart';
import 'package:salebee/Utils/my_colors.dart';

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
        child: widget.buttonState == true ? CircularProgressIndicator() : Text("${widget.buttonText}", style: TextStyle(color: Colors.white),),

      ),
    );
  }
}
