import 'package:base/models/contact_user.dart';
import 'package:base/models/event_users.dart';
import 'package:base/page/contact/contact_details_page.dart';
import 'package:base/state/contact_state.dart';
import 'package:base/ui/widgets/event/attendance/cached_event_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DialogListTile extends StatefulWidget {
  const DialogListTile({Key? key, required this.eventUser}) : super(key: key);
  final EventUsers eventUser;
  @override
  _DialogListTileState createState() => _DialogListTileState();
}

class _DialogListTileState extends State<DialogListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        ContactUser test = ContactUser(
            id: widget.eventUser.id,
            profilePicture: widget.eventUser.userImage);

        Provider.of<ContactState>(context, listen: false)
            .setContactId(test.id!);

        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: ContactDetails('events'),
          ),
        );
      },
      dense: true,
      leading: CachedEventImage(widget.eventUser.userImage ?? '', 50, 50,
          'events', widget.eventUser.takesGuest),
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      title: Text(widget.eventUser.userName ?? ''),
      subtitle:
          Text(widget.eventUser.takesGuest! ? 'Neemt een persoon mee' : ''),
    );
  }
}
