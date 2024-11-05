import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/widgets/loader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'dart:developer' as developer;

class FileViewer extends StatefulWidget {
  final String fileUrl;
  final String heading;

  const FileViewer({super.key, required this.fileUrl, required this.heading});

  @override
  State<FileViewer> createState() => _FileViewerState();
}

class _FileViewerState extends State<FileViewer> {
  File? _localFile;
  String? _error;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeFile();
  }

  Future<void> _initializeFile() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final fileType = _determineFileType(widget.fileUrl);
      if (fileType == 'pdf') {
        _localFile = await _downloadFile(widget.fileUrl);
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      developer.log('Error initializing file: $e');
      setState(() {
        _error = 'Failed to load file: $e';
        _isLoading = false;
      });
    }
  }

String _determineFileType(String url) {
  final cleanUrl = url.split('?').first;
  final extension = path.extension(cleanUrl).toLowerCase();
  
  if (['.jpg', '.jpeg', '.png', '.gif'].contains(extension)) {
    return 'image';
  } else if (extension == '.pdf') {
    return 'pdf';
  } else {
    throw Exception('Unsupported file type: $extension');
  }
}


Future<File> _downloadFile(String url) async {
  try {
    final dio = Dio();
    final directory = await getApplicationDocumentsDirectory();

    // Clean URL by removing query parameters for filename purposes
    final baseUrl = url.split('?').first;
    final fileName = path.basename(baseUrl); // Get only the file name without query params
    final filePath = path.join(directory.path, fileName);
    final file = File(filePath);

    // Check if file already exists
    if (await file.exists()) {
      developer.log('File already exists: $filePath');
      return file;
    }

    developer.log('Downloading file from: $url');
    developer.log('Saving to: $filePath');

    final response = await dio.get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: true,
        validateStatus: (status) => status! < 500,
      ),
    );

    if (response.statusCode == 200) {
      await file.writeAsBytes(response.data);
      developer.log('File downloaded successfully');
      return file;
    } else {
      throw Exception('Failed to download file: Status ${response.statusCode}');
    }
  } catch (e) {
    developer.log('Error downloading file: $e');
    rethrow;
  }
}


  Widget _buildErrorWidget(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _initializeFile,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileView() {
    final fileType = _determineFileType(widget.fileUrl);

    if (fileType == 'image') {
      return Center(
        child: CachedNetworkImage(
          imageUrl: widget.fileUrl,
          placeholder: (context, url) => const Center(
            child: CupertinoActivityIndicator(),
          ),
          errorWidget: (context, url, error) => _buildErrorWidget(
            'Failed to load image: $error',
          ),
          fit: BoxFit.contain,
        ),
      );
    } else if (fileType == 'pdf' && _localFile != null) {
      return PDFView(
        filePath: _localFile!.path,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onError: (error) {
          setState(() {
            _error = error.toString();
          });
        },
        onPageError: (page, error) {
          developer.log('Error on page $page: $error');
        },
      );
    } else {
      return _buildErrorWidget('Unsupported file type or file not loaded');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.heading),
        actions: [
          if (!_isLoading && _error == null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _initializeFile,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: Loader(loaderType: LoaderType.fileLoader))
          : _error != null
              ? _buildErrorWidget(_error!)
              : _buildFileView(),
    );
  }

  @override
  void dispose() {
    // Cleanup if needed
    super.dispose();
  }
}