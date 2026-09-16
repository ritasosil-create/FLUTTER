```dart
import 'package:flutter/material.dart';

class TelaDetalheProduto extends StatefulWidget {

  final Map<String, dynamic>? produto;

  final int? proximoCodigo;

  final bool somenteVisualizacao;

  const TelaDetalheProduto({
    super.key,
    this.produto,
    this.proximoCodigo,
    this.somenteVisualizacao = false,
  });

  @override
  State<TelaDetalheProduto> createState() =>
      _TelaDetalheProdutoState();
}

class _TelaDetalheProdutoState
    extends State<TelaDetalheProduto> {

  late TextEditingController codigoController;
  late TextEditingController descricaoController;
  late TextEditingController tipoController;
  late TextEditingController precoController;
  late TextEditingController quantidadeController;

  @override
  void initState() {
    super.initState();

    codigoController = TextEditingController(
      text: widget.produto?['codigo']?.toString()
          ?? widget.proximoCodigo?.toString()
          ?? '',
    );

    descricaoController = TextEditingController(
      text: widget.produto?['descricao']?.toString() ?? '',
    );

    tipoController = TextEditingController(
      text: widget.produto?['tipo']?.toString() ?? '',
    );

    precoController = TextEditingController(
      text: widget.produto?['preco']?.toString() ?? '',
    );

    quantidadeController = TextEditingController(
      text: widget.produto?['quantidade']?.toString() ?? '',
    );
  }

  @override
  void dispose() {

    codigoController.dispose();
    descricaoController.dispose();
    tipoController.dispose();
    precoController.dispose();
    quantidadeController.dispose();

    super.dispose();
  }

  void salvar() {

    double? preco = double.tryParse(
      precoController.text.replaceAll(',', '.'),
    );

    int? quantidade = int.tryParse(
      quantidadeController.text,
    );

    if (descricaoController.text.isEmpty ||
        tipoController.text.isEmpty ||
        preco == null ||
        quantidade == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha todos os campos corretamente!',
          ),
        ),
      );

      return;
    }

    Map<String, dynamic> produto = {

      'codigo': int.tryParse(
        codigoController.text,
      ) ?? 0,

      'descricao': descricaoController.text,

      'tipo': tipoController.text,

      'preco': preco,

      'quantidade': quantidade,
    };

    Navigator.pop(
      context,
      produto,
    );
  }

  @override
  Widget build(BuildContext context) {

    bool editando = widget.produto != null;

    return Scaffold(

      appBar: AppBar(
        title: Text(
          widget.somenteVisualizacao
              ? 'Detalhes do Produto'
              : editando
                  ? 'Editar Produto'
                  : 'Novo Produto',
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: codigoController,

              enabled: false,

              decoration: const InputDecoration(
                labelText: 'Código',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.tag),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: descricaoController,

              enabled: !widget.somenteVisualizacao,

              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: tipoController,

              enabled: !widget.somenteVisualizacao,

              decoration: const InputDecoration(
                labelText: 'Tipo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: precoController,

              enabled: !widget.somenteVisualizacao,

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(
                labelText: 'Preço',
                hintText: 'Ex.: 100,50',
                prefixText: 'R\$ ',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: quantidadeController,

              enabled: !widget.somenteVisualizacao,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                labelText: 'Quantidade em Estoque',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.inventory),
              ),
            ),

            const SizedBox(height: 25),

            if (!widget.somenteVisualizacao)

              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(

                  onPressed: salvar,

                  icon: const Icon(Icons.save),

                  label: Text(
                    editando
                        ? 'SALVAR ALTERAÇÕES'
                        : 'CADASTRAR PRODUTO',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
```

```
