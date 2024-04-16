import 'package:flutter/material.dart';
import 'package:avaliacao_pdm/listacompras.dart';
import 'package:avaliacao_pdm/login.dart';
import 'package:avaliacao_pdm/sobre.dart';

void main() {
  runApp(Aplicativo());
}

class Aplicativo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      initialRoute: '/',
      routes: {
        '/': (context) => PaginaLogin(),
        '/listaCompras': (context) => PaginaListaCompras(),
      },
    );
  }
}
