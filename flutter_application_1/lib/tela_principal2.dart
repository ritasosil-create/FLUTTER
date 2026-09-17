import 'package:flutter/material.dart';
import 'tela_lista_produto.dart';

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela Principal')),
      body: Center(
        child: ElevatedButton(
          child: Text('Ir para Lista de Produtos'),
          onPressed: () {
            // Navegação para a próxima tela
            //Navigator.pushNamed(context, '/lista_produtos');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaListaProdutos()),
            );
          },
        ),
      ),
    );
  }
}
