import 'package:flutter/material.dart';

class PaginaListaCompras extends StatefulWidget {
  @override
  _PaginaListaComprasState createState() => _PaginaListaComprasState();
}

class _PaginaListaComprasState extends State<PaginaListaCompras> {
  List<ListaCompras> _listasCompras = [
    ListaCompras(nome: 'Lista de Compras 1', itens: []),
    ListaCompras(nome: 'Lista de Compras 2', itens: []),
  ];

  TextEditingController _controladorNovoNomeLista = TextEditingController();
  TextEditingController _controladorPesquisa = TextEditingController();

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
              itemBuilder: (context, indice) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _listasCompras[indice].nome,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _listasCompras[indice].itens.length,
                      itemBuilder: (context, indiceItem) {
                        return ListTile(
                          title: Text(_listasCompras[indice]
                              .itens[indiceItem]
                              .nome),
                          subtitle: Text(_listasCompras[indice]
                              .itens[indiceItem]
                              .quantidade),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editarItem(indice, indiceItem);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _removerItem(indice, indiceItem);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Divider(),
                  ],
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

  void _editarItem(int indiceLista, int indiceItem) {
    // Implemente a lógica de edição do item aqui
    print('Editar item ${_listasCompras[indiceLista].itens[indiceItem].nome}');
  }

  void _removerItem(int indiceLista, int indiceItem) {
    setState(() {
      _listasCompras[indiceLista].itens.removeAt(indiceItem);
    });
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
}

class ListaCompras {
  final String nome;
  List<ItemListaCompras> itens;

  ListaCompras({required this.nome, required this.itens});
}

class ItemListaCompras {
  final String nome;
  final String quantidade;

  ItemListaCompras({required this.nome, required this.quantidade});
}

