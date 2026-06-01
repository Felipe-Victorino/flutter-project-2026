import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/app/service/category_service.dart';

import '../model/category.dart';

class CreateCategoryPage extends StatelessWidget {
  const CreateCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: NewCategory());
  }
}

class NewCategory extends StatefulWidget {
  const NewCategory({super.key});

  @override
  State<StatefulWidget> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final CategoryTable _category;
  final CategoryService service = CategoryService();

  late String name;

  TextEditingController txtcontroller = TextEditingController();

  @override
  void dispose() {
    txtcontroller.dispose();
    super.dispose();
  }

  void _submit() {
    name = txtcontroller.text;
    if (kDebugMode) {
      print(name);
    }
    if (_formKey.currentState!.validate()) {
      _category = CategoryTable(name: name);
      service.createNewCategory(_category);
      Navigator.pop(context);
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsetsGeometry.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: <Widget>[
            Text(
              "Nova Categoria",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            TextFormField(
              controller: txtcontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Título da categoria',
              ),
              onChanged: (String s) {
                setState(() {
                  name = txtcontroller.text;
                });
              },
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
                  onPressed: _submit,
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.green),
                  ),
                  child: Text("Criar Tarefa"),
                ),
                ElevatedButton(
                  onPressed: _cancel,
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.error,
                    ),
                  ),
                  child: Text("Cancelar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
