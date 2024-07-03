
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class OnboardingScreen extends StatelessWidget{
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:
    AppBar(title: const Text("Ninja ID Card"),foregroundColor: Colors.white,
        backgroundColor: Colors.grey[850],elevation: 0.0),
      backgroundColor: Colors.grey[700],body:
      const Padding(padding: EdgeInsets.all(20), child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(child:CircleAvatar(backgroundImage: AssetImage('assets/avatar.png'), radius: 30)),
          Divider(height: 40,color: Colors.grey,thickness: 0.5),
          Text("NAME",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600)),
          SizedBox(height: 5),
          Text("Chun-Li",style:TextStyle(color: Color(0xffeec911),
              fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 20),
            Text("CURRENT NINJA LEVEL",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600)),
            SizedBox(height: 5),
            Text("8",style:TextStyle(color: Colors.yellow,
                fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 20),
            Row(children: [
              Icon(
              Icons.email,
              color: Colors.grey,
            ),
              SizedBox(width: 5),
            Text("Ninja@gmail.com",style:
            TextStyle(color: Colors.grey,fontWeight: FontWeight.w600)),
            ],
            )

              ]
          ),),
    );
  }

}