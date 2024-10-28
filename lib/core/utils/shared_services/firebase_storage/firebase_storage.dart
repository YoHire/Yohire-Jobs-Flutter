import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:openbn/init_dependencies.dart';

class FileUploadService {
  Future<String?> uploadFile(
      {required File file,
      required String fileAnnotation,
      required String folderName}) async {
    try {
      // Generate a unique filename
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Get the file extension
      String extension = file.path.split('.').last;

      // Reference to the Firebase Storage location with the file extension
      Reference storageReference = serviceLocator<FirebaseStorage>()
          .ref()
          .child('Candidate/$folderName/$fileAnnotation/$fileName.$extension');
      // Upload the file
      await storageReference.putFile(file);

      // Get the download URL
      String downloadURL = await storageReference.getDownloadURL();

      // Return the download URL
      return downloadURL;
    } catch (error) {
      log('Error uploading file: $error');
      return null;
    }
  }

  Future<void> deleteFile(String filePath) async {
    try {
      // Reference to the file to be deleted
      Reference storageReference = serviceLocator<FirebaseStorage>()
          .ref()
          .child(extractFilePath(filePath));

      // Delete the file
      await storageReference.delete();

      log('File deleted successfully: $filePath');
    } catch (error) {
      log('Error deleting file: $error');
    }
  }

  String extractFilePath(String url) {
    // Parse the URL
    Uri uri = Uri.parse(url);

    // Extract the path from the URL
    String path = uri.path;

    // Remove the '/o/' prefix and decode the path
    String decodedPath = Uri.decodeComponent(
        path.replaceFirst('/v0/b/yohire-a7f13.appspot.com/o/', ''));

    // Return the extracted file path
    return decodedPath;
  }
}
