import 'dart:typed_data';
import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  html.File? _selectedFile;
  String? _uploadedImageUrl;
  bool _isUploading = false;

  void _pickImage() {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*'; // Accept only image files
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file != null) {
        setState(() {
          _selectedFile = file;
        });
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an image first.")),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final fileName = 'images/${DateTime.now().millisecondsSinceEpoch}_${_selectedFile!.name}';
      final ref = FirebaseStorage.instance.ref(fileName);

      // Read the file as Uint8List for upload
      final reader = html.FileReader();
      reader.readAsArrayBuffer(_selectedFile!);

      reader.onLoadEnd.listen((event) async {
        final data = reader.result as Uint8List;

        // Upload the data
        final uploadTask = ref.putData(data);
        await uploadTask.whenComplete(() async {
          final downloadUrl = await ref.getDownloadURL();
          setState(() {
            _uploadedImageUrl = downloadUrl;
            _isUploading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Image uploaded successfully!")),
          );
        });
      });

      reader.onError.listen((error) {
        setState(() {
          _isUploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to read file: $error")),
        );
      });
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Image")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_selectedFile != null)
              Text("Selected File: ${_selectedFile!.name}"),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Pick Image"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadImage,
              child: _isUploading ? CircularProgressIndicator() : Text("Upload Image"),
            ),
            if (_uploadedImageUrl != null)
              Column(
                children: [
                  SizedBox(height: 20),
                  Text("Uploaded Image URL:"),
                  SelectableText(_uploadedImageUrl!),
                  SizedBox(height: 10),
                  Image.network(_uploadedImageUrl!, height: 200),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
