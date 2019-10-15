import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable/bloc/bloc_main.dart';
import 'package:searchable/model/cliente.dart';
import 'package:searchable/pages/home.dart';

class Searchable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Searchable',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
        accentColor: Colors.pink,
        brightness: Brightness.light,
      ),
      ///É convenção embalar o primeiro widget dentro de um [Provider]
      ///assim fica fácil acessar o BlocMain por qualquer widget desenhado daqui para baixo
      home: Provider(
        builder: (context) => BlocMain(clientes: <Cliente>[
          ///Aqui eu estou preenchendo os dados manualmente, mas você poderia carregar ele do sqlite, do firebase, ou de onde quiser
          ///Então você passa os dados do banco direto pro bloc
          Cliente(
            nome: "Saulo",
            sobrenome: "Andrioli",
            salario: 1500.0,
            nascto: DateTime(1988, 5, 17),
          ),
          Cliente(
            nome: "Josefina",
            sobrenome: "Paduan",
            salario: 2300.56,
            nascto: DateTime(1967, 2, 5),
          ),
          Cliente(
            nome: "Iraci",
            sobrenome: "Paduan",
            salario: 1800.99,
            nascto: DateTime(1961, 10, 17),
          ),
        ]),
        dispose: (_, BlocMain b) {
          ///Chama método [dispose()] que está no [BlocMain]
          ///assim fechando todos os sinks que estiverem abertos
          b.dispose();
        },
        child: Home(),
      ),
    );
  }
}
