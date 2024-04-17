import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> with SingleTickerProviderStateMixin {
  Color baseColor = const Color.fromARGB(255, 0, 0, 0);
  Color secondColor = const Color.fromARGB(255, 2, 255, 44);
  double firstDepth = 50;
  double secondDepth = 50;
  double thirdDepth = 50;
  double fourthDepth = 50;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, duration: const Duration(seconds: 4), animationBehavior: AnimationBehavior.preserve,
      // the SingleTickerProviderStateMixin
    )..addListener(() {
        setState(() {});
      });

    _animationController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double stagger(double value, double progress, double delay) {
      var newProgress = progress - (1 - delay);
      if (newProgress < 0) newProgress = 0;
      return value * (newProgress / delay);
    }
    // three depth values are calculated using the stagger function

    double calculatedFirstDepth = firstDepth - stagger(firstDepth, _animationController.value, 0.3);
    double calculatedSecondDepth = secondDepth - stagger(secondDepth, _animationController.value, 0.6);
    double calculatedThirdDepth = thirdDepth - stagger(thirdDepth, _animationController.value, 0.9);
    return Scaffold(
        backgroundColor: baseColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Starting Screen',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 2, 255, 44),
            ),
          ),
        ),
        body: ClayTheme(
          themeData: const ClayThemeData(
            height: 10,
            width: 20,
            borderRadius: 360,
            textTheme: ClayTextTheme(style: TextStyle()),
            depth: 12,
          ),
          child: ColoredBox(
            color: baseColor,
            child: GestureDetector(
              onTap: () {
                //show snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Button Pressed',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    backgroundColor: secondColor,
                    showCloseIcon: true,
                    closeIconColor: Colors.black,
                    margin: const EdgeInsets.all(10),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Center(
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(94, 2, 255, 44),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: ClayContainer(
                      color: baseColor,
                      height: 240,
                      width: 240,
                      curveType: CurveType.concave,
                      spread: 30,
                      depth: calculatedFirstDepth.toInt(),
                      child: Center(
                        child: ClayContainer(
                          height: 200,
                          width: 200,
                          depth: calculatedSecondDepth.toInt(),
                          curveType: CurveType.concave,
                          color: baseColor,
                          child: Center(
                            child: ClayContainer(
                              height: 160,
                              width: 160,
                              color: baseColor,
                              depth: calculatedThirdDepth.toInt(),
                              curveType: CurveType.concave,
                              child: Center(
                                child: ClayContainer(
                                  height: 120,
                                  width: 120,
                                  color: secondColor,
                                  spread: 0,
                                  curveType: CurveType.convex,
                                  child: Center(
                                    child: Text(
                                      'Start',
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.06,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
