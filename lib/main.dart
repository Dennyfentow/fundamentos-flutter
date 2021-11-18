import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  // const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  // const FormularioTransferencia({Key? key}) : super(key: key);
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Criando Transferência'),
        ),
        body: Column(
          children: [
            Editor(
                controlador: _controladorCampoNumeroConta,
                rotulo: 'Número da conta',
                dica: '0000'),
            Editor(
                dica: '0.00',
                rotulo: 'Valor',
                controlador: _controladorCampoValor,
                icone: Icons.monetization_on),
            ElevatedButton(
                child: Text('Confirmar'),
                onPressed: () => _criaTransferencia(context))
          ],
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('Criando transferência');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;
  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  final List<Transferencia> _transferencias = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
          itemCount: _transferencias.length,
          itemBuilder: (context, indice) {
            final transferencia = _transferencias[indice];
            return ItemTransferencia(transferencia);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia?> future = Navigator.push<Transferencia>(
              context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));

          future.then((transferenciRecebida) {
            debugPrint('Chegou no then do future');
            debugPrint('$transferenciRecebida');
            if (transferenciRecebida != null) {
              _transferencias.add(transferenciRecebida);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$transferenciRecebida'),
              ),
            );
          });
        },
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Tranferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
