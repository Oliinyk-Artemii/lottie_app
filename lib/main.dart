import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        bottomAppBarColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _fireworksIconController;
  AnimationController _fireworksController;
  AnimationController _yearIconController;
  AnimationController _yearController;
  bool isFireworksPlaying = false;
  bool isYearPlaying = false;

  @override
  void initState() {
    super.initState();
    _fireworksIconController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _fireworksController = AnimationController(vsync: this);
    _yearIconController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _yearController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _fireworksController.dispose();
    _fireworksIconController.dispose();
    _yearIconController.dispose();
    _yearController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.mainBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Constants.mainBackgroundColor,
        items: [
          BottomNavigationBarItem(
            label: 'fireworks',
            icon: IconButton(
              iconSize: 30,
              splashColor: Colors.transparent,
              icon: AnimatedIcon(
                icon: AnimatedIcons.pause_play,
                progress: _fireworksIconController,
              ),
              onPressed: () => _playFireworks(),
            ),
          ),
          BottomNavigationBarItem(
            label: 'year',
            icon: IconButton(
              // color: Colors.white,
              iconSize: 30,
              splashColor: Colors.transparent,
              icon: AnimatedIcon(
                icon: AnimatedIcons.pause_play,
                progress: _yearIconController,
              ),
              onPressed: () => _playYear(),
            ),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Lottie.asset('assets/animations/new_year.json',
                  controller: _yearController,
                  repeat: true, onLoaded: (composition) {
                _yearController..duration = composition.duration;
              }),
            ),
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Lottie.asset('assets/animations/fireworks.json',
                  controller: _fireworksController,
                  repeat: true, onLoaded: (composition) {
                _fireworksController..duration = composition.duration;
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _playYear() {
    setState(() {
      isYearPlaying = !isYearPlaying;
      if (isYearPlaying) {
        _yearIconController.forward();
        _yearController.stop();
      } else {
        _yearIconController.reverse();
        _yearController.forward();
        _yearController.repeat();
      }
    });
  }

  void _playFireworks() {
    setState(() {
      isFireworksPlaying = !isFireworksPlaying;
      if (isFireworksPlaying) {
        _fireworksIconController.forward();
        _fireworksController.stop();
      } else {
        _fireworksIconController.reverse();
        _fireworksController.forward();
        _fireworksController.repeat();
      }
    });
  }
}
