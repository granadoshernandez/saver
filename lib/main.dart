import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prueba2/firebase_options.dart';
import 'package:prueba2/pages/home.dart';

/*
void main() {
  runApp(const MyApp());
}*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  void selectImage() {

  }
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => const Home(),
        //"/login": (context) => const Login(),
        //"/signup": (context) => const Signup(),
      },
      //home: const MyHomePage(title: 'PROYECTO SAVER'),
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void getPrueba() async {
 CollectionReference collectionReference = 
FirebaseFirestore.instance.collection("tb_prueba");
 QuerySnapshot mensajes = await collectionReference.get();
 if(mensajes.docs.length != 0){
 for (var doc in mensajes.docs){
 print(doc.data());
 //chatsx.add(doc.data());
 }
 }
 }
*/
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'PROYECTO APP DE DENUNCIAS:',
            ),
            
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
       child: const Icon(Icons.add),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
   @override
 void initState() {
 // TODO: implement initState
 super.initState();
 getPrueba();
 }

 @override
 void dispose() {
 // TODO: implement dispose
 super.dispose();
 }
}
*/
