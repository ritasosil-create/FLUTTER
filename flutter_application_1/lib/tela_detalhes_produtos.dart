import 'package:flutter/material.dart';

class TelaDetalhesProduto extends StatefulWidget {
  final Map<String, dynamic>? produto;
  final int? codigo;
  final bool somenteVisualizacao;

  const TelaDetalhesProduto({
    super.key,
    this.produto,
    this.codigo,
    this.somenteVisualizacao = false,
  });

  @override
  State<TelaDetalhesProduto> createState() =>
      _TelaDetalhesProdutoState();
}

class _TelaDetalhesProdutoState
    extends State<TelaDetalhesProduto> {
  final descricaoController = TextEditingController();
  final tipoController = TextEditingController();
  final precoController = TextEditingController();
  final quantidadeController = TextEditingController();

  late int codigo;

  @override
  void initState() {
    super.initState();

    if (widget.produto != null) {
      codigo = widget.produto!['codigo'];

      descricaoController.text =
          widget.produto!['descricao'].toString();

      tipoController.text =
          widget.produto!['tipo'].toString();

      precoController.text =
          widget.produto!['preco'].toString();

      quantidadeController.text =
          widget.produto!['quantidade'].toString();
    } else {
      codigo = widget.codigo!;
    }
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
            'Preencha todos os campos corretamente.',
          ),
        ),
      );

      return;
    }

    Map<String, dynamic> produto = {
      'codigo': codigo,
      'descricao': descricaoController.text,
      'tipo': tipoController.text,
      'preco': preco,
      'quantidade': quantidade,
    };

    Navigator.pop(context, produto);
  }

  @override
  void dispose() {
    descricaoController.dispose();
    tipoController.dispose();
    precoController.dispose();
    quantidadeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String titulo;

    if (widget.somenteVisualizacao) {
      titulo = 'Detalhes do Produto';
    } else if (widget.produto != null) {
      titulo = 'Editar Produto';
    } else {
      titulo = 'Novo Produto';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                enabled: false,
                controller: TextEditingController(
                  text: codigo.toString(),
                ),
                decoration: const InputDecoration(
                  labelText: 'Código',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: descricaoController,
                enabled: !widget.somenteVisualizacao,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: tipoController,
                enabled: !widget.somenteVisualizacao,
                decoration: const InputDecoration(
                  labelText: 'Tipo',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: precoController,
                enabled: !widget.somenteVisualizacao,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  prefixText: 'R\$ ',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: quantidadeController,
                enabled: !widget.somenteVisualizacao,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantidade em estoque',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 24),

              if (!widget.somenteVisualizacao)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: salvar,
                    child: const Text('SALVAR'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}