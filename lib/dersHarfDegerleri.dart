import 'package:flutter/material.dart';
List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
  List<DropdownMenuItem<double>> harfler = [];
  harfler.add(DropdownMenuItem(
    child: Text(
      "AA",
      style: TextStyle(fontSize: 20),
    ),
    value: 4,
  ));
  harfler.add(DropdownMenuItem(
    child: Text(
      "BA",
      style: TextStyle(fontSize: 20),
    ),
    value: 3.5,
  ));
  harfler.add(DropdownMenuItem(
    child: Text(
      "BB",
      style: TextStyle(fontSize: 20),
    ),
    value: 3,
  ));
  harfler.add(DropdownMenuItem(
    child: Text(
      "CB",
      style: TextStyle(fontSize: 20),
    ),
    value: 2.5,
  ));
  harfler.add(DropdownMenuItem(
    child: Text(
      "CC",
      style: TextStyle(fontSize: 20),
    ),
    value: 2,
  ));
  harfler.add(DropdownMenuItem(
    child: Text(
      "DC",
      style: TextStyle(fontSize: 20),
    ),
    value: 1.5,
  ));
  harfler.add(DropdownMenuItem(
    child: Text(
      "DD",
      style: TextStyle(fontSize: 20),
    ),
    value: 1,
  ));
  harfler.add(DropdownMenuItem(
    child: Text(
      "FF",
      style: TextStyle(fontSize: 20),
    ),
    value: 0,
  ));

  return harfler;
}