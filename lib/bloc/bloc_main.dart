import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:searchable/bloc/bloc_base.dart';
import 'package:searchable/model/cliente.dart';

class BlocMain with BlocBase {
  BlocMain({@required this.clientes}) {
    ///Cria lista fixa com dados iniciais
    ///E já manda os dados para o sink [inCLiente]
    this.baseClientes = clientes;
    inCliente.add(clientes);
  }

  List<Cliente> clientes;
  List<Cliente> baseClientes;

  BehaviorSubject<List<Cliente>> _bhsCliente = BehaviorSubject<List<Cliente>>();
  Stream<List<Cliente>> get outCliente => _bhsCliente.stream;
  Sink<List<Cliente>> get inCliente => _bhsCliente.sink;

  ///Método sobrescrito a partir do BlocBase
  @override
  void dispose() {
    ///Para toda StreamController ou BehaviorSubject, é necessário chamar o [.close()]
    ///para parar de transmitir os dados pelos sinks
    _bhsCliente.close();
  }

  filterCliente(String nome) {
    if (nome.isEmpty) {
      ///se o termo pesquisado for branco, seta a lista inicial
      clientes = baseClientes;
    } else {
      ///senão faz um filtro seta em [clientes]
      clientes = baseClientes.where((c) => c.nome.contains(nome)).toList();
    }

    ///joga os dados no sink
    inCliente.add(clientes);
  }

  deleteCliente(Cliente cliente) {
    ///deleta dados de ambas as listas e pass o valor novamente para o inCliente que é um [sink]
    baseClientes.remove(cliente);
    clientes.remove(cliente);
    inCliente.add(clientes);
  }
}
