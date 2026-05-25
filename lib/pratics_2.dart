import 'package:firebase_project/main.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text="hello";
  void changeText(){
    setState(() {
      text;"hello mehwish";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text('MY First pratics',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
      ),
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            ElevatedButton(
                onPressed: (){
                  print('change text');
                }, child: Text('pratics start kro',style: TextStyle(color: Colors.cyan),))
          ],
        ),
      )


    );
  }
}

