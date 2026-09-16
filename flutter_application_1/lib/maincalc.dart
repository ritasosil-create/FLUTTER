import 'package:flutter/material.dart';

class CalculadoraIMC extends StatefulWidget {
  const CalculadoraIMC({super.key});

  @override
  _CalculadoraIMCState createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  String _resultado = "";

  void _calcularIMC() {
    // Converte os valores de texto para double e lida com possíveis erros de conversão.
    //final peso = double.tryParse(_pesoController.text);
    //final altura = double.tryParse(_alturaController.text);
    final peso = double.tryParse(_pesoController.text);
    final altura = double.tryParse(_alturaController.text);

    // Verifica se a conversão foi bem sucedida e se a altura não é zero para evitar divisão por zero.
    if (peso != null && altura != null && altura != 0) {
      // Calcula o IMC usando a fórmula: peso / (altura * altura).
      final imc = peso / (altura * altura);
      // Atualiza o estado para exibir o resultado formatado.
      setState(() {
        _resultado = "Seu IMC é: ${imc.toStringAsFixed(2)}"; // Formata para duas casas decimais.
      });
    } else {
      // Se houver erro na conversão ou altura for zero, exibe uma mensagem de erro.
      setState(() {
        _resultado = "Por favor, insira valores válidos para peso e altura.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Campo de texto para o peso.
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.numberWithOptions(decimal: true), // Permite apenas números decimais.
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            // Campo de texto para a altura.
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.numberWithOptions(decimal: true), // Permite apenas números decimais.
              decoration: InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24.0),
            // Botão para calcular o IMC.
            ElevatedButton(
              onPressed: _calcularIMC, // Chama a função _calcularIMC ao pressionar.
              child: Text("Calcular IMC"),
            ),
            SizedBox(height: 24.0),
            // Exibe o resultado do IMC.
            Text(
              _resultado,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CalculadoraIMC(),
  ));
}
