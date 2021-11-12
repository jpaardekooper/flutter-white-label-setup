import 'dart:async';

import 'package:base/state/app_editing_state.dart';
import 'package:base/state/event_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EventMaps extends StatefulWidget {
  const EventMaps({Key? key}) : super(key: key);

  @override
  State<EventMaps> createState() => _EventMapsState();
}

class _EventMapsState extends State<EventMaps> {
  late Completer<GoogleMapController> _controller;

  late CameraPosition klate;

  List<Marker> markers = <Marker>[];

  @override
  void initState() {
    super.initState();

    _controller = Completer();

    var eventState = Provider.of<EventState>(context, listen: false);

    klate = CameraPosition(
      target: LatLng(eventState.selectedEvent.latitude ?? 0,
          eventState.selectedEvent.longitude ?? 0),
      zoom: eventState.selectedEvent.latitude == null ? 8 : 12,
    );

    markers.add(
      Marker(
        //      draggable: eventState.edit ? true : false,
        markerId: MarkerId(eventState.selectedEvent.id.toString()),
        position: LatLng(eventState.selectedEvent.latitude ?? 0,
            eventState.selectedEvent.longitude ?? 0),
        onDragEnd: (coords) {
          eventState.updateLongitude(coords);
        },
        infoWindow: InfoWindow(
            title: eventState.selectedEvent.title,
            snippet: eventState.selectedEvent.venueName),
        onTap: () {},
      ),
    );
  }

  updateMakrer() async {
    markers.clear();

    var eventState = Provider.of<EventState>(context, listen: false);

    LatLngBounds values =
        await _controller.future.then((value) => value.getVisibleRegion());

    LatLng latlngPostion = LatLng(
        (values.northeast.latitude + values.southwest.latitude) / 2,
        (values.northeast.longitude + values.southwest.longitude) / 2);

    eventState.updateLongitude(latlngPostion);

    await _controller.future.then((value) =>
        value.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: latlngPostion,
          zoom: 12,
        ))));

    setState(() {
      markers.add(
        Marker(
          draggable: true,
          markerId: MarkerId(eventState.selectedEvent.id.toString()),
          position: latlngPostion,
          onDragEnd: (coords) {
            eventState.updateLongitude(coords);
          },
          infoWindow: InfoWindow(
              title: eventState.selectedEvent.title,
              snippet: eventState.selectedEvent.venueName),
          onTap: () {},
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var eventState = Provider.of<EventState>(context, listen: true);
    var appEditState = Provider.of<AppEditingState>(context, listen: true);

    return Column(
      children: [
        eventState.authState.appUser.isAdmin! && appEditState.EditStatus
            ? TextButton(
                onPressed: updateMakrer,
                child: Text('Voeg een marker toe'),
              )
            : SizedBox(),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: GoogleMap(
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              ].toSet(),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.terrain,
              initialCameraPosition: klate,
              markers: Set<Marker>.of(markers),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMove: null,
              onCameraIdle: null,
              onCameraMoveStarted: null,
            ),
          ),
        ),
      ],
    );
  }
}
