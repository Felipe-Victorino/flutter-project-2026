import 'package:flutter/material.dart';
import 'package:flutter_project/app/service/category_service.dart';

import '../model/category.dart';

class EditCategoryPage extends StatefulWidget {
  const EditCategoryPage({super.key, required this.category});

  final CategoryTable category;

  @override
  State<StatefulWidget> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategoryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CategoryService service = CategoryService();

  late String name;

  TextEditingController txtcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtcontroller = TextEditingController(text: widget.category.name);
  }

  @override
  void dispose() {
    txtcontroller.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      name = txtcontroller.text;
      CategoryTable cat = CategoryTable(id: widget.category.id, name: name);
      await service.updateCategory(cat);
      Navigator.pop(context);
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
      ),
    );
  }
}
