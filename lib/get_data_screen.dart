import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class getdatscreen extends StatefulWidget {
  const getdatscreen({super.key});

  @override
  State<getdatscreen> createState() => _getdatscreenState();
}

class _getdatscreenState extends State<getdatscreen> {
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text('GetData'),
      ),
      body: FutureBuilder(
          future:firebaseFirestore.collection('studentfile').get(),
          builder: (_,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError) {
              return Text('Error');
            }
            else if (!snapshot.hasData) {
              return Text('empty data');
            }
            else if (!snapshot.hasData) {
              final data = snapshot.data?.docs;
              return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (_, i) {
                    return Text(data?[i]["name"]);
                  });
            }
            else {
              return Text("snapshot went wrong");
            }
          }),
    );
  }
}
