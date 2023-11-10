import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mapa(),
    );
  }
}

class Mapa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: GoogleMapWidget(),
    );
  }
}

class GoogleMapWidget extends StatefulWidget {
  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController mapController;
  Location location = Location();
  LatLng? myLocation; // Almacena la ubicación del dispositivo (puede ser nula)

  @override
  void initState() {
    super.initState();
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Actualiza la ubicación del dispositivo cuando cambia
      setState(() {
        myLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(13.794185, -88.896530), // Coordenadas de El Salvador
            zoom: 8.0, // Nivel de zoom deseado
          ),
          markers: (myLocation != null)
              ? {
                  Marker(
                    markerId: MarkerId("My Location"),
                    position: myLocation!,
                    infoWindow: InfoWindow(title: "Mi ubicación"),
                  ),
                }
              : {},
        ),
        if (myLocation != null)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                // Implementa la lógica para compartir la ubicación aquí
                final shareText =
                    "Mi ubicación: https://www.google.com/maps?q=${myLocation!.latitude},${myLocation!.longitude}";
                // Puedes usar una función para compartir texto con otras aplicaciones
                // como Share.share(shareText).
              },
              child: Icon(Icons.share),
            ),
          ),
      ],
    );
  }
}
