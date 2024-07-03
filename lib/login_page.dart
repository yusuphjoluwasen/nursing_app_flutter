import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       title: const Text("Heyyy"),
       backgroundColor: Colors.yellow,
     ),
     backgroundColor: Colors.blue[900],
     body:
         Stack(children: [
     Column(children: [
        const Text("Hello",style: TextStyle(color: Colors.white,
            fontSize: 22, fontWeight: FontWeight.bold)),

       const Icon(
         Icons.star,
         color: Colors.red,
       ),
       ElevatedButton(onPressed: (){
         print("heyyy");
       },
       child: const Text("Click",style: TextStyle(color: Colors.lightBlue)))
   ]
     ),

    Expanded(child:
    Row(children: [
      Text(
      "Hello How are you",
      style: TextStyle(
        color: Colors.white,
        backgroundColor: Colors.orange,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),

    ),SizedBox(width: 20)
      ,Text(
        "Hello How are you",
        style: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.orange,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),

      )],)
    ), Positioned(child: SmoothPageIndicator(controller:PageController(), count: 3,))])
   );
  }

}