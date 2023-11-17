import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prueba2/firebase_options.dart';
import 'package:prueba2/pages/Cruz.dart';
import 'package:prueba2/pages/Police.dart';
import 'package:prueba2/pages/acercade.dart';
import 'package:prueba2/pages/bomberos.dart';
import 'package:prueba2/pages/configuraciones.dart';
//import 'package:prueba2/configuraciones.dart';
import 'package:prueba2/pages/denuncias.dart';
import 'package:prueba2/pages/mapa.dart';
import 'package:prueba2/pages/perfil.dart';
import 'package:prueba2/pages/proteccion.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
<<<<<<< HEAD




=======
  // Función para cerrar sesión
>>>>>>> 06d61dcc65572407cc1ba026d77608596f8b31be
  void _signOut(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          // Agrega el IconButton para Google Maps aquí
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapaPage())
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Saver App"),
              accountEmail: Text("www.somossaverapp.org.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/logoo.png'),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),

            Divider(), // Divisor

            ListTile(
              leading: Image.asset(
                'assets/denuncias.png',
                width: 60,
                height: 45,
              ),
              title: Text(
                'Denuncias',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DenunciasPage()),
                );
              },
            ),

            Divider(), // Divisor

            ListTile(
              leading: Image.asset(
                'assets/asistencia.png',
                width: 60,
                height: 40,
              ),
              title: Text(
                'Asistencia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // Agrega la lógica para navegar a la pantalla de configuración
              },
            ),

            Divider(), // Divisor

            ListTile(
              leading: Image.asset(
                'assets/configuraciones.png',
                width: 60,
                height: 60,
              ),
              title: Text(
                'Configuraciones',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConfiguracionPage()),
                );
              },
            ),

            Divider(), // Divisor

            ListTile(
              leading: Image.asset(
                'assets/perfil.png',
                width: 60,
                height: 60,
              ),
              title: Text(
                'Perfil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PerfilPage()),
                );
              },
            ),

            Divider(), // Divisor

            ListTile(
              leading: Image.asset(
                'assets/acerca.png',
                width: 60,
                height: 60,
              ),
              title: Text(
                'Acerca de',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AcercaPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Bienvenido',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Text(
              'App de Denuncias y Asistencias Ciudadanas',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildIconButton('assets/policia.png', 'Policía Nacional Civil',
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PolicePage()),
                  );
                }),
                _buildIconButton('assets/cruz.png', 'Cruz Roja Salvadoreña',
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CruzPage()),
                  );
                }),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildIconButton(
                    'assets/bomberos.png', 'Bomberos de El Salvador', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BomberosPage()),
                  );
                }),
                _buildIconButton('assets/proteccion.png', 'Protección Civil',
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProteccionPage()),
                  );
                }),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(String imageAsset, String label, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(imageAsset, width: 60, height: 60),
              ),
            ),
            SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
