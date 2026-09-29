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
  late final CategoryCloud _category;
  final CategoryServiceCloud service = CategoryServiceCloud();

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
      _category = CategoryCloud(name: name, color: '');
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
                  child: Text("Criar Categoria"),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Cancelling task"),
                          content: const SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                  'You are cancelling the creating of this category, this action will undo all progress and cannot be recovered,',
                                ),
                                Text('Are you sure you want to return?'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _cancel();
                              },
                              child: const Text("Yes, take me back"),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text("No, do not delete it"),
                            ),
                          ],
                        );
                      },
                    );
                  },
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
