// telas/tela_pagamento.dart

// ignore_for_file: deprecated_member_use

import '../models/item_cardapio.dart';
import 'package:flutter/material.dart';

import 'tela_finalizacao.dart';
const List<String> formasPagamento = [
  'Pix',
  'Cartão de crédito',
  'Cartão de débito',
  'Dinheiro',
];

class TelaPagamento extends StatefulWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;
  const TelaPagamento({
    super.key,
    required this.prato,
    required this.bebida,
    required this.sobremesa,
  });
  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();
}

class _TelaPagamentoState extends State<TelaPagamento> {
  String? pagamentoSelecionado;
  void avancar() {
    final pagamento = pagamentoSelecionado;
    if (pagamento == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaFinalizacao(
          prato: widget.prato,
          bebida: widget.bebida,
          sobremesa: widget.sobremesa,
          pagamento: pagamento,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4. Forma de pagamento')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Escolha a forma de pagamento:'),
              const SizedBox(height: 16),
              Column(
                children: [
                  for (final forma in formasPagamento)
                    Container(
                      width: 320,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: pagamentoSelecionado == forma
                              ? Colors.blue
                              : Colors.grey.shade700,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: RadioListTile<String>(
                        value: forma,
                        groupValue: pagamentoSelecionado,
                        onChanged: (valor) =>
                            setState(() => pagamentoSelecionado = valor),
                        title: Text(forma),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: pagamentoSelecionado == null ? null : avancar,
                child: const Text('Avançar'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Voltar'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () =>
                    Navigator.popUntil(context, (rota) => rota.isFirst),
                child: const Text('Voltar ao início'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}