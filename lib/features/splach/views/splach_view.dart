import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/helpers/get_country_code.dart';
import 'package:movies/core/services/shared_preferences_singleton.dart';
import 'package:movies/core/utils/app_key.dart';
import 'package:movies/features/movies/views/main_view.dart';

class SplachView extends StatefulWidget {
  const SplachView({super.key});

  @override
  State<SplachView> createState() => _SplachViewState();
}

class _SplachViewState extends State<SplachView> {
  late String contry;
  @override
  void initState() {
    super.initState();
    getCountryCode().then((code) {
      setState(() {
        contry = code;
      });
      Prefs.setString(AppKey.countryKey, contry);
      debugPrint("Detected Country Code: $contry");
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black, // يفضل الخلفية سوداء لتناسب تطبيقات الأفلام
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/splachLottie.json',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 20),
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Padding(
                    padding: EdgeInsets.only(top: (1 - value) * 20),
                    child: child,
                  ),
                );
              },
              child: const Text(
                'MOVIE',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 5, // مسافات بين الحروف لتعطي لمسة سينمائية
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
