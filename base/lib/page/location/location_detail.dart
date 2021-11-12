// import 'package:base/state/app_editing_state.dart';
// import 'package:base/state/location_state.dart';
// import 'package:base/page/ui/widgets/components/logo.dart';
// import 'package:base/page/ui/widgets/event/event.maps.dart';
// import 'package:base/page/ui/widgets/location/location_form.dart';
// import 'package:base/page/ui/widgets/location/location_header.dart';
// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// class LocationDetail extends StatefulWidget {
//   @override
//   State<LocationDetail> createState() => _LocationDetailState();
// }

// class _LocationDetailState extends State<LocationDetail> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     // Provider.of<LocationState>(context, listen: false)
//     //     .fetchSelectedLocationData(widget.location);

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var _state = Provider.of<LocationState>(context, listen: true);
//     return ChangeNotifierProvider<AppEditingState>(
//       create: (_) => AppEditingState(),
//       child: Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: AppbarLogo(),
//           backgroundColor: Colors.white,
//           centerTitle: true,
//           leading: IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: Icon(
//               Icons.arrow_back_outlined,
//               color: Colors.black,
//             ),
//           ),
//           actions: [],
//         ),
//         body: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 LocationHeader(
//                   location: _state.selectedLocation,
//                 ),
//                 LocationFormField(
//                   hint: 'Titel',
//                   value: _state.selectedLocation.title ?? '',
//                   theme: Theme.of(context).textTheme.headline5,
//                   type: TextType.text,
//                 ),
//                 LocationFormField(
//                   hint: 'Beschrijving',
//                   value: _state.selectedLocation.description ?? '',
//                   theme: Theme.of(context).textTheme.bodyText2,
//                   type: TextType.description,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: Text(
//                     'Adres van de locatie:',
//                     style: Theme.of(context).textTheme.headline5,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: LocationFormField(
//                         hint: 'Straatnaam + Nr',
//                         value: _state.selectedLocation.address ?? '',
//                         theme: Theme.of(context).textTheme.bodyText1,
//                         type: TextType.text,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: LocationFormField(
//                         canEdit: _isEditing,
//                         hint: 'Postcode',
//                         value: _state.selectedLocation.zipcode ?? '',
//                         theme: Theme.of(context).textTheme.bodyText1,
//                         type: TextType.text,
//                       ),
//                     ),
//                     _isEditing
//                         ? SizedBox(
//                             width: 8,
//                           )
//                         : SizedBox.shrink(),
//                     Expanded(
//                       flex: 3,
//                       child: LocationFormField(
//                         canEdit: _isEditing,
//                         hint: 'Plaatsnaam',
//                         value: _state.selectedLocation.city ?? '',
//                         theme: Theme.of(context).textTheme.bodyText1,
//                         type: TextType.text,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: LocationFormField(
//                           canEdit: _isEditing,
//                           hint: 'Latitude',
//                           value: _state.selectedLocation.latitude.toString(),
//                           theme: Theme.of(context).textTheme.bodyText1,
//                           type: TextType.autofill,
//                         ),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: LocationFormField(
//                           canEdit: _isEditing,
//                           hint: 'Longitude',
//                           value: _state.selectedLocation.longitude.toString(),
//                           theme: Theme.of(context).textTheme.bodyText1,
//                           type: TextType.autofill,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: Container(
//                     height: 250,
//                     child: EventMaps(),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           child: Text('annuleren'),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // setState(() {
//                             //   _state
//                             //       .changeLatitudeLongitude(); // Save the current offset from the bottom:
//                             // });
//                           },
//                           child: Text('Opslaan'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
