import 'package:flutter/material.dart';

class EditProjectPage extends StatefulWidget {
  EditProjectPage({super.key, required this.projectPath});

  final projectPath;

  @override
  _EditProjectPageState createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Editing ${widget.projectPath}'),
      ),
    );
  }
}