// telas/tela_sobremesa.dart

// ignore_for_file: deprecated_member_use

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'package:flutter/material.dart';
import 'tela_pagamento.dart';

const List<ItemCardapio> sobremesas = [
  ItemCardapio('Pedaço de bolo', 9.99),
  ItemCardapio('Pudim', 10.59),
  ItemCardapio('Sorvete de casquinha', 7.49),
];

class TelaSobremesa extends StatefulWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  const TelaSobremesa({super.key, required this.prato, required this.bebida});
  @override
  State<TelaSobremesa> createState() => _TelaSobremesaState();
}

class _TelaSobremesaState extends State<TelaSobremesa> {
  ItemCardapio? sobremesaSelecionada;
  void avancar() {
    final sobremesa = sobremesaSelecionada;
    if (sobremesa == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPagamento(
          prato: widget.prato,
          bebida: widget.bebida,
          sobremesa: sobremesa,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3. Sobremesa')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Escolha a sobremesa:'),
              const SizedBox(height: 16),
              Column(
                children: [
                  for (final sobremesa in sobremesas)
                    Container(
                      width: 320,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: sobremesaSelecionada == sobremesa
                              ? Colors.blue
                              : Colors.grey.shade700,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: RadioListTile<ItemCardapio>(
                        value: sobremesa,
                        groupValue: sobremesaSelecionada,
                        onChanged: (valor) =>
                            setState(() => sobremesaSelecionada = valor),
                        title: Text(sobremesa.nome),
                        subtitle: Text(formatarValor(sobremesa.valor)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: sobremesaSelecionada == null ? null : avancar,
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