import 'dart:async';
import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'segunda.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await (Firebase.initializeApp());
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    print('Notificação recebida');
  }).onError((err) {
    print('Erro');
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: ('App_todo'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/tela1': (context) => TelaPrincipal(),
          '/tela2': (context) => SegundaTela(),
        },
        initialRoute: '/tela1',
        debugShowCheckedModeBanner: false,
        home: TelaPrincipal());
  }
}

class TelaPrincipal extends StatefulWidget {
  TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
  late DatabaseReference ref;
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  List<String> nomes = [];

  FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void InitState() {
    var ref = database.ref();
    super.initState();
  }

  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Lista de Tarefas')),
      ),
      body: ListView.builder(
          itemCount: nomes.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(title: Text(nomes[index])),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String? resposta = await Navigator.of(context)
                .pushNamed('/tela2', arguments: SegundaTela()) as String?;

            if (resposta != null) {
              setState(() {
                nomes.add(resposta);
              });
            }
          },
          child: const Icon(Icons.add)),
    );
    return scaffold;
  }
}
