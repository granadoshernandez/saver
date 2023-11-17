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
