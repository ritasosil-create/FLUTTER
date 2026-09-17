import 'package:flutter/material.dart';
import 'tela_detalhes_produto2.dart'; // Importe a outra tela

class TelaListaProdutos extends StatelessWidget {
  final List<String> produtos = [
    'Produto A',
    'Produto B',
    'Produto C',
    'Produto D',
  ];

  TelaListaProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Produtos')),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(produtos[index]),
              onTap: () {
                // Navega para os detalhes do produto
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TelaDetalhesProduto(nomeProduto: produtos[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}