import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:openbn/init_dependencies.dart';

class FileUploadService {
  Future<String?> uploadFile({
    required File file,
    required String fileAnnotation,
    required String folderName,
    ValueNotifier<double>? progressNotifier,
  }) async {
    try {
      // Validate file exists
      if (!file.existsSync()) {
        log('Error: File does not exist at path: ${file.path}');
        return null;
      }

      // Log file details
      log('File path: ${file.path}');
      log('File exists: ${file.existsSync()}');
      log('File size: ${await file.length()} bytes');

      // Generate a unique filename
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Get the file extension
      String extension = file.path.split('.').last;

      // Create storage reference
      Reference storageReference = serviceLocator<FirebaseStorage>()
          .ref()
          .child('Candidate/$folderName/$fileAnnotation/$fileName.$extension');

      // Create upload task with metadata
      final metadata = SettableMetadata(
        contentType: 'application/$extension',
        customMetadata: {'picked-file-path': file.path},
      );

      UploadTask uploadTask = storageReference.putFile(file.absolute, metadata);

      // Listen to upload progress if progressNotifier is provided
      if (progressNotifier != null) {
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          double progress = snapshot.bytesTransferred / snapshot.totalBytes;
          progressNotifier.value = progress;
        }, onError: (error) {
          log('Upload stream error: $error');
        });
      }

      // Wait for the upload to complete
      TaskSnapshot taskSnapshot = await uploadTask;
      log('Upload complete. Total bytes transferred: ${taskSnapshot.bytesTransferred}');

      // Get the download URL
      String downloadURL = await storageReference.getDownloadURL();

      // Reset progress
      // if (progressNotifier != null) {
      //   progressNotifier.value = 0.0;
      // }

      return downloadURL;
    } catch (error, stackTrace) {
      log('Error uploading file: $error');
      log('Stack trace: $stackTrace');
      if (progressNotifier != null) {
        progressNotifier.value = 0.0;
      }
      return null;
    }
  }

  Future<void> deleteFile(String filePath) async {
    try {
      Reference storageReference = serviceLocator<FirebaseStorage>()
          .ref()
          .child(extractFilePath(filePath));

      await storageReference.delete();
      log('File deleted successfully: $filePath');
    } catch (error) {
      log('Error deleting file: $error');
    }
  }

  String extractFilePath(String url) {
    Uri uri = Uri.parse(url);
    String path = uri.path;
    String decodedPath = Uri.decodeComponent(
        path.replaceFirst('/v0/b/yohire-a7f13.appspot.com/o/', ''));
    return decodedPath;
  }
}