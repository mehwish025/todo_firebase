import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Studentfile extends StatefulWidget {
  const Studentfile({super.key});

  @override
  State<Studentfile> createState() => _StudentfileState();
}

class _StudentfileState extends State<Studentfile> {
  final nameController=TextEditingController();
  final rollnoController=TextEditingController();
  final classController=TextEditingController();
  final addressController=TextEditingController();
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('StudentFile'),
        ),
         body: Padding(
             padding: const EdgeInsets.all(16),
           child: Column(
             children: [
               TextField(
                 controller: nameController,
                 decoration: InputDecoration(
                   labelText: 'Name',
                       hintText: 'mehwish',
                   border: OutlineInputBorder(),
                 ),
               ),
               SizedBox(height: 10,),
               TextField(
                 controller: classController,
                 decoration: InputDecoration(
                   labelText: 'Class',
                   hintText: 'bsca',
                   border: OutlineInputBorder(),
                 ),
               ),
               SizedBox(height: 10,),
               TextField(
                 controller: rollnoController,
                 decoration: InputDecoration(
                   labelText: 'Roll NO',
                   hintText: '25',
                   border: OutlineInputBorder(),
                 ),
               ),
               SizedBox(height: 10,),
               TextField(
                 controller: addressController,
                 decoration: InputDecoration(
                   labelText: 'Address',
                   hintText: 'bwn',
                   border: OutlineInputBorder(),
                 ),
               ),
               SizedBox(height: 10,),
               ElevatedButton(
                   onPressed: ()async{
                     //firebaseFirestore.collection('studentfile').add({
                       //"name":nameController.text,
                     // "class":classController.text,
                      // "roll no":rollnoController.text,
                     // "address":addressController.text,
                    // }).then((h)=>print('data stored'));
                    // to get data
                     //final myData=await firebaseFirestore.collection('studentfile').doc('0gbJfT7C4diREAAaOOfl').get();
                    //print(myData.data());
                    // final myData=await firebaseFirestore.collection('studentfile').doc('A1asKVAS3Z0nNZJFa24k').get();
                   //  print(myData.data());
                    // final myData3 =await firebaseFirestore.collection('studentfile').doc('C9Iit17z0dbpfR6j1np7').get();
                    // print(myData3.data());
                     final myData=await firebaseFirestore.collection('studentfile').get();

                     for(var doc in myData.docs){
                       print(doc.data().toString());
                     };
                   // firebaseFirestore.collection('studentfile').doc('0gbJfT7C4diREAAaOOfl').update({
                     // "class": "Mobile Application",
                  //  }).then((_)=>print('data update'));

                     //firebaseFirestore.collection('studentfile').doc('5NJIInAASkfX18fj2I').delete();
                     },
                   child: Text('store data',style: TextStyle(color: Colors.green),)),
             ],
           ),
         ),
    );
  }
}
