// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:asiatic/consts/consts.dart';
import 'package:asiatic/controller/profile_controller.dart';
import 'package:asiatic/widgets_common/bg_widget.dart';
import 'package:asiatic/widgets_common/custom_textfield.dart';
import 'package:asiatic/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if data image and controller path is empty
              data['imageUrl'] == '' && controller.profileImagePath.isEmpty
                  ? Image.asset(imgProfile2, width: 80, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
          
                  //if data is not empty but controller path is empty
                  : data['imageUrl'] != '' && controller.profileImagePath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
          
                      //if controller path not empty but data image url is
                      : Image.file(
                          File(controller.profileImagePath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: uiGrey,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              const Divider(),
              20.heightBox,
              customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false),
              10.heightBox,
              customTextField(
                  controller: controller.oldPassController,
                  hint: passwordHint,
                  title: oldPass,
                  isPass: true),
              10.heightBox,
              customTextField(
                  controller: controller.newPassController,
                  hint: passwordHint,
                  title: newPass,
                  isPass: true),
              20.heightBox,
              controller.isloading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                          color: uiGrey,
                          onPress: () async {
                            controller.isloading(true);
          
                            //if image is not selected
                            if (controller.profileImagePath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }
          
                            //if old pass matches
          
                            if (data['password'] ==
                                controller.oldPassController.text) {
                              await controller.changeAuthPassword(
                                  email: data['email'],
                                  password: controller.oldPassController.text,
                                  newpassword: controller.newPassController.text);
          
                              await controller.updateProfile(
                                  imgUrl: controller.profileImageLink,
                                  name: controller.nameController.text,
                                  password: controller.newPassController.text);
                              VxToast.show(context, msg: "Updated");
                            } else {
                              VxToast.show(context, msg: "Wrong old password");
                              controller.isloading(false);
                            }
                          },
                          textColor: whiteColor,
                          title: "Save"),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}
