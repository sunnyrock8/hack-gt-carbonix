import 'package:carbonix/pages/navigator/navigator.screen.dart';
import 'package:carbonix/pages/onboarding/signup.screen.dart';
import 'package:carbonix/provider/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  late AnimationController rippleController;
  late AnimationController scaleController;
  late Animation<double> rippleAnimation;
  late Animation<double> scaleAnimation;

  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  void initState() {
    super.initState();
    rippleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          scaleController.reverse();
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: const SignupScreen()));
        }
      });
    rippleAnimation =
        Tween<double>(begin: 80.0, end: 82.0).animate(rippleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rippleController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              rippleController.forward();
            }
          });
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(scaleController);

    rippleController.forward();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      String? uid = await _authenticationService.getUid();
      print(uid);

      if (uid != null)
        Navigator.pushReplacement(context,
            MaterialWithModalsPageRoute(builder: (_) => NavigatorScreen()));
    });
  }

  @override
  void dispose() {
    rippleController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(0)),
              color: Colors.black,
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                const Positioned(
                  left: 50,
                  top: 100,
                  child: Text(
                    "Reduce",
                    style: TextStyle(
                        color: Color(0xFFC4DC34),
                        fontSize: 38,
                        fontFamily: 'Nohemi',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Positioned(
                  left: 195,
                  top: 100,
                  child: Text(
                    "your",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontFamily: 'Nohemi',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Positioned(
                  left: 50,
                  top: 145,
                  child: Text(
                    "carbon",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontFamily: 'Nohemi',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Positioned(
                  left: 50,
                  top: 190,
                  child: Text(
                    "footprint",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontFamily: 'Nohemi',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: -90,
                  child: Image.asset("images/earth.png",
                      height: 320, opacity: const AlwaysStoppedAnimation(0.6)),
                ),
                const Positioned(
                  left: 50,
                  top: 290,
                  child: Text(
                    "and get",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontFamily: 'Nohemi',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Positioned(
                  left: 50,
                  top: 335,
                  child: Text(
                    "Rewarded",
                    style: TextStyle(
                        color: Color(0xFFC4DC34),
                        fontSize: 38,
                        fontFamily: 'Nohemi',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Positioned(
                  left: 50,
                  top: 380,
                  child: Text(
                    "for saving",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontFamily: 'Nohemi',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Positioned(
                  left: 50,
                  top: 425,
                  child: Text(
                    "our planet",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontFamily: 'Nohemi',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                  bottom: 130,
                  left: 50,
                  child: GestureDetector(
                    onTap: () {},
                    child: AnimatedBuilder(
                      animation: rippleAnimation,
                      builder: (context, child) => Container(
                        width: rippleAnimation.value,
                        height: rippleAnimation.value,
                        child: GestureDetector(
                          onTap: () {
                            scaleController.forward();
                          },
                          child: AnimatedBuilder(
                            animation: scaleAnimation,
                            builder: (context, child) => Transform.scale(
                              scale: scaleAnimation.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 85),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedBuilder(
                        animation: rippleAnimation,
                        builder: (context, child) {
                          final value = rippleAnimation.value - 4;
                          return Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.identity()
                              ..scale(value / 50, value / 50),
                            child: SizedBox(
                              width: value - 10,
                              height: value - 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF00E078).withOpacity(0.4),
                                      const Color(0xFF00DCF5).withOpacity(0.4),
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 0.0),
                                    stops: const [0.0, 1.0],
                                    tileMode: TileMode.clamp,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    scaleController.forward();
                                  },
                                  child: AnimatedBuilder(
                                    animation: scaleAnimation,
                                    builder: (context, child) =>
                                        Transform.scale(
                                      scale: scaleAnimation.value,
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        foregroundDecoration:
                                            const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF00DCF5),
                                              Color(0xFF00E078),
                                            ],
                                            begin: FractionalOffset(0.0, 0.0),
                                            end: FractionalOffset(1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      scaleController.forward();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 102),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 37,
                          width: 37,
                          child: SvgPicture.asset(
                            "images/white_icon.svg",
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
