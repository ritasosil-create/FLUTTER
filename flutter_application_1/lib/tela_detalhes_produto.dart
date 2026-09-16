// tela_detalhes_produto.dart
import 'package:flutter/material.dart';

class TelaDetalhesProduto extends StatelessWidget {
  final String nomeProduto;

  const TelaDetalhesProduto({super.key, required this.nomeProduto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do Produto')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Você selecionou: $nomeProduto'),
            ElevatedButton(
              child: Text('Voltar'),
              onPressed: () {
                Navigator.pop(context); // Retorna à tela anterior
              },
            ),
          ],
        ),
      ),
    );
  }
}