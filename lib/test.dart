import 'dart:convert';

import 'package:checklist_app/core/helper/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';




class ChecklistApp extends StatefulWidget {
  @override
  _ChecklistAppState createState() => _ChecklistAppState();
}

class _ChecklistAppState extends State<ChecklistApp> {
  List<String> _checklist = [];
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadChecklist();
  }

  // Load checklist from Firestore
  Future<void> _loadChecklist() async {
    final snapshot = await _firestore.collection('checklist').get();
    setState(() {
      _checklist = snapshot.docs.map((doc) => doc['item'] as String).toList();
    });
  }

  // Add a new item to Firestore
  Future<void> _addItem(String item) async {
    setState(() {
      _checklist.add(item);
    });
    await _firestore.collection('checklist').add({'item': item});
  }

  // Remove an item from Firestore
  Future<void> _removeItem(int index) async {
    final item = _checklist[index];
    setState(() {
      _checklist.removeAt(index);
    });
    final snapshot = await _firestore
        .collection('checklist')
        .where('item', isEqualTo: item)
        .get();
    await snapshot.docs.first.reference.delete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checklist App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Checklist App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter item',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _addItem(_controller.text);
                        _controller.clear();
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _checklist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_checklist[index]),
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
      ),
    );
  }
}

