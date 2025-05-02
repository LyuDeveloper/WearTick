import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerPage extends StatefulWidget {
  @override
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  Color _selectedColor = Colors.amber;
  

  void onColorChanged(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers:[
          SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Text('Select a Color')
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Card(
              margin: EdgeInsets.all(5),
              child: Padding(
                padding: EdgeInsets.all(10),
                child:  Center(
                  child:(
                    SlidePicker(pickerColor: _selectedColor, onColorChanged: onColorChanged)
                  ),
                )
            )
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FilledButton(onPressed: (){Navigator.pop(context ,_selectedColor);}, child: Text('Finish')),
            ),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: SizedBox(width: MediaQuery.of(context).size.width * 0.4,child: Divider())
                ),
              ),
            ),
        ]
      ),
    );
  }

}