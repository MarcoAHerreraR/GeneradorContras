import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'variables.dart' as globales;

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 231, 231, 231)),
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
  bool connumeros = false,
  bool conespecial = false,
}){

  String contra= "";
  if (globales.conletras) contra += globales.mayus + globales.minus;
  if (globales.connumeros) contra+= globales.numeros;
  if (globales.conespecial) contra+= globales.especial;

  return List.generate(globales.tamano, (index) {
    final listarandome = Random.secure().nextInt(contra.length);
    return contra[listarandome];
  }).join("");
}

class _MyHomePageState extends State<MyHomePage> {
  final control = TextEditingController();
  final control1 = TextEditingController();
  bool swich = false; 

  @override
  void dispose() {
    control.dispose();
    control1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold (
    appBar: AppBar(  
    ),
    body: Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          if (globales.palabraespecial) TextField(
            controller: control1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Agregar numeros'),
              Switch(value: globales.connumeros, onChanged: (value) {setState(() {
             globales.connumeros = value;
          });}),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Agregar Caracteres especiales'),
              Switch(value: globales.conespecial, onChanged: (value) {setState(() {
             globales.conespecial = value;
          });}),
            ],
          ),Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Agregar palabra especial'),
              Switch(value: globales.palabraespecial, onChanged: (value) {setState(() {
             globales.palabraespecial = value;
          });}),
            ],
          ),
            
        ],
      ),
    ),
  );

  Widget construirboton() {
    final  colordefondo = MaterialStateColor.resolveWith((states) => states.contains(MaterialState.pressed)? const Color.fromARGB(255, 4, 133, 0) : const Color.fromARGB(255, 63, 194, 68));
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: colordefondo),
      onPressed:(){
      var contra = contragenerador();
      if (globales.palabraespecial) contra = control1.text + contragenerador();
      control.text = contra;
    } , child: const Text("Generar contraseña", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),));
  }
}