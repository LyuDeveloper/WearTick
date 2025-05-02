import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weartick/CreateProjectPage.dart';
import 'package:weartick/operator.dart';

class SelectPage extends StatefulWidget {
  final int selection;
  final Directory path;

  const SelectPage({super.key, required this.selection, required this.path});

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {

  Future<List> get _dirContextReader async {
    Directory appDocumentDirectory = await getApplicationDocumentsDirectory();
    String path = '${appDocumentDirectory.path}${Platform.pathSeparator}';
    Stream<FileSystemEntity> dirList = Directory(path).list();
    List<FileSystemEntity> fileList = await dirList.toList();
    fileList.removeAt(0);
    fileList.removeAt(0);
    return fileList;
  }
  
  Widget RadioTitle(name, path){
    if(name != 'inbox' && name != 'recycle'){
      return FutureBuilder(future: fileReader('${path.toString().replaceAll('\'', '').replaceAll('Directory: ', '')}/project.json'), 
        builder: (context, snapshot) {
          if (snapshot.data != null){
            return Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Color(int.parse('FF${projectJsonDecode(snapshot.data).color.replaceAll('0x', '')}',radix: 16)),
                    shape: BoxShape.circle, 
                  )
                ),
                SizedBox(width: 5),
                Text(projectJsonDecode(snapshot.data).name),
              ],
            );
          } else {return Text('#Broken Project, Name: $name');}
        },
      );
    } else if (name == 'recycle'){
      return Text('recycle');
    }
    return Text('inbox');
  }

  Widget selections(int selectedValue) {
    return FutureBuilder(
      future: _dirContextReader,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<FileSystemEntity> fileListData = snapshot.data as List<FileSystemEntity>;
          return Column(
            children: fileListData.asMap().entries.map((entry) {
              int i = entry.key;
              FileSystemEntity file = entry.value;
              String tileContext = file.toString();
              tileContext = tileContext.split(new RegExp('/')).last;
              tileContext = tileContext.replaceAll('\'', '');
              return RadioListTile(
                value: i,
                groupValue: selectedValue,
                onChanged: (int? value) {
                  List returnData = [value, file];
                  Navigator.pop(context, returnData);
                },
                title: RadioTitle(tileContext, file)
              );
            }).toList(),
          );
        }
      },
    );
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
                  child: Text("Projects"),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Spacer(flex: 1),
                  Expanded(
                    flex: 20,
                    child: ElevatedButton(
                      child: Row(children: [Icon(Icons.arrow_back),Text('Back')],),
                      onPressed: () {Navigator.pop(context, [widget.selection, widget.path]);},
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 20,
                    child: FilledButton(
                      child: Row(children: [Icon(Icons.add),Text('New')],),
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => CreateProjectPage())).then((_) {
                          setState(() {});
                        });
                      },
                    ),
                  ),
                  Spacer(flex: 1),
                ]
              ),
            ),
            SliverToBoxAdapter(
              child: Card(
                child: Column(
                  children: [selections(widget.selection)],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FilledButton(onPressed: (){}, child: Text('Auth'))
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