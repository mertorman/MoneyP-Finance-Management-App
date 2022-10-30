
import 'package:moneyp/feature/home/view/homepage_view.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

import 'package:flutter/material.dart';
class ListItemModel  {

  static final List<ListItem> models = [


    ListItem(
        expenseTitle: "Titldssdsdsaasdde 1",
        expenseDescription: "Description 1",
        expenseTotal: "100",
        expenseIcon: Icon(
          Icons.abc_outlined,
          color: Colors.black,
        )),
    ListItem(
        expenseTitle: "Title 2",
        expenseDescription: "Description 2",
        expenseTotal: "100",
        expenseIcon: Icon(
          Icons.abc_outlined,
          color: Colors.black,
        )),
    ListItem(
        expenseTitle: "Title 3",
        expenseDescription: "Description 3",
        expenseTotal: "100",
        expenseIcon: Icon(
          Icons.abc_outlined,
          color: Colors.black,
        )),


  ];
}