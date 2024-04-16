import 'package:flutter/material.dart';
import 'sobre.dart';

class PaginaLogin extends StatelessWidget {
  TextEditingController _controladorEmail = TextEditingController();
  TextEditingController _controladorSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controladorEmail,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controladorSenha,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Senha'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    _mostrarDialogoEsqueceuSenha(context);
                  },
                  child: Text('Esqueci a senha'),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Verifica se os campos de email e senha estão preenchidos
                    if (_controladorEmail.text.isNotEmpty && _controladorSenha.text.isNotEmpty) {
                      // Se os campos estiverem preenchidos, faz a navegação para a próxima página
                      Navigator.pushReplacementNamed(context, '/listaCompras');
                    } else {
                      // Caso contrário, exibe uma mensagem de erro
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Por favor, preencha todos os campos.'),
                        ),
                      );
                    }
                  },
                  child: Text('Login'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaSobre()),
                );
              },
              child: Text(
                'Sobre',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoEsqueceuSenha(BuildContext context) {
    TextEditingController _controladorEmailEsqueceuSenha =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Esqueci a senha'),
          content: TextField(
            controller: _controladorEmailEsqueceuSenha,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Instruções de redefinição de senha enviadas para ${_controladorEmailEsqueceuSenha.text}'),
                  ),
                );
              },
              child: Text('Enviar'),
            ),
          ],
        );
      },
    );
  }
}
