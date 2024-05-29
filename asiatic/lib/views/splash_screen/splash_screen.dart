import 'package:asiatic/consts/consts.dart';
import 'package:asiatic/views/auth_screen/login_screen.dart';
import 'package:asiatic/views/home_screen/home.dart';
import 'package:asiatic/widgets_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(()=>const LoginScreen());

      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uiGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: applogoWidget()),
        ],
      ),
    );
  }
}
