import 'package:flutter/material.dart';
List<DropdownMenuItem<int>> dersKrediItems() {
  List<DropdownMenuItem<int>> krediler = [];
  for (int i = 1; i <= 10; i++) {
    // var aa=  DropdownMenuItem<int>( value:i,child:Text("$i Kredi"),);krediler.add(aa);
    krediler.add(DropdownMenuItem<int>(
      value: i,
      child: Text(
        "$i Kredi",
        style: TextStyle(fontSize: 20),
      ),
    ));
  }

  return krediler;
}