import 'package:flutter/material.dart';
import 'package:base/state/contact_state.dart';
import 'package:provider/provider.dart';

class ContactSearch extends StatefulWidget {
  const ContactSearch({Key? key}) : super(key: key);

  @override
  _ContactSearchState createState() => _ContactSearchState();
}

class _ContactSearchState extends State<ContactSearch> {
  late TextEditingController editingController;

  @override
  void initState() {
    super.initState();

    editingController = TextEditingController();
  }

  @override
  void dispose() {
    editingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var contactState = Provider.of<ContactState>(context, listen: true);
    return TextField(
      autofocus: true,
      onChanged: (value) => contactState.filterSearchResults(
          contactState.listOfContacts, value, ListType.contactList),
      controller: editingController,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: const InputDecoration(
        hintText: "Zoeken...",
        contentPadding: EdgeInsets.all(8),
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
