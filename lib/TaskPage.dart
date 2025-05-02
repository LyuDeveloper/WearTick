import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  final String task;

  const TaskPage({super.key, required this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.task),
      ),
    );
  }
}