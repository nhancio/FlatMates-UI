import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:ui' as ui;
import 'dart:html' as html;

class FetchScreen extends StatelessWidget {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> _fetchImageUrls() async {
    try {
      final ListResult result = await _storage.ref('images').listAll();
      List<String> urls = [];
      for (var ref in result.items) {
        final url = await ref.getDownloadURL();
        urls.add(url);
      }
      return urls;
    } catch (e) {
      throw Exception("Failed to fetch images: $e");
    }
  }

  Widget _buildImage(String url) {
    if (kIsWeb) {
      // For web platforms, use `HtmlElementView` with `ui.platformViewRegistry`.
      return HtmlImageWidget(url: url);
    } else {
      // For mobile and other platforms, use `Image.network`.
      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(child: Icon(Icons.error));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fetch Images")),
      body: FutureBuilder<List<String>>(
        future: _fetchImageUrls(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No images found."));
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final imageUrl = snapshot.data![index];
                return _buildImage(imageUrl);
              },
            );
          }
        },
      ),
    );
  }
}

class HtmlImageWidget extends StatelessWidget {
  final String url;

  HtmlImageWidget({required this.url}) {
    // Register the view factory for web platform.
    if (kIsWeb) {
      ui.platformViewRegistry.registerViewFactory(
        url,
            (int viewId) => html.ImageElement()
          ..src = url
          ..crossOrigin = "anonymous",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: url);
  }
}





///flutter run -d chrome --web-renderer html
