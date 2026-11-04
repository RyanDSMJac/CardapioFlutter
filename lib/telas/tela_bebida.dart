// telas/tela_bebida.dart

// ignore_for_file: deprecated_member_use

import '../models/item_cardapio.dart';
import 'package:flutter/material.dart';
import '../utils/formatar_valor.dart';
import 'tela_sobremesa.dart';

const List<ItemCardapio> bebidas = [
  ItemCardapio('Suco de uva', 4.99),
  ItemCardapio('Coca-Cola 500ml', 5.99),
  ItemCardapio('Água', 0.99),
];

class TelaBebida extends StatefulWidget {
  final ItemCardapio prato;
  const TelaBebida({super.key, required this.prato});
  @override
  State<TelaBebida> createState() => _TelaBebidaState();
}

class _TelaBebidaState extends State<TelaBebida> {
  ItemCardapio? bebidaSelecionada;
  void avancar() {
    final bebida = bebidaSelecionada;
    if (bebida == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TelaSobremesa(prato: widget.prato, bebida: bebida),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2. Bebida')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Escolha a bebida:'),
              const SizedBox(height: 16),
              Column(
                children: [
                  for (final bebida in bebidas)
                    Container(
                      width: 320,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: bebidaSelecionada == bebida
                              ? Colors.blue
                              : Colors.grey.shade700,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: RadioListTile<ItemCardapio>(
                        value: bebida,
                        groupValue: bebidaSelecionada,
                        onChanged: (valor) =>
                            setState(() => bebidaSelecionada = valor),
                        title: Text(bebida.nome),
                        subtitle: Text(formatarValor(bebida.valor)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: bebidaSelecionada == null ? null : avancar,
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