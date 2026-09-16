
import 'package:flutter/material.dart';
import 'tela_produtos.dart';

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Principal'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(
              Icons.inventory,
              size: 100,
            ),

            const SizedBox(height: 20),

            const Text(
              'Sistema de Produtos',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              icon: const Icon(Icons.shopping_cart),
              label: const Text('LISTA DE PRODUTOS'),

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaProdutos(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```
