import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatar extends StatefulWidget {
  final String? initialImageUrl;
  final Function(File)? onImageSelected;

  const ProfileAvatar({
    super.key,
    this.initialImageUrl,
    this.onImageSelected,
  });

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512, // Compresses image size
        maxHeight: 512,
        imageQuality: 75, // Adjusts quality to reduce file size
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });

        // Pass the file back to the parent widget/API service
        if (widget.onImageSelected != null) {
          widget.onImageSelected!(_imageFile!);
        }
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ImageProvider _getProfileImage() {
    if (_imageFile != null) {
      return FileImage(_imageFile!);
    } else if (widget.initialImageUrl != null && widget.initialImageUrl!.isNotEmpty) {
      return NetworkImage(widget.initialImageUrl!);
    } else {
      return const AssetImage('assets/images/default_avatar.png'); // Add a fallback asset
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60.0,
            backgroundColor: Colors.grey[300],
            backgroundImage: _getProfileImage(),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: GestureDetector(
              onTap: _showPickerOptions,
              child: const CircleAvatar(
                radius: 18.0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}