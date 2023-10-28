part of dog_app_utils;

//Adapt widgets to different screens
class Adapt {
  static late MediaQueryData mediaQuery;
  static double? _width;
  static double? _height;
  static num? _ratio;

  static void initContext(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    _width = mediaQuery.size.width;
    _height = mediaQuery.size.height;
  }

  static void init(int number) {
    final uiwidth = number;
    _ratio = _width! / uiwidth;
  }

  static double screenW() {
    return _width!;
  }

  static double screenH() {
    return _height!;
  }

  static double px(num number) {
    if (!(_ratio is double || _ratio is int)) {
      Adapt.init(750);
    }
    return (number * _ratio!).toDouble();
  }
}
