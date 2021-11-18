class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(
    this.valor,
    this.numeroConta,
  );

  @override
  String toString() {
    return 'Tranferencia {valor: $valor, numeroConta: $numeroConta}';
  }
}
