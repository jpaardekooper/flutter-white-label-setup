import 'package:base/state/location_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationSearch extends StatefulWidget {
  const LocationSearch({
    Key? key,
  }) : super(key: key);

  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
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
    var state = Provider.of<LocationState>(context, listen: false);
    return TextField(
      autofocus: false,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
      onChanged: (value) {
        state.filterSearchResults(value);
      },
      controller: editingController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            editingController.text = '';
            state.resetSearch();
            FocusScope.of(context).unfocus();
          },
          icon: Icon(Icons.clear),
        ),
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
