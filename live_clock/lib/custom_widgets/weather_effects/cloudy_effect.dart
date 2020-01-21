import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';





class CloudyEffect extends StatefulWidget {
  @override
  _CloudyEffectState createState() => _CloudyEffectState();
}



class _CloudyEffectState extends State<CloudyEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                for (int count = 1; count <= 4; ++count)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.cloud, color: Colors.blue.shade50.withOpacity(0.5), size: 70.0,),
                  ),

              ],
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                for (int count = 1; count <= 3; ++count)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.cloud, color: Colors.blue.shade50.withOpacity(0.5), size: 60.0,),
                  ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}




