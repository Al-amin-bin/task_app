import 'package:flutter/material.dart';

InputDecoration AppInputDecoration(lable){
  return InputDecoration(

    border: OutlineInputBorder(borderSide: BorderSide(width: 50, style: BorderStyle.solid),
    borderRadius: BorderRadius.all(Radius.circular(13))),
    labelText: lable,

  );
}
