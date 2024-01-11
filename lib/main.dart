import 'package:excel_export/data.dart';
import 'package:excel_export/excel_api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExcelExportApp(),
    );
  }
}

class ExcelExportApp extends StatefulWidget {
  const ExcelExportApp({super.key});

  @override
  State<ExcelExportApp> createState() => _ExcelExportAppState();
}

class _ExcelExportAppState extends State<ExcelExportApp> {
  final List<TextEditingController> _textControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final TextEditingController _textFieldNameController =
      TextEditingController();

  getTextWidgets() {
    List<Widget> widgets = [];
    for (TextEditingController controllers in _textControllers) {
      widgets.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controllers,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  getTextfieldValues() {
    List<String> values = [];
    for (TextEditingController controllers in _textControllers) {
      values.add(controllers.text);
    }
    return values;
  }

  getPopup() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              children: [
                Text("please name your file".toUpperCase()),
                TextField(
                  controller: _textFieldNameController,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => ExcelAPI().fillExcelSheet(),
                  child: const Text('Save'))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Table(
            children: tableData
                .map(
                  (rowData) => TableRow(
                    children: rowData
                        .map(
                          (element) => Text(element),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
          Row(
            children: getTextWidgets(),
          ),
          OutlinedButton(
              onPressed: () {
                setState(() {
                  tableData.add(
                    List.from(getTextfieldValues()),
                  );
                });
              },
              child: const Text('Submit'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getPopup(),
        child: const Icon(
          Icons.shape_line_outlined,
        ),
      ),
    );
  }
}
