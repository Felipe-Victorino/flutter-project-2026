import 'package:flutter/material.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(child: NewTaskForm());
  }
}

class NewTaskForm extends StatefulWidget {
  const NewTaskForm({super.key});

  @override
  State<StatefulWidget> createState() => _NewTaskForm();
}

class _NewTaskForm extends State<NewTaskForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitTask() {
    print("Submmiting");
    Navigator.pop(context);
  }

  void _exit() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsetsGeometry.all(42),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Nova Tarefa",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Título da tarefa'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Insira algum texto';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Descrição da tarefa',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Insira algum texto';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _submitTask,
                  child: Text("Criar Tarefa"),
                ),
                ElevatedButton(onPressed: _exit, child: Text("Cancelar")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
