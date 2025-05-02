import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weartick/ColorPickerPage.dart';
import 'package:weartick/JsonDecode.dart';
import 'package:weartick/operator.dart';

class CreateProjectPage extends StatefulWidget {
  @override
  _CreateProjectPageState createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {

  TextEditingController projectNameController = TextEditingController();
  String projectName = '';

  Future<void> _navigateAndDisplayColorPicker(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ColorPickerPage()),
    );

    if (!context.mounted) return;
    if (result != null){
      setState(() {
        colorReturned = result as Color;
      });
      print(result);
      return result;
    }
    

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Text('Selected')],)));
  }

  var colorReturned = const Color.fromRGBO(255, 193, 7, 1);

  Future<Future<File>> CreateProject(colorSelected, projectName) async {
    var time = DateTime.now().millisecondsSinceEpoch;
    final directory = await getApplicationDocumentsDirectory();
    String newProjectPath = '${directory.path}${Platform.pathSeparator}local.$time/';
    dirCreator(newProjectPath);
    String newProjectJson = '${newProjectPath}project.json';
    var jsonFile = File(newProjectJson);
    await File(newProjectJson).create(recursive: true);
    String colorString = '0x${colorSelected.red.toRadixString(16).padLeft(2, '0')}${colorSelected.green.toRadixString(16).padLeft(2, '0')}${colorSelected.blue.toRadixString(16).padLeft(2, '0').toUpperCase()}';
    print(colorString);
    var jsonContext = ProjectModel(
      id: '0', 
      name: projectName, 
      color: colorString, 
      closed: false, 
      groupId: '0', 
      viewMode: 'list', 
      permission: 'write', 
      kind: 'TASK');
    return jsonFile.writeAsString(jsonEncode(jsonContext));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Text('Create Project')
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Flex(direction: Axis.horizontal,children: [
                Spacer(flex: 1),
                Expanded(
                  flex: 40,
                  child: TextField(
                    controller: projectNameController,
                    onChanged: (context){projectName = projectNameController.text;},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Project Name',
                    ),
                  ),
                ),
                Spacer(flex: 1),
              ]),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 5),
            ),
            SliverToBoxAdapter(
              child: Card(
                child: Padding(padding: EdgeInsets.all(10),child: Column(
                  children: [
                    Flex(direction: Axis.horizontal,children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            _navigateAndDisplayColorPicker(context);
                          },
                          child: Text('Select Color'),
                        ),
                      ),
                    ]),
                    
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Selected Color:'),
                        Container(
                          height: 40,
                          width: 40,
                          decoration:
                            BoxDecoration(shape: BoxShape.circle, color: colorReturned),
                        ),
                      ],
                    )
                  ],
                ),),
              )
            ),
            SliverToBoxAdapter(
              child: Padding(padding:EdgeInsets.all(5), child: FilledButton(
                onPressed: (){
                  if (projectName == ''){
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Text('No Name Inputed')],)));
                    return;
                  }
                  CreateProject(colorReturned, projectName);
                  Navigator.pop(context);
                }, child: Text('Create')
              )),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: SizedBox(width: MediaQuery.of(context).size.width * 0.4,child: Divider())
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}