import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:provider/provider.dart';
import 'package:searchable/bloc/bloc_main.dart';
import 'package:searchable/model/cliente.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: "Sauçp");
  }

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Scaffold ZYW'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Card(
              elevation: 2,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Pesquisa por nome",
                  hintText: "Saulo",
                  suffix: IconButton(
                    icon: Icon(Icons.search),
                    ///no onPressed, chama o evento filteCliente que está no [BlocMain]
                    ///usando o valor do [controller]
                    onPressed: () => b.filterCliente(controller.value.text),
                  ),
                ),
              ),
            ),
            StreamObserver(
              stream: b.outCliente,
              onSuccess: (_, List<Cliente> clientes) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: clientes.length,
                  itemBuilder: (_, int i) {
                    final cliente = clientes[i];
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text(cliente.nome),
                      subtitle: Text("Salário: ${cliente.salario} R\$"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_sweep, color: Colors.red),
                        ///no onPressed chama o evento deleteCliente que está no [BlocMain]
                        ///passando o [cliente] como parametro
                        onPressed: () => b.deleteCliente(cliente),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
