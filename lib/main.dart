import 'dart:math';
//import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contras',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'prueba de generar contras'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String contragenerador({
  bool conletras = true,
  bool connumeros = true,
  bool conespecial = true,
}) {
  const tamano = 10;
  const mayus = "ABCDEFGHIJKLMNOPQRSTWYXZ";
  const minus = "abcdefghijklmnopqrstwyxz";
  const numeros = "1234567890";
  const especial = "!#&/()=?¡";

  String contra= "";
  if (conletras) contra += mayus + minus;
  if (connumeros) contra+= numeros;
  if (conespecial) contra+= especial;

  return List.generate(tamano, (index) {
    final listarandome = Random.secure().nextInt(tamano);
    return contra[listarandome];
  }).join("");
}

class _MyHomePageState extends State<MyHomePage> {
  final control = TextEditingController();

  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold (
    appBar: AppBar(  
    ),
    body: Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Generados de contraseñas aleatorias',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12,),
          TextField(
            controller: control,
            readOnly: true,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(icon: const Icon(Icons.copy),
              onPressed: () {
                final datos = ClipboardData(text: control.text);
                Clipboard.setData(datos);

                const barra = SnackBar (content: Text("Contraseña copiada",style: TextStyle(fontWeight: FontWeight.bold),));

                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(barra);
              } ,)
            ),
          ),
          const SizedBox(height: 12),
          construirboton(),
        ],
      ),
    ),
  );

  Widget construirboton() {
    final  colordefondo = MaterialStateColor.resolveWith((states) => states.contains(MaterialState.pressed)? Colors.lightGreen : Colors.green);
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: colordefondo),
      onPressed:(){
      final contra = contragenerador();
      control.text = contra;
    } , child: const Text("Generar contraseña"));
  }
}
