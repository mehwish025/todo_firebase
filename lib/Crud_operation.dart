import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class CrudOperation extends StatefulWidget {
  const CrudOperation({super.key});

  @override
  State<CrudOperation> createState() => _CrudOperationState();
}

class _CrudOperationState extends State<CrudOperation> {
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
          centerTitle: true,
            title: Text('curd operation'),
          ),
         ElevatedButton(
              onPressed: ()async{
                firebaseFirestore.collection('user').add({
                  "name":"mehwish",
                  "class":"Bscs",
                  "city":"BWN",
                }).then((v){
                  print('Data stored');
                });
              }, child: Text('clicked me ',style: TextStyle(color: Colors.green),)),
        ],
      ),
      );
  }
}
