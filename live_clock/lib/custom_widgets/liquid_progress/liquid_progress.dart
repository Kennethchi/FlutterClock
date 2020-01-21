import 'package:flutter/material.dart';
import 'package:live_clock/custom_widgets/objects_widgets/fish.dart';
import 'wave.dart';



class LiquidLinearProgressIndicator extends ProgressIndicator {


  ///The widget to show in the center of the progress indicator.
  final Widget centerChild;

  ///The direction the liquid travels.
  final Axis direction;

  LiquidLinearProgressIndicator({
    Key key,
    double value = 0.5,
    Color backgroundColor,
    Animation<Color> valueColor,
    this.centerChild,
    this.direction = Axis.horizontal,
  }) : super(
    key: key,
    value: value,
    backgroundColor: backgroundColor,
    valueColor: valueColor,
  ) {

  }

  Color _getBackgroundColor(BuildContext context) =>
      backgroundColor ?? Colors.transparent;

  Color _getValueColor(BuildContext context) =>
      valueColor?.value ?? Theme.of(context).accentColor;

  @override
  State<StatefulWidget> createState() => _LiquidLinearProgressIndicatorState();
}

class _LiquidLinearProgressIndicatorState
    extends State<LiquidLinearProgressIndicator> {
  @override
  Widget build(BuildContext context) {


    return Container(
      color: widget._getBackgroundColor(context),
      child: Stack(
        children: <Widget>[

          Wave(
            value: widget.value,
            color: widget._getValueColor(context),
            direction: widget.direction,
          ),

          if (widget.centerChild != null)
            Center(child: widget.centerChild),
        ],
      ),
    );
  }


}





