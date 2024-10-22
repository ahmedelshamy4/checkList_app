import 'dart:html' as html;
import 'dart:convert'; // For jsonEncode and jsonDecode
import 'package:flutter/material.dart';

void main() {
  runApp(ChecklistApp());
}

class ChecklistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checklist App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChecklistPage(),
    );
  }
}

class ChecklistPage extends StatefulWidget {
  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  final TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> _checklist = [];

  @override
  void initState() {
    super.initState();
    _loadChecklist();
  }

  // Load checklist from localStorage
  void _loadChecklist() {
    String? savedData = html.window.localStorage['checklist'];
    if (savedData != null) {
      setState(() {
        _checklist = List<Map<String, dynamic>>.from(
            jsonDecode(savedData) as List);
      });
    }
  }

  // Save checklist to localStorage
  void _saveChecklist() {
    String checklistToSave = jsonEncode(_checklist);
    html.window.localStorage['checklist'] = checklistToSave;
  }

  // Add a new item to the checklist
  void _addItem(String title) {
    if (title.isNotEmpty) {
      setState(() {
        _checklist.add({'title': title, 'completed': false});
        _saveChecklist();
      });
      _textController.clear();
    }
  }

  // Toggle completion status of an item
  void _toggleCompletion(int index) {
    setState(() {
      _checklist[index]['completed'] = !_checklist[index]['completed'];
      _saveChecklist();
    });
  }

  // Remove an item from the checklist
  void _removeItem(int index) {
    setState(() {
      _checklist.removeAt(index);
      _saveChecklist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter new topic',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addItem(_textController.text),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _checklist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _checklist[index]['title'],
                      style: TextStyle(
                        decoration: _checklist[index]['completed']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    leading: Checkbox(
                      value: _checklist[index]['completed'],
                      onChanged: (value) => _toggleCompletion(index),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeItem(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
