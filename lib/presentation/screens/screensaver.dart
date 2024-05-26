import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/presentation/screens/registration.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';

class ScreenSaver extends StatefulWidget {
  const ScreenSaver({Key? key}) : super(key: key);

  @override
  _ScreenSaverState createState() => _ScreenSaverState();
}

class _ScreenSaverState extends State<ScreenSaver> with TickerProviderStateMixin {
  late AnimationController _rickAndMortyController;
  late AnimationController _rickController;
  late AnimationController _mortyController;
  late AnimationController _labelController;

  late Animation<Offset> _rickAnimation;
  late Animation<Offset> _mortyAnimation;
  late Animation<double> _opacityAnimation;

  late bool _isImagesVisible;
  double _imageOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _rickAndMortyController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _rickController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _mortyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500), // Увеличиваем задержку для второго рисунка
    );

    _labelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _rickAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _labelController,
      curve: Curves.easeInOut,
    ));

    _mortyAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _labelController,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_rickAndMortyController);

    _isImagesVisible = true;

    Future.delayed(const Duration(milliseconds: 1500), () {
      _rickController.forward();
      _mortyController.forward();

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isImagesVisible = false;
        });
        _rickController.reverse();
        _mortyController.reverse();
        Future.delayed(const Duration(seconds: 1), () {
          _labelController.forward();
        });
        Future.delayed(const Duration(seconds: 3), () {
          _rickAndMortyController.forward();
        });
      });
    });

    Future.delayed(const Duration(seconds: 6), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Auth()),
      );
    });
  }

  @override
  void dispose() {
    _rickController.dispose();
    _mortyController.dispose();
    _labelController.dispose();
    _rickAndMortyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: AnimatedBuilder(
                animation: _opacityAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: Image.asset(
                      "assets/pngs/rickAndMorty.png",
                      width: 380,
                      height: 300,
                    ),
                  );
                },
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _rickAnimation,
                    child: AnimatedOpacity(
                      opacity: _isImagesVisible ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 2000),
                      child: Image.asset(
                        "assets/pngs/rick_and_morty.png",
                        width: 250,
                        height: 350,
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _rickAnimation,
                    child: AnimatedOpacity(
                      opacity: _imageOpacity,
                      duration: const Duration(milliseconds: 2000),
                      child: Image.asset(
                        "assets/pngs/rick.png",
                        width: 300,
                        height: 200,
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _mortyAnimation,
                    child: AnimatedOpacity(
                      opacity: _imageOpacity,
                      duration: const Duration(milliseconds: 2000),
                      child: Image.asset(
                        "assets/pngs/morty.png",
                        width: 300,
                        height: 220,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
