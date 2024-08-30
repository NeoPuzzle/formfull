import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormScreen extends StatefulWidget {
  final Map<String, dynamic>? item;
  final int? index;
  final Function(Map<String, dynamic>, int?) onSave;

  const FormScreen({
    super.key,
    this.item,
    this.index,
    required this.onSave,
  });

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _nameController = TextEditingController();
  final _cellController = TextEditingController();
  final _emailController = TextEditingController();
  final _dniController = TextEditingController();
  final _ageController = TextEditingController();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!['name'] ?? '';
      _cellController.text = widget.item!['cell'] ?? '';
      _emailController.text = widget.item!['email'] ?? '';
      _dniController.text = widget.item!['dni'] ?? '';
      _ageController.text = widget.item!['age'] ?? '';
      if (widget.item!['photo'] != null) {
        _imageFile = File(widget.item!['photo']);
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _save() {
    final item = {
      'name': _nameController.text,
      'cell': _cellController.text,
      'email': _emailController.text,
      'dni': _dniController.text,
      'age': _ageController.text,
      'photo': _imageFile?.path, 
    };
    widget.onSave(item, widget.index);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Item'),
      ),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _cellController,
                decoration: const InputDecoration(labelText: 'Cell'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _dniController,
                decoration: const InputDecoration(labelText: 'DNI'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _imageFile == null
                  ? const Text('No image selected.')
                  : Image.file(
                      _imageFile!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



