import 'package:base/ui/widgets/contact/ui/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:base/state/contact_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io' as Io;

class ProfileImage extends StatefulWidget {
  const ProfileImage(this.index, this.page, this.size);

  final int index;
  final String page;
  final double size;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  late ImagePicker picker;

  XFile? image;

  getImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        Provider.of<ContactState>(context, listen: false)
            .selectedContactUser
            .updateProfilePictureData(image!);
      }
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    heroTag: 'remove',
                    backgroundColor: Colors.red.shade600,
                    onPressed: () {
                      Provider.of<ContactState>(context, listen: false)
                          .selectedContactUser
                          .profilePicture = '';
                    },
                    tooltip: 'Huidige foto verwijderen',
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Foto',
                    style: TextStyle(fontSize: 12),
                  ),
                  const Text(
                    ' verwijderen',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    heroTag: 'add_image',
                    backgroundColor: Colors.blue,
                    onPressed: getImage,
                    tooltip: 'Nieuwe foto toevoegen',
                    child: const Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Foto ',
                    style: TextStyle(fontSize: 12),
                  ),
                  const Text(
                    'toevoegen',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Sluiten'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    picker = ImagePicker();
  }

  Widget buildImage(BuildContext context) {
    var provider =
        Provider.of<ContactState>(context, listen: false).selectedContactUser;
    return ClipOval(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          shape: BoxShape.circle,
        ),
        child: image != null
            ? Container(
                height: widget.size,
                width: widget.size,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      Io.File(image!.path),
                    ),
                  ),
                ),
              )
            : Material(
                color: Colors.transparent,
                child: CachedImage(
                  id: provider.id.toString(),
                  url: provider.profilePicture ?? '',
                  height: widget.size,
                  width: widget.size,
                  page: widget.page,
                ),
              ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _showMyDialog,
          child: ClipOval(
            child: Container(
              padding: EdgeInsets.all(all),
              color: color,
              child: child,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(context),
          Provider.of<ContactState>(context, listen: true).editProfileToggle
              ? Positioned(
                  bottom: 0,
                  right: 4,
                  child: buildEditIcon(Colors.blue),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
