import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;


class ThunderstormEffect extends StatefulWidget {

  double width;
  double height;

  ThunderstormEffect({this.width = 100.0, this.height = 300.0});

  @override
  _ThunderstormEffectState createState() => _ThunderstormEffectState();
}

class _ThunderstormEffectState extends State<ThunderstormEffect> with TickerProviderStateMixin<ThunderstormEffect> {



  AnimationController _lighteningAnimationController;
  Animation<double> _lighteningAnimation;

  math.Random _randomObj = math.Random();

  bool disposedIsCalled = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _lighteningAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100) );
    _lighteningAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _lighteningAnimationController,
        curve: Curves.elasticOut
    ));

    Timer(Duration(seconds: _randomObj.nextInt(2)), (){

      if (disposedIsCalled == false){
        _lighteningAnimationController?.forward();
      }
    });


    _lighteningAnimationController.addStatusListener((AnimationStatus animationStatus)async{


      switch(animationStatus){
        case AnimationStatus.completed:
          Timer(Duration(seconds: _randomObj.nextInt(2)), (){
            if (disposedIsCalled == false){
              _lighteningAnimationController.reverse();
            }
          });

          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.dismissed:

          Timer(Duration(seconds: _randomObj.nextInt(2)), (){
            if (disposedIsCalled == false){
              _lighteningAnimationController.forward();
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

    _lighteningAnimationController.removeListener((){});
    _lighteningAnimationController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _lighteningAnimationController,
      builder: (BuildContext buildContext, Widget child) => Transform.scale(
        scale: _lighteningAnimation.value,
        child: Container(
          color: Colors.transparent,
          child: CustomPaint(
              painter: _ThunderStormCustomPainter(),
              size: Size(widget.width, widget.height)
          ),
        ),
      ),
    );

  }
}





class _ThunderStormCustomPainter extends CustomPainter{


  @override
  void paint(Canvas canvas, Size size) {


    math.Random random = math.Random();

    Paint thunderPaint = Paint();
    thunderPaint.style = PaintingStyle.stroke;
    thunderPaint.strokeWidth = 2.0;
    thunderPaint.color = Colors.blue.shade50;
    thunderPaint.imageFilter = ImageFilter.blur(sigmaX: 0.75, sigmaY: 0.75);
    Path thunderPath = Path();
    thunderPath.moveTo(size.width / 2, 0.0);


    Paint thunderBranchPaint = Paint();
    thunderBranchPaint.style = PaintingStyle.stroke;
    thunderBranchPaint.strokeWidth = 0.25;
    thunderBranchPaint.color = Colors.blue.shade50;
    Path thunderBranchPath = Path();



    thunderPath.lineTo((size.width / 2) - 15.0, (0.05 * size.height));
    thunderPath.lineTo((size.width / 2) - 20.0, (0.15 * size.height));
    thunderPath.lineTo((size.width / 2) - 24.0, (0.175 * size.height));
    thunderPath.lineTo((size.width / 2) - 10, (0.2 * size.height));
    thunderPath.lineTo((size.width / 2) - 15, (0.25 * size.height));


    thunderBranchPath.moveTo((size.width / 2) - 15, (0.25 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 40, (0.25 * size.height) - 15);
    thunderBranchPath.lineTo((size.width / 2) - 70, (0.25 * size.height) + 15);
    thunderBranchPath.lineTo((size.width / 2) - 90, (0.25 * size.height) + 12);



    thunderPath.lineTo((size.width / 2) - 10, (0.285 * size.height));
    thunderPath.lineTo((size.width / 2) - 20, (0.35 * size.height));
    thunderPath.lineTo((size.width / 2) - 10, (0.5 * size.height));

    thunderBranchPath.moveTo((size.width / 2) - 15, (0.38 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 30, (0.43 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 40, (0.45 * size.height) - 10);
    thunderBranchPath.lineTo((size.width / 2) - 80, (0.45 * size.height) + 10);
    thunderBranchPath.lineTo((size.width / 2) - 100, (0.45 * size.height) + 10);

    thunderBranchPath.moveTo((size.width / 2) - 15, (0.45 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 20, (0.50 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 30, (0.50 * size.height) + 10);
    thunderBranchPath.lineTo((size.width / 2) - 40, (0.50 * size.height) + 35);
    thunderBranchPath.lineTo((size.width / 2) - 50, (0.50 * size.height) + 40);


    thunderBranchPath.moveTo((size.width / 2) + 10, (0.58 * size.height));
    thunderBranchPath.lineTo((size.width / 2) + 25, (0.62 * size.height));
    thunderBranchPath.lineTo((size.width / 2) + 50, (0.64 * size.height));
    thunderBranchPath.lineTo((size.width / 2) + 65, (0.68 * size.height));



    thunderBranchPath.moveTo((size.width / 2) - 20, (0.8 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 35, (0.8 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 50, (0.83 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 60, (0.83 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 70, (0.88 * size.height));


    thunderBranchPath.moveTo((size.width / 2) - 20, (0.8 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 35, (0.875 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 55, (0.92 * size.height));


    thunderBranchPath.moveTo((size.width / 2) - 5, (0.86 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 20, (0.95 * size.height));
    thunderBranchPath.lineTo((size.width / 2) - 40, (0.98 * size.height));


    thunderBranchPath.moveTo((size.width / 2), (0.875 * size.height));
    thunderBranchPath.lineTo((size.width / 2) + 35, (0.9 * size.height));
    thunderBranchPath.lineTo((size.width / 2) + 50, (0.94 * size.height));


    thunderPath.lineTo((size.width / 2) + 10, (0.575 * size.height));
    thunderPath.lineTo((size.width / 2), (0.6 * size.height));
    thunderPath.lineTo((size.width / 2) + 10, (0.625 * size.height));
    thunderPath.lineTo((size.width / 2), (0.65 * size.height));
    thunderPath.lineTo((size.width / 2) + 10, (0.75 * size.height));
    thunderPath.lineTo((size.width / 2) - 20, (0.78 * size.height));
    thunderPath.lineTo((size.width / 2) - 20, (0.833 * size.height));
    thunderPath.lineTo((size.width / 2), (0.875 * size.height));
    thunderPath.lineTo((size.width / 2) - 5, (1.0 * size.height));


    canvas.drawPath(thunderPath, thunderPaint);
    canvas.drawPath(thunderBranchPath, thunderBranchPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate != this){
      return true;
    }
    else{
      return false;
    }
  }
}
