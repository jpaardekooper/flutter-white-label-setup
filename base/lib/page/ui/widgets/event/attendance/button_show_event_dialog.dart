import 'package:base/models/event_users.dart';
import 'package:base/page/ui/widgets/event/attendance/dialog_list_tile.dart';
import 'package:flutter/material.dart';

class ButtonShowEventDialog extends StatefulWidget {
  const ButtonShowEventDialog(
      {Key? key, required this.list, required this.message})
      : super(key: key);
  final List<dynamic> list;
  final String message;

  @override
  _ButtonShowEventDialogState createState() => _ButtonShowEventDialogState();
}

class _ButtonShowEventDialogState extends State<ButtonShowEventDialog> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          scrollable: false,
          title: Text(widget.message),
          insetPadding: EdgeInsets.all(10),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.maxFinite,
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: widget.list.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext ctx, index) {
                EventUsers eventUser = widget.list[index];
                return DialogListTile(eventUser: eventUser);
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Sluiten'),
            ),
          ],
        ),
      ),
      icon: Icon(Icons.more_horiz_outlined),
    );
  }
}
