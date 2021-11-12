import 'dart:io';

import 'package:base/models/spotted_location.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LocationHeader extends StatefulWidget {
  const LocationHeader(
      {Key? key, required this.location, required this.isEditing})
      : super(key: key);
  final SpottedLocation location;
  final bool isEditing;

  @override
  State<LocationHeader> createState() => _LocationHeaderState();
}

class _LocationHeaderState extends State<LocationHeader> {
  late ImagePicker picker;

  XFile? image;

  getImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {});
  }

  @override
  void initState() {
    picker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.location.url!,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          height: 250,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image != null
                        ? FileImage(File(image!.path)) as ImageProvider
                        : NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWJaETQSzqCVFZDUS_WHTH_Z7O6cscWRvB-c-eBRTW8ahEIAHd&s'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              widget.isEditing
                  ? Center(
                      child: ElevatedButton.icon(
                          onPressed: () async {
                            await getImage();
                          },
                          icon: Icon(Icons.camera),
                          label: Text('Kies een foto')),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
