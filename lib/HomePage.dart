import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weartick/CreatePage.dart';
import 'package:weartick/EditProjectPage.dart';
import 'package:weartick/SelectPage.dart';
import 'package:weartick/TaskPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weartick/operator.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  List _selectedInfo = [0, Directory('/data/user/0/com.example.weartick/app_flutter/inbox')];
  
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    print(_selectedInfo);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectPage(selection: _selectedInfo[0],path: _selectedInfo[1],)),
    );

    if (!context.mounted) return;
    if (result != null) {print(result);
      _selectedInfo = result;}

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Text('${_selectedInfo[0]}')],)));
  }

  Future<String> get _defaultPath async {
    final directory = await getApplicationDocumentsDirectory();
    String inboxPath = '${directory.path}${Platform.pathSeparator}inbox';
    String recyclePath = '${directory.path}${Platform.pathSeparator}recycle';
    dirCreator(inboxPath);
    dirCreator(recyclePath);
    return directory.path;
  }
  

  @override
  Widget build(BuildContext context) {
    _defaultPath;
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: FilledButton(
                    onPressed: () {
                      _navigateAndDisplaySelection(context);
                    },
                    style: FilledButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(0),
                      minimumSize: Size(50, 50),
                    ),
                    child: Icon(Icons.toc, size: 30),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CreatePage(),
                    ),
                  );
                },
                child: Text("Create New"),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => TaskPage(task: index.toString()),
                        ),
                      );
                    },
                    child: Text("Button $index",style: TextStyle(color: Colors.white),),
                  );
                },
                childCount: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 5),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => EditProjectPage(projectPath: _selectedInfo[1]),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(0),
                      minimumSize: Size(50, 50),
                    ),
                    child: Icon(Icons.settings, size: 30),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
