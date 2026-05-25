import 'package:flutter/material.dart';
class pratics extends StatelessWidget {
  const pratics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
          children: [
            AppBar(
              centerTitle: true,
              title: Text('Welcome',style: TextStyle(color: Colors.cyan),),
            ),
    ElevatedButton(
    onPressed: (){
    print('Hello Guys');
    }, child: Text('welcome back',style: TextStyle(color: Colors.pinkAccent.shade100),)),
          ],
        ) );

  }
}
