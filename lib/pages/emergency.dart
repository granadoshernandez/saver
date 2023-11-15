import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EmergenciaPage extends StatefulWidget {
  const EmergenciaPage({super.key});

  @override
  State<EmergenciaPage> createState() => _EmergenciaPageState();
}

class _EmergenciaPageState extends State<EmergenciaPage> {
  LatLng _initialPosition = LatLng(0.0, 0.0);
  String _emergencyDescription = "";
  String _selectedPriority = "Alta";

  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportar Emergencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GoogleMap(
                onMapCreated: (controller) {
                  setState(() {});
                },
                initialCameraPosition:
                CameraPosition(target: _initialPosition, zoom: 15.0),
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration:
              InputDecoration(labelText: 'Descripción de la Emergencia'),
              onChanged: (value) {
                setState(() {
                  _emergencyDescription = value;
                });
              },
            ),
            Row(
              children: [
                Text('Prioridad de la Denuncia '),
                DropdownButton<String>(
                  value: _selectedPriority,
                  items: ["Alta", "Media", "Baja"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                print("Ubicación: $_initialPosition");
                print("Descripción: $_emergencyDescription");
                print("Prioridad: $_selectedPriority");
              },
              child: Text('Reportar Emergencia'),
            ),
          ],
        ),
      ),
    );
  }
}