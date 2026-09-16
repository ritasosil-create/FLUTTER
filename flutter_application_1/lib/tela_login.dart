
import 'package:flutter/material.dart';
import 'tela_principal.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final usuarioController = TextEditingController();
  final senhaController = TextEditingController();

  void entrar() {
    String usuario = usuarioController.text;
    String senha = senhaController.text;

    if (usuario == 'admin' && senha == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TelaPrincipal(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Usuário ou senha inválidos!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(
              Icons.person,
              size: 80,
            ),

            const SizedBox(height: 30),

            TextField(
              controller: usuarioController,
              decoration: const InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: entrar,
                child: const Text('ENTRAR'),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Usuário: admin\nSenha: 1234',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
```

