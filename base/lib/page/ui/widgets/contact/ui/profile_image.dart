import 'package:base/page/ui/widgets/contact/ui/cached_image.dart';
import 'package:base/state/app_editing_state.dart';
import 'package:flutter/material.dart';
import 'package:base/state/contact_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io' as Io;

class ProfileImage extends StatefulWidget {
  const ProfileImage({required this.page, required this.size});

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
                constraints: BoxConstraints(minWidth: 10, minHeight: 10),
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
            size: widget.size / 8,
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
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox.fromSize(
                            size: Size(40, 40), // button width and height
                            child: ClipOval(
                              child: Material(
                                color: Colors.orange, // button color
                                child: InkWell(
                                  splashColor: Colors.green, // splash color
                                  onTap: () {
                                    Provider.of<ContactState>(context,
                                            listen: false)
                                        .selectedContactUser
                                        .profilePicture = '';
                                  }, // button pressed
                                  child: Icon(
                                      Icons.delete_forever), // icon Column(
                                ),
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text("Verwijderen"),
                          ), //
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox.fromSize(
                            size: Size(40, 40), // button width and height
                            child: ClipOval(
                              child: Material(
                                color: Colors.orange, // button color
                                child: InkWell(
                                  splashColor: Colors.green, // splash color
                                  onTap: getImage,
                                  // button pressed
                                  child: Icon(Icons.image), // icon Column(
                                ),
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text("Toevoegen"),
                          ), //
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
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
          Provider.of<AppEditingState>(context).EditStatus
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
