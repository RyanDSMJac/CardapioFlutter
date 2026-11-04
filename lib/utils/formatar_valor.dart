// utils/formatar_valor.dart

String formatarValor(double valor) {
  return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
}