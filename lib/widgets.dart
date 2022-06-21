import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget DropDownMenu<T>(String? value,String hint, List<DropdownMenuItem<String>> items,Function(String?) onChanged) {
  return InputDecorator(
    decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0))),
    child: DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        hint: Text(hint),
        value: value,
        isDense: true,
        onChanged: onChanged,
        onSaved: onChanged,
        items: items,
      ),
    ),
  );
}