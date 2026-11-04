// models/item_cardapio.dart

class ItemCardapio {
  final String nome;
  final double valor;
  const ItemCardapio(this.nome, this.valor);
}

class PedidoCompleto {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;
  final String pagamento;
  const PedidoCompleto({
    required this.prato,
    required this.bebida,
    required this.sobremesa,
    required this.pagamento,
  });
}

final List<PedidoCompleto> listaPedidosAtivos = [];