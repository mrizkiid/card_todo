import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// class InitSizing {
//   InitSizing._internal();

//   double? _screenHeight;
//   double? _screenWidth;

//   static InitSizing? _instance;

//   get screenHeight => _screenHeight!;
//   get screenWidth => _screenWidth!;

//   void init(BuildContext context) {
//     _screenHeight = MediaQuery.of(context).size.height;
//     _screenWidth = MediaQuery.of(context).size.width;
//   }

//   factory InitSizing() {
//     _instance ??= InitSizing._internal();
//     return _instance!;
//   }
// }

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
