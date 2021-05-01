import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String textInput;
  final ValueChanged<String> onSaved;
  final bool isPassword;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldValidator<String> validator;
  final AutovalidateMode autovalidateMode;


  AppTextField({
    this.textInput, 
    this.onSaved, 
    this.isPassword: false, 
    this.controller, 
    this.focusNode, 
    this.validator,
    this.autovalidateMode: AutovalidateMode.onUserInteraction
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration( 
        contentPadding: EdgeInsets.symmetric( vertical: 10, horizontal: 20),
        hintText: textInput,
        border: OutlineInputBorder( 
          borderRadius: BorderRadius.all(Radius.circular(32))
        ),
        enabledBorder: OutlineInputBorder( 
          borderRadius: BorderRadius.all(Radius.circular(32)),
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2)
        ),
        focusedBorder: OutlineInputBorder( 
          borderRadius: BorderRadius.all(Radius.circular(32)),
          borderSide: BorderSide(color: Colors.blueAccent, width: 3)
        )
      ),
      onSaved: onSaved,
      textAlign: TextAlign.center,
      obscureText: isPassword,
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      autovalidateMode: autovalidateMode,
      //onSaved: ,
    );
  }
}