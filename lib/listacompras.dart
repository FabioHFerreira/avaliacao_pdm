import 'package:flutter/material.dart';

class PaginaListaCompras extends StatefulWidget {
  @override
  _PaginaListaComprasState createState() => _PaginaListaComprasState();
}

class _PaginaListaComprasState extends State<PaginaListaCompras> {
  List<ListaCompras> _listasCompras = [];

  TextEditingController _controladorNovoNomeLista = TextEditingController();
  TextEditingController _controladorPesquisa = TextEditingController();
  TextEditingController _controladorNovoItemNome = TextEditingController();
  TextEditingController _controladorNovoItemQuantidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Listas de Compras'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controladorPesquisa,
              decoration: InputDecoration(
                hintText: 'Pesquisar por item...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _listasCompras.length,
              itemBuilder: (context, indiceLista) {
                return ListTile(
                  title: Text(_listasCompras[indiceLista].nome),
                  onTap: () {
                    _mostrarOpcoesLista(indiceLista);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarDialogoNovaLista(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _mostrarDialogoNovaLista(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nova Lista de Compras'),
          content: TextField(
            controller: _controladorNovoNomeLista,
            decoration: InputDecoration(labelText: 'Nome da Lista'),
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
                setState(() {
                  _listasCompras.add(
                    ListaCompras(nome: _controladorNovoNomeLista.text, itens: []),
                  );
                });
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarOpcoesLista(int indiceLista) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_listasCompras[indiceLista].nome),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  _mostrarDialogoEditarLista(context, indiceLista);
                },
                child: Text('Editar Lista'),
              ),
              TextButton(
                onPressed: () {
                  _mostrarDialogoAdicionarItem(indiceLista);
                  Navigator.pop(context);
                },
                child: Text('Adicionar Item'),
              ),
              TextButton(
                onPressed: () {
                  _removerLista(indiceLista);
                  Navigator.pop(context);
                },
                child: Text('Excluir Lista'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarDialogoEditarLista(BuildContext context, int indiceLista) {
    TextEditingController controladorNomeLista =
        TextEditingController(text: _listasCompras[indiceLista].nome);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Lista de Compras'),
          content: TextField(
            controller: controladorNomeLista,
            decoration: InputDecoration(labelText: 'Novo Nome da Lista'),
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
                setState(() {
                  _listasCompras[indiceLista] = ListaCompras(nome: controladorNomeLista.text, itens: _listasCompras[indiceLista].itens);
                });
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoAdicionarItem(int indiceLista) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controladorNovoItemNome,
                decoration: InputDecoration(labelText: 'Nome do Item'),
              ),
              TextField(
                controller: _controladorNovoItemQuantidade,
                decoration: InputDecoration(labelText: 'Quantidade'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _listasCompras[indiceLista].itens.add(
                      ItemListaCompras(
                        nome: _controladorNovoItemNome.text,
                        quantidade: _controladorNovoItemQuantidade.text,
                      ),
                    );
                  });
                  Navigator.pop(context);
                },
                child: Text('Adicionar'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _removerLista(int indiceLista) {
    setState(() {
      _listasCompras.removeAt(indiceLista);
    });
  }
}

class ListaCompras {
  String nome;
  List<ItemListaCompras> itens;

  ListaCompras({required this.nome, required this.itens});
}

class ItemListaCompras {
  final String nome;
  final String quantidade;

  ItemListaCompras({required this.nome, required this.quantidade});
}
