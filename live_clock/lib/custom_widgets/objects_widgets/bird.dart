import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import 'dart:math' as math;


class Bird extends StatefulWidget {

  double size;

  Bird({@required this.size = 50.0});

  @override
  _BirdState createState() => _BirdState();
}

class _BirdState extends State<Bird> with TickerProviderStateMixin<Bird>{


  AnimationController _birdFeatherAnimationController;
  Animation<double>  _birdFeatherFlyAnimation;

  AnimationController _birdMovementAnimationController;
  Animation<double> _birdMovementAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _birdMovementAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 10));
    _birdMovementAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(parent: _birdMovementAnimationController, curve: Curves.linear));

    _birdFeatherAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _birdFeatherFlyAnimation = Tween(begin: - math.pi, end: math.pi).animate(_birdFeatherAnimationController);


    _birdMovementAnimationController.repeat();

    _birdFeatherAnimationController.forward();


    _birdFeatherAnimationController.addStatusListener((AnimationStatus animationStatus){
      switch(animationStatus){
        case AnimationStatus.completed:
          _birdFeatherAnimationController.reverse();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.dismissed:
          _birdFeatherAnimationController.forward();
          break;
      }
    });

  }


  @override
  void dispose() {
    // TODO: implement dispose
    _birdFeatherAnimationController.removeListener((){});
    _birdFeatherAnimationController.dispose();

    _birdMovementAnimationController.removeListener((){});
    _birdMovementAnimationController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _birdMovementAnimationController,
      builder: (BuildContext buildContext, Widget child){
        return Transform.translate(
          offset: Offset((MediaQuery.of(context).size.width * 10) * 2 * _birdMovementAnimation.value  + (MediaQuery.of(context).size.width * 10), 0.0),
          child: Container(
            child: Stack(
              fit: StackFit.loose,
              children: <Widget>[
                CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: _BirdPainter(),
                ),
                AnimatedBuilder(
                  animation: _birdFeatherAnimationController,
                  builder: (BuildContext buildContext, Widget child){

                    return Transform.translate(
                      offset: Offset(widget.size * 0.1, -widget.size * 0.8),
                      child: Transform(
                        transform: Matrix4.rotationX(_birdFeatherFlyAnimation.value),
                        origin: Offset(0, widget.size),
                        child: CustomPaint(
                          painter: _BirdFeatherPainter(),
                          size: Size(widget.size, widget.size),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}





class _BirdPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {

    // Draw bird main body
    Paint bodyPaint = Paint();
    bodyPaint.style = PaintingStyle.fill;
    bodyPaint.color = Colors.black;
    //canvas.drawOval(Rect.fromPoints(Offset(0.0, 0), Offset(100, 40)), bodyPaint);
    canvas.drawOval(Rect.fromPoints(Offset(0.0, 0), Offset(size.width, size.height * 0.4)), bodyPaint);


    // draw bird head
    Paint headPaint = Paint();
    headPaint.style = PaintingStyle.fill;
    headPaint.color = Colors.black;
    //canvas.drawCircle(Offset(108, 15), 14.0, headPaint);
    canvas.drawCircle(Offset(size.width * 1.09, size.height * 0.166), size.width * 0.133, headPaint);


    // draw bird Mouth
    Paint mouthPaint = Paint();
    mouthPaint.style = PaintingStyle.fill;
    mouthPaint.color = Colors.black;
    Path mouthPath = Path();
    //mouthPath.addPolygon([Offset(115.0, 10.0), Offset(115, 20.0), Offset(130.0, 15)], true);
    mouthPath.addPolygon([Offset(size.width * 1.1, size.height * 0.1), Offset(size.width * 1.1, size.height * 0.2), Offset(size.width * 1.3, size.height * 0.15)], true);

    canvas.drawPath(mouthPath, mouthPaint);

    // draw bird eyes
    Paint eyesPaint = Paint();
    eyesPaint.style = PaintingStyle.fill;
    eyesPaint.color = Colors.white;
    //canvas.drawCircle(Offset(113, 12), 5.0, eyesPaint);
    canvas.drawCircle(Offset(size.width * 1.125, size.height * 0.115), size.width * 0.05, eyesPaint);

    eyesPaint.color = Colors.black;
    //canvas.drawCircle(Offset(113, 12), 3.0, eyesPaint);
    canvas.drawCircle(Offset(size.width * 1.125, size.height * 0.115), size.width * 0.0275, eyesPaint);


    // draw bird tail
    Paint tailPaint = Paint();
    tailPaint.style = PaintingStyle.fill;
    tailPaint.color = Colors.black;
    Path tailPath = Path();
    //tailPath.addPolygon([Offset(-25, 5), Offset(-25, 35), Offset(20, 18)], true);
    tailPath.addPolygon([Offset(size.width * -0.25, size.height * 0.05), Offset(size.width * -0.25, size.height * 0.375), Offset(size.width * 0.15, size.height * 0.21)], true);
    canvas.drawPath(tailPath, tailPaint);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}










class _BirdFeatherPainter extends CustomPainter{


  @override
  void paint(Canvas canvas, Size size) {

    // Draw bird feather
    Paint featherPaint = Paint();
    featherPaint.style = PaintingStyle.fill;
    featherPaint.color = Colors.black;
    Path featherPath = Path();

    featherPath.moveTo(size.width * 0.66, 0.0);
    featherPath.lineTo(size.width * 0.4, size.height * 0.1);
    featherPath.lineTo(size.width * 0.1, size.height * 0.3);
    featherPath.lineTo(0.0, size.height * 0.66);
    featherPath.lineTo(size.width * 0.6, size.height);
    featherPath.lineTo(size.width * 0.9, size.height);
    featherPath.lineTo(size.width * 0.6, size.height * 0.6);
    featherPath.lineTo(size.width * 0.55, size.height * 0.25);


    featherPath.close();

    canvas.drawPath(featherPath, featherPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}