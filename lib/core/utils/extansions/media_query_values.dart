import 'package:flutter/widgets.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  double get toPadding => MediaQuery.viewPaddingOf(this).top;
  double get bottom => MediaQuery.viewInsetsOf(this).bottom;
}