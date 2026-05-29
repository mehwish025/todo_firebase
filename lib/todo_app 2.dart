import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool showInput = false;
  TextEditingController taskController = TextEditingController();
  String selectedDay = "monday";

  void toggleTask(String docId, bool currentStatus) {
    _firestore.collection('tasks').doc(docId).update({
      'isDone':!currentStatus
    });
  }

  void addTask() {
    if (taskController.text.trim().isNotEmpty) {
      _firestore.collection('todo_app2').add({
        'title': taskController.text.trim(),
        'isDone': false,
        'day': selectedDay,
        'createdAt': FieldValue.serverTimestamp(),
      });
      taskController.clear();
      setState(() => showInput = false);
    }
  }

  void deleteTask(String docId) {
    _firestore.collection('tasks').doc(docId).delete();
  }

  Widget buildTaskList(String day, String dateText) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
         .collection('tasks')
         .where('day', isEqualTo: day)
         .orderBy('createdAt', descending: false)
         .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var docs = snapshot.data!.docs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(day.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5)),
            SizedBox(height: 4),
            Text(dateText,
                style: TextStyle(color: Colors.grey[400], fontSize: 14)),
            SizedBox(height: 24),

           ...docs.map((doc) {
              var task = doc.data() as Map<String, dynamic>;
              return Dismissible(
                key: Key(doc.id),
                background: Container(color: Colors.red, child: Icon(Icons.delete, color: Colors.white)),
                onDismissed: (_) => deleteTask(doc.id),
                child: GestureDetector(
                  onTap: () => toggleTask(doc.id, task['isDone']),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: task['isDone']? Color(0xFFFF6B35) : Colors.transparent,
                            border: Border.all(
                                color: task['isDone']? Color(0xFFFF6B35) : Colors.grey[500]!, width: 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: task['isDone']
                             ? Icon(Icons.check, size: 16, color: Colors.white)
                              : null,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(task['title'],
                            style: TextStyle(
                              color: task['isDone']? Color(0xFFFF6B35) : Colors.white,
                              fontSize: 16,
                              decoration: task['isDone']? TextDecoration.lineThrough : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),

            SizedBox(height: 40),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTaskList("monday", "April 14 2025"),
                buildTaskList("tuesday", "April 15 2025"),

                showInput
                   ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ChoiceChip(
                                label: Text("Monday"),
                                selected: selectedDay == "monday",
                                onSelected: (val) => setState(() => selectedDay = "monday"),
                              ),
                              SizedBox(width: 8),
                              ChoiceChip(
                                label: Text("Tuesday"),
                                selected: selectedDay == "tuesday",
                                onSelected: (val) => setState(() => selectedDay = "tuesday"),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          TextField(
                            controller: taskController,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                              hintText: "Task likho...",
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.add, color: Colors.grey[600]),
                            ),
                            autofocus: true,
                            onSubmitted: (_) => addTask(),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () => setState(() => showInput = true),
                        child: Text("Add a new task...",
                            style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}