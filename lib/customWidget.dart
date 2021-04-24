import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final Function onBtnPressed;

  CustomButton({this.btnText, this.onBtnPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0f52ba),
                Color(0xFF4d4dff),
              ]),
          border: Border.all(width: 1.0, color: const Color(0xFFadcbe3)),
          borderRadius: BorderRadius.circular(15)),
      child: RawMaterialButton(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(300)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  btnText,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        onPressed: onBtnPressed,
      ),
    );
  }
}
