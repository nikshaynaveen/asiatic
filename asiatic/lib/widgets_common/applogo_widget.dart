import 'package:asiatic/consts/consts.dart';

Widget applogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .color(uiGrey)
      .size(200, 200)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
