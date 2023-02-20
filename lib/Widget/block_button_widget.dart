import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget(
      {Key? key,
        this.color,
        this.borderColor,
        this.text,
        this.width,
        this.isBlur = true,
        this.radius,
        this.hasBorder = false,
        this.onPressed})
      : super(key: key);

  final Color? color;
  final Color? borderColor;
  final Widget? text;
  final double? radius;
  final double? width;
  final bool? isBlur;
  final bool? hasBorder;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: width ?? size.width,
      decoration: onPressed != null && isBlur == true
          ? BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: color!.withOpacity(0.3),
              blurRadius: 40,
              offset: const Offset(0, 15)),
          BoxShadow(
              color: color!.withOpacity(0.2),
              blurRadius: 13,
              offset: const Offset(0, 3))
        ],
        // borderRadius: BorderRadius.all(Radius.circular(20)),
      )
          : hasBorder == true
          ? BoxDecoration(
        border: Border.all(
          width: 1,
          color: borderColor ?? Get.theme.disabledColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 30)),
      )
          : null,
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        color: color,
        disabledElevation: 0,
        disabledColor: Get.theme.focusColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 30),
        ),
        elevation: 0,
        child: text,
      ),
    );
  }
}
