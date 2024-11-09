import 'package:flutter/material.dart';
import 'package:info_space_app/feature/home/view/home_page.dart';
import 'package:info_space_app/feature/splash/controller/splash_controller.dart';
import 'package:info_space_app/feature/splash/controller/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashView(
      splashController: SplashController(),
    );
  }
}

class SplashView extends StatefulWidget {
  const SplashView({
    super.key,
    required SplashController splashController,
  }) : _splashController = splashController;

  final SplashController _splashController;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._splashController.init();
    });
  }

  @override
  void dispose() {
    widget._splashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget._splashController;

    return Scaffold(
      body: Center(
        child: ValueListenableBuilder<SplashState>(
          valueListenable: controller,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'info SPACE',
                style: TextStyle(
                  fontSize: 32,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const CircularProgressIndicator(),
            ],
          ),
          builder: (context, state, child) {
            if (state == SplashState.done) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const HomePage(),
                  ),
                );
              });
            }
            return child ?? const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
