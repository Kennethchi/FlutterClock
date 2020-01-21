import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';






class RainbowEffect extends StatefulWidget {

  double width;
  double height;
  double strokethickness;
  double opacity;

  RainbowEffect({
    @required this.width,
    @required this.height,
    this.strokethickness = 5.0,
    this.opacity = 1.0
  });

  @override
  _RainbowEffectState createState() => _RainbowEffectState();
}

class _RainbowEffectState extends State<RainbowEffect> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      //color: Colors.teal,
      child: ClipPath(
        clipper: _RainbowCustomClipper(),
        child: Container(
          width: widget.width != null? widget.width: 100.0,
          height: widget.height != null? widget.height: 100.0,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.red.withOpacity(widget.opacity), width: widget.strokethickness, style: BorderStyle.solid),
            shape: BoxShape.circle
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.orange.withOpacity(widget.opacity), width: widget.strokethickness, style: BorderStyle.solid),
                shape: BoxShape.circle
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.yellow.withOpacity(widget.opacity), width: widget.strokethickness, style: BorderStyle.solid),
                  shape: BoxShape.circle
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.lightGreen.withOpacity(widget.opacity), width: widget.strokethickness, style: BorderStyle.solid),
                    shape: BoxShape.circle
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.lightBlueAccent.withOpacity(widget.opacity), width: widget.strokethickness, style: BorderStyle.solid),
                      shape: BoxShape.circle
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.blueAccent.withOpacity(widget.opacity), width: widget.strokethickness, style: BorderStyle.solid),
                        shape: BoxShape.circle
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.purple.withOpacity(widget.opacity), width: widget.strokethickness, style: BorderStyle.solid),
                          shape: BoxShape.circle
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




class _RainbowCustomClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {

    Path path = Path();
    path.lineTo(0.0, size.height * 0.66);
    path.lineTo(size.width, size.height * 0.66);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}