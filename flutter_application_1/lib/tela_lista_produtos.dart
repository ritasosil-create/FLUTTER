import 'package:flutter/material.dart';
import 'tela_detalhes_produtos.dart';

class TelaListaProdutos extends StatefulWidget {
  const TelaListaProdutos({super.key});

  @override
  State<TelaListaProdutos> createState() => _TelaListaProdutosState();
}

class _TelaListaProdutosState extends State<TelaListaProdutos> {
  final buscaController = TextEditingController();

  List<Map<String, dynamic>> produtos = [
    {
      'codigo': 1,
      'descricao': 'Teclado',
      'tipo': 'Informática',
      'preco': 100.00,
      'quantidade': 10,
    },
    {
      'codigo': 2,
      'descricao': 'Mouse',
      'tipo': 'Informática',
      'preco': 50.00,
      'quantidade': 20,
    },
    {
      'codigo': 3,
      'descricao': 'Monitor',
      'tipo': 'Informática',
      'preco': 800.00,
      'quantidade': 5,
    },
  ];

  List<Map<String, dynamic>> get produtosFiltrados {
    String busca = buscaController.text.toLowerCase();

    return produtos.where((produto) {
      return produto['descricao']
          .toString()
          .toLowerCase()
          .contains(busca);
    }).toList();
  }

  void adicionarProduto() async {
    int proximoCodigo = produtos.isEmpty
        ? 1
        : produtos
                .map((produto) => produto['codigo'] as int)
                .reduce((a, b) => a > b ? a : b) +
            1;

    final novoProduto = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaDetalhesProduto(
          codigo: proximoCodigo,
        ),
      ),
    );

    if (novoProduto != null) {
      setState(() {
        produtos.add(novoProduto);
      });
    }
  }

  void editarProduto(Map<String, dynamic> produto) async {
    final produtoEditado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaDetalhesProduto(
          produto: produto,
        ),
      ),
    );

    if (produtoEditado != null) {
      setState(() {
        int indice = produtos.indexOf(produto);
        produtos[indice] = produtoEditado;
      });
    }
  }

  void excluirProduto(Map<String, dynamic> produto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir produto'),
          content: Text(
            'Deseja excluir o produto ${produto['descricao']}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  produtos.remove(produto);
                });

                Navigator.pop(context);
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: buscaController,
              onChanged: (valor) {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Buscar produto',
                hintText: 'Digite a descrição',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Expanded(
            child: produtosFiltrados.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum produto encontrado.',
                    ),
                  )
                : ListView.builder(
                    itemCount: produtosFiltrados.length,
                    itemBuilder: (context, index) {
                      final produto = produtosFiltrados[index];

                      return Card(
                        child: ListTile(
                          title: Text(
                            produto['descricao'],
                          ),
                          subtitle: Text(
                            'Código: ${produto['codigo']}\n'
                            'Tipo: ${produto['tipo']}\n'
                            'Preço: R\$ ${produto['preco'].toStringAsFixed(2)}\n'
                            'Estoque: ${produto['quantidade']}',
                          ),
                          isThreeLine: true,

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TelaDetalhesProduto(
                                  produto: produto,
                                  somenteVisualizacao: true,
                                ),
                              ),
                            );
                          },

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  editarProduto(produto);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  excluirProduto(produto);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: adicionarProduto,
        child: const Icon(Icons.add),
      ),
    );
  }
}