import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget { 
  final String btnText;
  final Function onBtnPressed;
  CustomButton({this.btnText,this.onBtnPressed});
  
  
  @override


  Widget build(BuildContext context) {
    return MaterialButton(child: Padding(padding: const EdgeInsets.all(18.0),child: 
    Row(mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget> [
      Text('login',style:Theme.of(context).textTheme.bodyText1,),
      SizedBox(width: 10,),
      Icon(Icons.arrow_forward)


    ],)
    
    
    
    ,),
    onPressed:onBtnPressed,
    color: Theme.of(context).primaryColor,
    
    );

  }
}