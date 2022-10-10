import 'package:flutter/cupertino.dart';

class PagePadding extends EdgeInsets{
  const PagePadding.low() : super.all(10);
  const PagePadding.lowPlusAll() : super.all(20);
  const PagePadding.normalAll() : super.all(30);
  const PagePadding.highAll() : super.all(40);
}