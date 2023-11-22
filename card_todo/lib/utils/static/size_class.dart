import 'package:flutter/material.dart';

enum Screentype { potrait, landscape }

class Sizing {
  Sizing();

  double? _screenHeight;
  double? _screenWidth;
  MediaQueryData? _mediaQuery;

  get screenHeight => _screenHeight!;
  get screenWidth => _screenWidth!;
  get mediaQuery => _mediaQuery!;

  void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    _screenHeight = _mediaQuery!.size.height;
    _screenWidth = _mediaQuery!.size.width;
  }

  double heightCalc({required double percent, double? min, double? max}) {
    double sizeParent = _screenHeight!;
    double result = sizeParent * percent / 100;
    if (min != null && result <= min) {
      return min;
    }
    if (max != null && result >= max) {
      return max;
    }
    return result;
  }

  double widthCalc({required double percent, double? min, double? max}) {
    double sizeParent = _screenWidth!;
    double result = sizeParent * percent / 100;
    if (min != null && result <= min) {
      return min;
    }
    if (max != null && result >= max) {
      return max;
    }
    return result;
  }

  double sizeInCont(
      {required double sizeParent,
      required double percent,
      double? min,
      double? max}) {
    double result = sizeParent * percent / 100;
    if (min != null && result <= min) {
      return min;
    }
    if (max != null && result >= max) {
      return max;
    }
    return result;
  }

  bool get isPotrait {
    Orientation result = _mediaQuery!.orientation;
    if (result == Orientation.portrait) {
      return true;
    }
    return false;
  }
}
