import 'package:asiatic/consts/consts.dart';
import 'package:asiatic/controller/auth_controller.dart';
import 'package:asiatic/views/auth_screen/signup_screen.dart';
import 'package:asiatic/views/home_screen/home.dart';
import 'package:asiatic/widgets_common/applogo_widget.dart';
import 'package:asiatic/widgets_common/bg_widget.dart';
import 'package:asiatic/widgets_common/custom_textfield.dart';
import 'package:asiatic/widgets_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Authcontroller());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            45.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      hint: emailHint,
                      title: email,
                      isPass: false,
                      controller: controller.emailController),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      isPass: true,
                      controller: controller.passwordController),
                  TextButton(
                      onPressed: () {},
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: forgotPass.text.make())),
                  5.heightBox,
                  controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                          color: uiGrey,
                          title: login,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isLoading(true);
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loggedIn);
                                Get.offAll(() => const Home());
                              } else {
                                controller.isLoading(false);
                              }
                            });
                          },
                        ).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(
                      color: lightGolden,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () {
                        Get.to(() => const SignupScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
