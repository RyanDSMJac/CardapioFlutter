// telas/tela_finalizacao.dart

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'package:flutter/material.dart';
import 'tela_prato_principal.dart';

class TelaFinalizacao extends StatefulWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;
  final String pagamento;
  const TelaFinalizacao({
    super.key,
    required this.prato,
    required this.bebida,
    required this.sobremesa,
    required this.pagamento,
  });

  @override
  State<TelaFinalizacao> createState() => _TelaFinalizacaoState();
}

class _TelaFinalizacaoState extends State<TelaFinalizacao> {
  @override
  void initState() {
    super.initState();
    if (listaPedidosAtivos.length < 3) {
      listaPedidosAtivos.add(
        PedidoCompleto(
          prato: widget.prato,
          bebida: widget.bebida,
          sobremesa: widget.sobremesa,
          pagamento: widget.pagamento,
        ),
      );
    }
  }

  void novoPedido(BuildContext context) {
    if (listaPedidosAtivos.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Limite máximo de 3 pedidos atingido!'),
        ),
      );
      return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TelaPratoPrincipal()),
      (rota) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.prato.valor + widget.bebida.valor + widget.sobremesa.valor;
    final atingiuLimite = listaPedidosAtivos.length >= 3;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('5. Finalização do pedido'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Prato: ${widget.prato.nome} - ${formatarValor(widget.prato.valor)}'),
                Text('Bebida: ${widget.bebida.nome} - ${formatarValor(widget.bebida.valor)}'),
                Text(
                  'Sobremesa: ${widget.sobremesa.nome} - ${formatarValor(widget.sobremesa.valor)}',
                ),
                const SizedBox(height: 16),
                Text(
                  'Total: ${formatarValor(total)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text('Pagamento: ${widget.pagamento}'),
                const SizedBox(height: 24),
                const Divider(),
                const Text(
                  'Pedidos Ativos (Máximo 3):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                for (int i = 0; i < listaPedidosAtivos.length; i++)
                  Container(
                    width: 340,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade700),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Pedido ${i + 1}: ${listaPedidosAtivos[i].prato.nome}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              listaPedidosAtivos.removeAt(i);
                            });
                          },
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: atingiuLimite ? null : () => novoPedido(context),
                  child: const Text('Novo pedido'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}