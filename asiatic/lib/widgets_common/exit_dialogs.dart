import 'package:asiatic/consts/consts.dart';
import 'package:asiatic/widgets_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .color(darkFontGrey)
            .size(16)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: redColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                textColor: whiteColor,
                title: "Yes"),
            ourButton(
                color: redColor,
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: whiteColor,
                title: "No"),
          ],
        ),
      ],
    ).box.color(lightGrey).roundedSM.padding(const EdgeInsets.all(16)).make(),
  );
}
