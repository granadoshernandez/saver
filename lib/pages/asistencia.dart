import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AsistenciaApp());
}

class AsistenciaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asistencia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AsistenciaHomePage(),
    );
  }
}

class Asistencia {
  String tipo;
  String gravedad;
  String descripcion;
  String ubicacion;
  bool anonima;

  Asistencia({
    required this.tipo,
    required this.gravedad,
    required this.descripcion,
    required this.ubicacion,
    required this.anonima,
  });
}

class AsistenciaHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asistencias'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          children: [
            AsistenciaForm(),
            SizedBox(height: 20),
            /* AsistenciaList(), */
          ],
        ),
      ),
    );
  }
}

class AsistenciaForm extends StatefulWidget {
  @override
  _AsistenciaFormState createState() => _AsistenciaFormState();
}

class _AsistenciaFormState extends State<AsistenciaForm> {
  final _formKey = GlobalKey<FormState>();
  late Asistencia _asistencia;
  Position? _posicionActual;

  @override
  void initState() {
    super.initState();
    _asistencia = Asistencia(
        tipo: '', gravedad: '', descripcion: '', ubicacion: '', anonima: false);
    _obtenerUbicacionActual();
  }

  Future<void> _obtenerUbicacionActual() async {
    try {
      Position posicion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _posicionActual = posicion;
      });
    } catch (e) {
      print("Error obteniendo la ubicación: $e");
    }
  }

  void _mostrarNotificacionExito() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Asistencia enviada con éxito'),
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
                labelText: 'Tipo de asistencia',
                icon: Icon(Icons.category),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor complete este campo';
                }
                return null;
              },
              onSaved: (value) {
                _asistencia.tipo = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Gravedad',
                icon: Icon(Icons.warning),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor complete este campo';
                }
                return null;
              },
              onSaved: (value) {
                _asistencia.gravedad = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Descripción',
                icon: Icon(Icons.description),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor complete este campo';
                }
                return null;
              },
              onSaved: (value) {
                _asistencia.descripcion = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Ubicación',
                icon: Icon(Icons.location_on),
              ),
              readOnly: true,
              initialValue: _posicionActual != null
                  ? 'Latitud: ${_posicionActual!.latitude}, Longitud: ${_posicionActual!.longitude}'
                  : 'NULL',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor complete este campo';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            CheckboxListTile(
              title: Text('Anónima'),
              value: _asistencia.anonima,
              onChanged: (value) {
                setState(() {
                  _asistencia.anonima = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _asistencia.ubicacion =
                      'Latitud: ${_posicionActual!.latitude}, Longitud: ${_posicionActual!.longitude}';
                  enviarAsistencia(_asistencia);
                  _mostrarNotificacionExito();
                  _formKey.currentState!.reset();
                }
              },
              child: Text('Enviar Asistencia'),
            ),
          ],
        ),
      ),
    );
  }
}

void enviarAsistencia(Asistencia asistencia) {
  FirebaseFirestore.instance.collection('emergencies').add({
    'tipo': asistencia.tipo,
    'gravedad': asistencia.gravedad,
    'descripcion': asistencia.descripcion,
    'ubicacion': asistencia.ubicacion,
    'anonima': asistencia.anonima,
    'estado': 'Pendiente',
  });
}