import 'package:flutter/material.dart';

import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  ListaTransferencias({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, indice) {
            final transferencia = widget._transferencias[indice];
            return ItemTransferencia(null, transferencia);
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push<Transferencia>(context,
              MaterialPageRoute(builder: (context) {
            return const FormularioTransferencia();
          })).then(
            (transferenciRecebida) => _atualiza(transferenciRecebida),
          );
        },
      ),
    );
  }

  void _atualiza(Transferencia? transferenciRecebida) {
    if (transferenciRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciRecebida);
      });
      // Future.delayed(const Duration(seconds: 1), () {
      //   debugPrint('Chegou no then do future: $transferenciRecebida');
      //   debugPrint('instancia de transferências: ' +
      //       widget._transferencias.length.toString());

      //   setState(() {
      //     widget._transferencias.add(transferenciRecebida);
      //   });
      // });

      // widget._transferencias.add(Transferencia(100.0, 1000));

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('$transferenciRecebida'),
      //   ),
      // );
    }
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(
    Key? key,
    this._transferencia,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}
