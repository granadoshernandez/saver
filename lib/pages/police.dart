import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PolicePage extends StatefulWidget {
  const PolicePage({Key? key}) : super(key: key);

  @override
  State<PolicePage> createState() => _PolicePageState();
}

class _PolicePageState extends State<PolicePage> {
  TextEditingController _incidentTitleController = TextEditingController();
  TextEditingController _incidentDescriptionController = TextEditingController();
  List<File> _incidentMedia = [];
  String _selectedSeverity = 'Baja';
  List<String> _severities = ['Baja', 'Media', 'Alta'];

  Future<void> _selectMedia() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _incidentMedia.add(File(pickedFile.path));
      });
    }
  }

  void _submitReport() {
    String title = _incidentTitleController.text;
    String description = _incidentDescriptionController.text;
    String severity = _selectedSeverity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Policia Nacional Civil"),
        backgroundColor: Colors.blue[900], // Cambia el color de fondo de la barra de navegación
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _incidentTitleController,
                decoration: InputDecoration(
                  labelText: 'Título del Incidente',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _incidentDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción del Incidente',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Prioridad de la denuncia: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: _selectedSeverity,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSeverity = newValue!;
                      });
                    },
                    items: _severities.map((String severity) {
                      return DropdownMenuItem<String>(
                        value: severity,
                        child: Text(
                          severity,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectMedia,
                child: Text(
                  'Adjuntar Foto o Video',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (_incidentMedia.isNotEmpty)
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _incidentMedia
                        .map((media) => Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.file(
                        media,
                        width: 150,
                        height: 150,
                      ),
                    ))
                        .toList(),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitReport,
                child: Text(
                  'Enviar Denuncia',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900], // Cambia el color del botón
                  onPrimary: Colors.white, // Cambia el color del texto del botón
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
