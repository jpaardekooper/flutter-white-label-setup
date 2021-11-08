import 'package:flutter/material.dart';
import 'package:base/state/contact_state.dart';
import 'package:provider/provider.dart';

class FavoriteSearch extends StatefulWidget {
  const FavoriteSearch({Key? key}) : super(key: key);

  @override
  _FavoriteSearchState createState() => _FavoriteSearchState();
}

class _FavoriteSearchState extends State<FavoriteSearch> {
  late TextEditingController editingController;

  @override
  void initState() {
    editingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    editingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var contactState = Provider.of<ContactState>(context, listen: false);
    return TextField(
      autofocus: true,
      style: Theme.of(context).textTheme.bodyText1,
      onChanged: (value) => contactState.filterSearchResults(
          contactState.listOfFavotire, value, ListType.favoriteList),
      controller: editingController,
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
