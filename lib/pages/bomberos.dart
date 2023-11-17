import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BomberosPage());
}

class BomberosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Denuncia Ciudadana',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class Emergency {
  String tipo;
  String gravedad;
  String descripcion;
  String ubicacion;
  bool anonima;

  Emergency({
    required this.tipo,
    required this.gravedad,
    required this.descripcion,
    required this.ubicacion,
    required this.anonima,
  });
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text(
          "Cuerpo de Bomberos",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _incidentTitleController,
                  decoration: const InputDecoration(
                    labelText: 'Título del Incidente',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _incidentDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción del Incidente',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
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
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _selectMedia,
                  child: const Text(
                    'Adjuntar Foto o Video',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (_incidentMedia.isNotEmpty)
                  Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _incidentMedia
                          .map((media) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          media,
                          width: 150,
                          height: 150,
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitReport,
                  child: const Text(
                    'Enviar Denuncia',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange[600],
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
=======
        title: Text('Denuncia Ciudadana - Bomberos'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 16, 168, 238),
        ),
        child: Column(
          children: [
            EmergencyForm(),
            SizedBox(height: 20),
            EmergencyList(),
          ],
>>>>>>> 06d61dcc65572407cc1ba026d77608596f8b31be
        ),
      ),
    );
  }
}

class EmergencyForm extends StatefulWidget {
  @override
  _EmergencyFormState createState() => _EmergencyFormState();
}

class _EmergencyFormState extends State<EmergencyForm> {
  final _formKey = GlobalKey<FormState>();
  late Emergency _emergency;

  @override
  void initState() {
    super.initState();
    _emergency = Emergency(
        tipo: '', gravedad: '', descripcion: '', ubicacion: '', anonima: false);
  }

  void _showSuccessNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Emergencia enviada con éxito'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tipo de emergencia',
                icon: Icon(Icons.category),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el tipo de emergencia';
                }
                return null;
              },
              onSaved: (value) {
                _emergency.tipo = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Gravedad',
                icon: Icon(Icons.warning),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese la gravedad';
                }
                return null;
              },
              onSaved: (value) {
                _emergency.gravedad = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Descripción',
                icon: Icon(Icons.description),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese la descripción';
                }
                return null;
              },
              onSaved: (value) {
                _emergency.descripcion = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Ubicación',
                icon: Icon(Icons.location_on),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese la ubicación';
                }
                return null;
              },
              onSaved: (value) {
                _emergency.ubicacion = value!;
              },
            ),
            CheckboxListTile(
              title: Text('Anónima'),
              value: _emergency.anonima,
              onChanged: (value) {
                setState(() {
                  _emergency.anonima = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  enviarEmergencia(_emergency);
                  _showSuccessNotification();
                  _formKey.currentState!.reset();
                }
              },
              child: Text('Enviar Emergencia'),
            ),
          ],
        ),
      ),
    );
  }
}

void enviarEmergencia(Emergency emergency) {
  FirebaseFirestore.instance.collection('tb_bomberos').add({
    'tipo': emergency.tipo,
    'gravedad': emergency.gravedad,
    'descripcion': emergency.descripcion,
    'ubicacion': emergency.ubicacion,
    'anonima': emergency.anonima,
    'estado': 'Pendiente',
  });
}

class EmergencyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('tb_bomberos').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var emergencies = snapshot.data!.docs;

          return ListView.builder(
            itemCount: emergencies.length,
            itemBuilder: (context, index) {
              var emergency = emergencies[index];
              return ListTile(
                title: Text(emergency['tipo']),
                subtitle: Text(emergency['estado']),
              );
            },
          );
        },
      ),
    );
  }
}
