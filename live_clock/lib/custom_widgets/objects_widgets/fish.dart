import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;



class Fish extends StatefulWidget {

  double size;

  Fish({@required this.size = 75.0});


  @override
  _FishState createState() => _FishState();
}

class _FishState extends State<Fish> with TickerProviderStateMixin<Fish>{

  AnimationController _animationController;
  Animation<double> _translateAnimation;

  AnimationController _verticalMovementAnimationController;
  Animation<double> _verticalMovementAnimation;


  AnimationController _rotationAnimationController;
  Animation<double> _rotationAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 20));
    _translateAnimation = Tween(begin: 0.0, end: -1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

    _rotationAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    _rotationAnimation = Tween(begin: - math.pi / 24, end: math.pi / 24).animate(CurvedAnimation(
        parent: _rotationAnimationController,
        curve: Curves.ease
    ));

    _verticalMovementAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500), );
    _verticalMovementAnimation = Tween(begin: -1.0, end: 1.0).animate(CurvedAnimation(
        parent: _verticalMovementAnimationController,
        curve: Curves.ease
    ));



    _animationController.repeat();

    _rotationAnimationController.forward();

    _rotationAnimationController.addStatusListener((AnimationStatus animationStatus){

      switch(animationStatus){
        case AnimationStatus.completed:
          _rotationAnimationController.reverse();
          break;
        case AnimationStatus.forward:
          if (_rotationAnimation.value < -math.pi / 24 || _rotationAnimation.value > math.pi / 24){
            _rotationAnimationController.reverse();
          }
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.dismissed:
          _rotationAnimationController.forward();
          break;
      }

    });


    _verticalMovementAnimationController.forward();

    _verticalMovementAnimationController.addStatusListener((AnimationStatus animationStatus){

      switch(animationStatus){
        case AnimationStatus.completed:
          _verticalMovementAnimationController.reverse();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.dismissed:
          _verticalMovementAnimationController.forward();
          break;
      }

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _animationController.removeListener((){});
    _animationController.dispose();

    _rotationAnimationController.removeListener((){});
    _rotationAnimationController.dispose();

    _verticalMovementAnimationController.removeListener((){});
    _verticalMovementAnimationController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child){
        return Transform.translate(
          offset: Offset((MediaQuery.of(context).size.width * 6.0) * 2 * _translateAnimation.value  + (MediaQuery.of(context).size.width * 6.0), 0.0),

          child: AnimatedBuilder(
            animation: _rotationAnimationController,
            builder: (BuildContext context, Widget child){
              return Transform.rotate(
                angle: _rotationAnimation.value,
                child: AnimatedBuilder(
                  animation: _verticalMovementAnimation,
                  builder: (BuildContext context, Widget child){
                    return Transform.translate(
                      offset: Offset(0.0, _verticalMovementAnimation.value * 30.0),
                      child: FittedBox(
                        child: CustomPaint(
                          painter: _FishPainter(),
                          isComplex: true,
                          willChange: true,
                          size: Size(widget.size, widget.size),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}



class _FishPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {


    //draw fish top Gill fill
    Paint topGillPaint = Paint();
    topGillPaint.style = PaintingStyle.fill;
    topGillPaint.strokeWidth = 1.0;
    topGillPaint.color = Colors.blue;
    Path topGillPath = Path();
    topGillPath.moveTo(size.width * 0.2, 0.0);
    topGillPath.lineTo(size.width * 0.3, -size.height * 0.055);
    topGillPath.lineTo(size.width * 0.5175, -size.height * 0.0475);
    topGillPath.lineTo(size.width * 0.425, size.height * 0.035);
    topGillPath.close();
    canvas.drawPath(topGillPath, topGillPaint);

    //draw fish top Gill Strole
    Paint topGillLinePaint = Paint();
    topGillLinePaint.style = PaintingStyle.stroke;
    topGillLinePaint.strokeWidth = 0.5;
    topGillLinePaint.color = Colors.black.withOpacity(0.8);
    Path topGillLinePath = Path();
    topGillLinePath.moveTo(size.width * 0.2, 0.0);
    topGillLinePath.lineTo(size.width * 0.3, -size.height * 0.055);
    topGillLinePath.lineTo(size.width * 0.5175, -size.height * 0.0475);
    topGillLinePath.lineTo(size.width * 0.425, size.height * 0.035);
    topGillLinePath.close();
    canvas.drawPath(topGillLinePath, topGillLinePaint);



    //draw fish bottom left Gill
    Paint bottomLeftGillPaint = Paint();
    bottomLeftGillPaint.style = PaintingStyle.fill;
    bottomLeftGillPaint.strokeWidth = 1.0;
    bottomLeftGillPaint.color = Colors.blue;
    Path bottomLeftGillPath = Path();
    bottomLeftGillPath.moveTo(size.width * 0.2, size.height * 0.2);
    bottomLeftGillPath.lineTo(size.width * 0.25, size.height * 0.25);
    bottomLeftGillPath.lineTo(size.width * 0.4, size.height * 0.25);
    bottomLeftGillPath.lineTo(size.width * 0.3, size.height * 0.15);
    bottomLeftGillPath.close();
    canvas.drawPath(bottomLeftGillPath, bottomLeftGillPaint);

    //draw fish bottom left Gill stroke
    Paint bottomLeftGillLinePaint = Paint();
    bottomLeftGillLinePaint.style = PaintingStyle.stroke;
    bottomLeftGillLinePaint.strokeWidth = 0.5;
    bottomLeftGillLinePaint.color = Colors.black.withOpacity(0.8);
    Path bottomLeftGillLinePath = Path();
    bottomLeftGillLinePath.moveTo(size.width * 0.2, size.height * 0.2);
    bottomLeftGillLinePath.lineTo(size.width * 0.25, size.height * 0.25);
    bottomLeftGillLinePath.lineTo(size.width * 0.4, size.height * 0.25);
    bottomLeftGillLinePath.lineTo(size.width * 0.3, size.height * 0.15);
    bottomLeftGillLinePath.close();
    canvas.drawPath(bottomLeftGillLinePath, bottomLeftGillLinePaint);



    //draw fish bottom right Gill fill
    Paint bottomRightGillPaint = Paint();
    bottomRightGillPaint.style = PaintingStyle.fill;
    bottomRightGillPaint.strokeWidth = 1.0;
    bottomRightGillPaint.color = Colors.blue;
    Path bottomRightGillPath = Path();
    bottomRightGillPath.moveTo(size.width * 0.38, size.height * 0.2);
    bottomRightGillPath.lineTo(size.width * 0.43, size.height * 0.24);
    bottomRightGillPath.lineTo(size.width * 0.5, size.height * 0.22);
    bottomRightGillPath.lineTo(size.width * 0.42, size.height * 0.15);
    bottomRightGillPath.close();
    canvas.drawPath(bottomRightGillPath, bottomRightGillPaint);

    //draw fish bottom right Gill stroke
    Paint bottomRightGillLinePaint = Paint();
    bottomRightGillLinePaint.style = PaintingStyle.stroke;
    bottomRightGillLinePaint.strokeWidth = 0.5;
    bottomRightGillLinePaint.color = Colors.black.withOpacity(0.8);
    Path bottomRightGillLinePath = Path();
    bottomRightGillLinePath.moveTo(size.width * 0.38, size.height * 0.2);
    bottomRightGillLinePath.lineTo(size.width * 0.43, size.height * 0.24);
    bottomRightGillLinePath.lineTo(size.width * 0.5, size.height * 0.22);
    bottomRightGillLinePath.lineTo(size.width * 0.42, size.height * 0.15);
    bottomRightGillLinePath.close();
    canvas.drawPath(bottomRightGillLinePath, bottomRightGillLinePaint);


    // draw fish tail
    Paint tailPaint = Paint();
    tailPaint.style = PaintingStyle.fill;
    tailPaint.color = Colors.blue;
    tailPaint.strokeWidth = 1.0;
    Path tailPath = Path();
    tailPath.moveTo(size.width * 0.45, size.height * 0.1);
    tailPath.lineTo(size.width * 0.65, 0);
    tailPath.lineTo(size.width * 0.6, size.height * 0.1);
    tailPath.lineTo(size.width * 0.65, size.height * 0.2);
    tailPath.close();
    canvas.drawPath(tailPath, tailPaint);

    // draw fish tail stroke
    Paint tailLinePaint = Paint();
    tailLinePaint.style = PaintingStyle.stroke;
    tailLinePaint.color = Colors.black.withOpacity(0.8);
    tailLinePaint.strokeWidth = 0.5;
    Path tailLinePath = Path();
    tailLinePath.moveTo(size.width * 0.45, size.height * 0.1);
    tailLinePath.lineTo(size.width * 0.65, 0);
    tailLinePath.lineTo(size.width * 0.6, size.height * 0.1);
    tailLinePath.lineTo(size.width * 0.65, size.height * 0.2);
    tailLinePath.close();
    canvas.drawPath(tailLinePath, tailLinePaint);



    // Draw fish main body
    Paint bodyPaint = Paint();
    bodyPaint.style = PaintingStyle.fill;
    bodyPaint.color = Colors.yellow;
    //canvas.drawOval(Rect.fromPoints(Offset(2.0, 0), Offset(100, 40)), bodyPaint);
    canvas.drawOval(Rect.fromPoints(Offset(size.width * 0.01, 0), Offset(size.width * 0.55, size.height * 0.2)), bodyPaint);

    // draw fish main body line
    Paint bodyLinePaint = Paint();
    bodyLinePaint.style = PaintingStyle.stroke;
    bodyLinePaint.strokeWidth = 0.5;
    bodyLinePaint.color = Colors.black.withOpacity(0.8);
    //canvas.drawOval(Rect.fromPoints(Offset(2.0, 0), Offset(100, 40)), bodyLinePaint);
    canvas.drawOval(Rect.fromPoints(Offset(size.width * 0.01, 0), Offset(size.width * 0.55, size.height * 0.2)), bodyLinePaint);



    // draw fish eyes
    Paint eyesPaint = Paint();
    eyesPaint.style = PaintingStyle.fill;
    eyesPaint.color = Colors.white;
    eyesPaint.strokeWidth = 0.5;
    //canvas.drawCircle(Offset(23, 12), 5.0, eyesPaint);
    canvas.drawCircle(Offset(size.width * 0.115, size.height * 0.06), size.width * 0.0225, eyesPaint);
    eyesPaint.color = Colors.black.withOpacity(0.8);
    //canvas.drawCircle(Offset(23, 12), 3.0, eyesPaint);
    canvas.drawCircle(Offset(size.width * 0.115, size.height * 0.06), size.width * 0.015, eyesPaint);
    eyesPaint.color = Colors.black.withOpacity(0.8);
    eyesPaint.style = PaintingStyle.stroke;
    eyesPaint.strokeWidth = 0.6;
    canvas.drawCircle(Offset(size.width * 0.115, size.height * 0.06), size.width * 0.0225, eyesPaint);


    // Drawing Fish Gill Cover
    Paint headCoverPaint = Paint();
    headCoverPaint.style = PaintingStyle.stroke;
    headCoverPaint.strokeWidth = 1.0;
    headCoverPaint.color = Colors.black.withOpacity(0.8);
    Path headCoverPath = Path();
    headCoverPath.addArc(Rect.fromPoints(Offset(size.width * 0.2, size.height * 0.05), Offset(size.width * 0.15, size.height * 0.19)), math.pi / 2 * -1, math.pi);
    canvas.drawPath(headCoverPath, headCoverPaint);


    // Draw fish middle gill
    Paint middleGillPaint = Paint();
    middleGillPaint.style = PaintingStyle.fill;
    middleGillPaint.strokeWidth = 1.0;
    middleGillPaint.color = Colors.blue;
    Path middleGillPath = Path();
    middleGillPath.moveTo(size.width * 0.2, size.height * 0.075);
    middleGillPath.lineTo(size.width * 0.25, size.height * 0.05);
    middleGillPath.lineTo(size.width * 0.25, size.height * 0.125);
    middleGillPath.lineTo(size.width * 0.2, size.height * 0.1);

    canvas.drawPath(middleGillPath, middleGillPaint);


    // Draw fish middle gill
    Paint middleGillLinePaint = Paint();
    middleGillLinePaint.style = PaintingStyle.stroke;
    middleGillLinePaint.strokeWidth = 0.5;
    middleGillLinePaint.color = Colors.black.withOpacity(0.8);
    Path middleGillLinePath = Path();
    middleGillLinePath.moveTo(size.width * 0.2, size.height * 0.075);
    middleGillLinePath.lineTo(size.width * 0.25, size.height * 0.05);
    middleGillLinePath.lineTo(size.width * 0.25, size.height * 0.125);
    middleGillLinePath.lineTo(size.width * 0.2, size.height * 0.1);
    canvas.drawPath(middleGillLinePath, middleGillLinePaint);


    // draw fish Mouth
    Paint mouthPaint = Paint();
    mouthPaint.style = PaintingStyle.fill;
    mouthPaint.color = Colors.deepOrange;
    mouthPaint.strokeWidth = 1.0;
    Path mouthPath = Path();
    mouthPath.addPolygon([Offset(size.width * 0.01, size.height * 0.075), Offset(size.width * 0.01, size.height * 0.125), Offset(size.width * 0.05, size.height * 0.1)], true);
    canvas.drawPath(mouthPath, mouthPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
