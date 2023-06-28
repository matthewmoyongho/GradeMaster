import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int onBoardingIndex = 0;

  late PageController _pageController;
  Color primaryColor = Colors.blue[900]!;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: kOnBoardingContents.length,
        onPageChanged: (index) {
          setState(() {
            onBoardingIndex = index;
          });
        },
        itemBuilder: (context, index) => Container(
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      onBoardingIndex > 0
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _pageController.previousPage(
                                      duration: Duration(milliseconds: 100),
                                      curve: Curves.bounceIn);
                                });
                              },
                              icon: Icon(Icons.arrow_back))
                          : Expanded(child: SizedBox()),
                      TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              side: BorderSide(color: primaryColor, width: 2)),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('showHome', true);
                            Navigator.of(context)
                                .pushReplacementNamed(kSignUpScreenRoute);
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                                height: 1.5,
                                fontStyle: FontStyle.italic),
                          )),
                    ],
                  ),
                  Image(
                    image: AssetImage(
                      kOnBoardingContents[onBoardingIndex]['picture'],
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * .05,
                  ),
                  Text(
                    kOnBoardingContents[onBoardingIndex]['title'],
                    style: TextStyle(
                        fontSize: 30,
                        color: primaryColor,
                        height: 1.5,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: deviceSize.height * .02,
                  ),
                  Text(
                    kOnBoardingContents[onBoardingIndex]['body'],
                    style: TextStyle(
                      fontSize: 18,
                      color: primaryColor,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: deviceSize.height * .05,
                  ),
                  buildDots(context),
                  SizedBox(
                    height: deviceSize.height * .05,
                  ),
                  ElevatedButton(
                    onPressed: onBoardingIndex + 1 < kOnBoardingContents.length
                        ? () => setState(() {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.bounceIn);
                            })
                        : () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('showHome', true);
                            Navigator.of(context)
                                .pushReplacementNamed(kSignUpScreenRoute);
                          },
                    child: Text(
                      onBoardingIndex + 1 == kOnBoardingContents.length
                          ? 'Continue'
                          : 'Next',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        fixedSize:
                            Size(deviceSize.width, deviceSize.height * 0.07)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDots(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        kOnBoardingContents.length,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color:
                    index == onBoardingIndex ? primaryColor : Colors.blueGrey,
                borderRadius: BorderRadius.circular(100)),
            height: 10,
            width: index == onBoardingIndex ? 15 : 10,
          ),
        ),
      ),
    );
  }
}
