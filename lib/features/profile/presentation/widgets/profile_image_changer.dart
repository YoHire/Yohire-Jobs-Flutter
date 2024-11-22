import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfileImageWidget extends StatefulWidget {
  final String? existingImageUrl;

  const ProfileImageWidget({super.key, this.existingImageUrl});

  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget>
    with SingleTickerProviderStateMixin {
  File? _profileImage;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickAndCropImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Crop the image
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 90,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Image',
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop Profile Image',
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _profileImage = File(croppedFile.path);
        });
      }
    }
  }

  void _showFullImageDialog() {
    if (widget.existingImageUrl == null) return;

    // Start the animation
    _animationController.forward(from: 0.0);

    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (BuildContext context) {
        return AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  InteractiveViewer(
                    maxScale: 5.0,
                    child: Hero(
                      tag: 'profile_image',
                      child: CachedNetworkImage(
                        imageUrl: widget.existingImageUrl!,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 30),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 50,
                    child: IconButton(
                      icon:
                          const Icon(Icons.edit, color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        _pickAndCropImage(); // Open image picker
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfilePicWidget() {
    return Column(
      children: [
        GestureDetector(
          onLongPress: _pickAndCropImage,
          onTap: _showFullImageDialog,
          child: Hero(
            tag: 'profile_image',
            child: PhysicalModel(
              color: Colors.black,
              shape: BoxShape.circle,
              elevation: 7,
              child: CircleAvatar(
                maxRadius: 60,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!) as ImageProvider<Object>
                    : widget.existingImageUrl != null &&
                            widget.existingImageUrl!.isNotEmpty
                        ? CachedNetworkImageProvider(widget.existingImageUrl!)
                        : const AssetImage('assets/images/user.jpeg')
                            as ImageProvider<Object>,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildProfilePicWidget();
  }
}
