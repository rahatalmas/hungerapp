import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget{
  const CustomInput({
    super.key,
    required this.textEditor,
    required this.obscure,
    required this.hint,
    required this.label,
    required this.validatorTxt
    });

  final TextEditingController textEditor;
  final bool obscure;
  final String? hint;
  final String label;
  final String validatorTxt;

  @override  
  Widget build(BuildContext context){
    return TextFormField(
                    decoration: InputDecoration(
                      labelText: label,        
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.brown,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.brown,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.red,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedErrorBorder:const  OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.brown,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    controller: textEditor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return validatorTxt;
                      }
                      return null;
                    },
                  )
                  ;
  }
}