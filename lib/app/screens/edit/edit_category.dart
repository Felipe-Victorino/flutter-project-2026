import 'package:flutter/material.dart';
import 'package:flutter_project/app/service/category_service.dart';

import '../../model/category.dart';
import '../../widgets/container/page_container.dart';

class EditCategoryPage extends StatefulWidget {
  const EditCategoryPage({super.key, required this.category});

  final CategoryCloud category;

  @override
  State<StatefulWidget> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategoryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CategoryServiceCloud service = CategoryServiceCloud();

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
      CategoryCloud cat = CategoryCloud(
        id: widget.category.id,
        name: name,
        color: '',
      );
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
        child: PageContainer(
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
