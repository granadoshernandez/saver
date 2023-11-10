import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ProcuraduriaPage extends StatefulWidget {
  const ProcuraduriaPage({super.key});

  @override
  State<ProcuraduriaPage> createState() => _ProcuraduriaPageState();
}

class _ProcuraduriaPageState extends State<ProcuraduriaPage> {
  TextEditingController _incidentTitleController = TextEditingController();
  TextEditingController _incidentDescriptionController = TextEditingController();
  List<File> _incidentMedia = [];
  String _selectedSeverity = 'Baja';
  List<String> _severities = ['Baja', 'Media', 'Alta'];
  String locationMessage = 'Presiona el botón de emergencia para solicitar ayuda';
  bool isEmergency = false;


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

    // Solicitar ayuda a los servicios de emergencia
    _sendEmergencyRequest(title, description, severity, _incidentMedia);
  }

  void _sendEmergencyRequest(String title, String description, String severity, List<File> media) async {
    final apiUrl = Uri.parse('https://tuserviciosemergencia.com/api/emergency_request');

    final incidentData = {
      'title': title,
      'description': description,
      'severity': severity,
    };

    final request = http.MultipartRequest('POST', apiUrl)
      ..fields.addAll(incidentData);

    for (var file in media) {
      request.files.add(await http.MultipartFile.fromPath('media', file.path));
    }

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('Solicitud de ayuda de emergencia enviada con éxito.');
    } else {
      print('Error al enviar la solicitud de ayuda de emergencia.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Priocuraduria General de el salvador",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightGreen[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
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
                    primary: Colors.lightGreen[900],
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
