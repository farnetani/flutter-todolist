import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To-Do List',
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHome> {
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List _tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Form(
              key: _formKey,
              child: Row(children: <Widget>[
                Expanded(
                  child: TextFormField(
                      controller: taskController,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                      decoration: const InputDecoration(
                          hintText: "Digite a sua tarefa...",
                          hintStyle: TextStyle(fontSize: 14)),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Tarefa é requerida!';
                        }
                        return null;
                      }),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processando Dados...')),
                        );
                      }
                      debugPrint('Cliquei');
                      debugPrint(taskController.text);
                      setState(() {
                        _tasks.add(taskController.text);
                      });
                      taskController.clear();
                    },
                    child:
                        const Text('Adicionar', style: TextStyle(fontSize: 16)),
                  ),
                )
              ]),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_tasks[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _tasks.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
