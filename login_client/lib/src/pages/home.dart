import 'package:flutter/material.dart';
import 'form_screen.dart';
import 'dart:io';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _items = [];

  void _addOrUpdateItem(Map<String, dynamic> item, int? index) {
    setState(() {
      if (index != null) {
        _items[index] = item;
      } else {
        _items.add(item);
      }
    });
  }

  void _showForm([Map<String, dynamic>? item, int? index]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(
          item: item,
          index: index,
          onSave: _addOrUpdateItem,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: CircleAvatar(
              backgroundImage: item['photo'] != null
                  ? FileImage(File(item['photo']))
                  : null,
              child: item['photo'] == null ? const Icon(Icons.person) : null,
            ),
            title: Text(item['name'] ?? ''),
            subtitle: Text(item['email'] ?? ''),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showForm(item, index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}



