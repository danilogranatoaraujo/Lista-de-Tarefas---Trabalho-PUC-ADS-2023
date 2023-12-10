import 'package:flutter/material.dart';

void main() {
  runApp(AplicativoTarefas());
}

class AplicativoTarefas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TelaListaTarefas(),
    );
  }
}

class Tarefa {
  final String titulo;
  final String descricao;
  bool estaCompleta;

  Tarefa({
    required this.titulo,
    required this.descricao,
    this.estaCompleta = false,
  });
}

class TelaListaTarefas extends StatefulWidget {
  @override
  _TelaListaTarefasState createState() => _TelaListaTarefasState();
}

class _TelaListaTarefasState extends State<TelaListaTarefas> {
  final List<Tarefa> tarefas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(tarefas[index].titulo),
            subtitle: Text(tarefas[index].descricao),
            trailing: Checkbox(
              value: tarefas[index].estaCompleta,
              onChanged: (bool? valor) {
                setState(() {
                  tarefas[index].estaCompleta = valor ?? false;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navegarParaAdicionarTarefa();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navegarParaAdicionarTarefa() async {
    Tarefa? novaTarefa = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaAdicionarTarefa()),
    );

    if (novaTarefa != null) {
      setState(() {
        tarefas.add(novaTarefa);
      });
    }
  }
}

class TelaAdicionarTarefa extends StatelessWidget {
  final TextEditingController controladorTitulo = TextEditingController();
  final TextEditingController controladorDescricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: controladorTitulo,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextFormField(
              controller: controladorDescricao,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            ElevatedButton(
              onPressed: () {
                Tarefa novaTarefa = Tarefa(
                  titulo: controladorTitulo.text,
                  descricao: controladorDescricao.text,
                );
                Navigator.pop(context, novaTarefa);
              },
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
