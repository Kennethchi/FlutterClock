import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import 'dart:math' as math;



class Star extends StatefulWidget {

  Size starSize;

  Star({this.starSize});

  @override
  _StarState createState() => _StarState();
}


class _StarState extends State<Star> with TickerProviderStateMixin<Star> {



  AnimationController _starTwinkleAnimationController;
  Animation<double> _starTwinkleAnimation;
  
  math.Random _randomObj = math.Random();

  bool disposedIsCalled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _starTwinkleAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000) );
    _starTwinkleAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _starTwinkleAnimationController,
        curve: Curves.linear
    ));



    Timer(Duration(seconds: _randomObj.nextInt(10)), (){

      if (disposedIsCalled == false){
        _starTwinkleAnimationController?.forward();
      }
    });


    _starTwinkleAnimationController.addStatusListener((AnimationStatus animationStatus)async{


      switch(animationStatus){
        case AnimationStatus.completed:
          Timer(Duration(seconds: _randomObj.nextInt(10)), (){
            if (disposedIsCalled == false){
              _starTwinkleAnimationController.reverse();
            }
          });

          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.dismissed:

          Timer(Duration(seconds: _randomObj.nextInt(10)), (){
            if (disposedIsCalled == false){
              _starTwinkleAnimationController.forward();
            }
          });
          break;
      }

    });



  }


  @override
  void dispose() {
    // TODO: implement dispose

    disposedIsCalled = true;

    _starTwinkleAnimationController.removeListener((){});
    _starTwinkleAnimationController.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _starTwinkleAnimationController,
      builder: (BuildContext buildContext, Widget child) => Transform.scale(
        scale: _starTwinkleAnimation.value,
        child: Container(
          child: CustomPaint(
            painter: _StarCustomPainter(),
            size: widget.starSize != null
                ? widget.starSize
                : Size(20.0, 20.0),
          ),
        ),
      ),
    );
  }
}



class _StarCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {

    Paint starPaint = Paint();
    starPaint.style = PaintingStyle.fill;
    starPaint.color = Colors.yellow.withOpacity(0.5);

    Path starPath = Path();
    starPath.moveTo(size.width / 2, 0.0);
    starPath.lineTo(0.0, size.height);
    starPath.lineTo(size.width, size.height * 0.33);
    starPath.lineTo(0.0, size.height * 0.33);
    starPath.lineTo(size.width, size.height);
    starPath.close();

    canvas.drawPath(starPath, starPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}





