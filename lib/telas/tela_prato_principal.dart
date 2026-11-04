// telas/tela_prato_principal.dart

// ignore_for_file: deprecated_member_use

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'package:flutter/material.dart';

import 'tela_bebida.dart';

const List<ItemCardapio> pratosPrincipais = [
  ItemCardapio('Macarrão', 16.99),
  ItemCardapio('Carne de porco', 18.89),
  ItemCardapio('Frango assado', 24.49),
];

class TelaPratoPrincipal extends StatefulWidget {
  const TelaPratoPrincipal({super.key});
  @override
  State<TelaPratoPrincipal> createState() => _TelaPratoPrincipalState();
}

class _TelaPratoPrincipalState extends State<TelaPratoPrincipal> {
  ItemCardapio? pratoSelecionado;
  void avancar() {
    final prato = pratoSelecionado;
    if (prato == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaBebida(prato: prato)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1. Prato principal')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Escolha o prato principal:'),
              const SizedBox(height: 16),
              Column(
                children: [
                  for (final prato in pratosPrincipais)
                    Container(
                      width: 320,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: pratoSelecionado == prato
                              ? Colors.blue
                              : Colors.grey.shade700,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: RadioListTile<ItemCardapio>(
                        value: prato,
                        groupValue: pratoSelecionado,
                        onChanged: (valor) =>
                            setState(() => pratoSelecionado = valor),
                        title: Text(prato.nome),
                        subtitle: Text(formatarValor(prato.valor)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: pratoSelecionado == null ? null : avancar,
                child: const Text('Avançar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}