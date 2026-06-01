import 'package:flutter/material.dart';
import 'package:flutter_project/app/dao/task_category.dart';
import 'package:flutter_project/app/service/category_service.dart';
import 'package:flutter_project/app/service/task_service.dart';

import '../model/category.dart';
import '../model/task.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: NewTaskForm());
  }
}

class NewTaskForm extends StatefulWidget {
  const NewTaskForm({super.key});

  @override
  State<StatefulWidget> createState() => _NewTaskForm();
}

typedef MenuEntry = DropdownMenuEntry<CategoryTable>;

class _NewTaskForm extends State<NewTaskForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  final TaskService _taskService = TaskService();
  final CategoryService _catService = CategoryService();
  final TaskCategoryDao _tcdao = TaskCategoryDao();

  late String _title;
  late String _description;
  final bool _isCompleted = false;
  final DateTime _createTime = DateTime.now();
  late DateTime _endTime;

  late Future<List<CategoryTable>?> _categoriesFuture;
  final List<CategoryTable> _selectedCategories = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _catService.getCategoryLists();
  }

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    descriptioncontroller.dispose();
  }

  Future<void> _submitTask() async {
    _formKey.currentState!.validate();
    _title = namecontroller.text;
    _description = descriptioncontroller.text;

    TaskTable task = TaskTable(
      title: _title,
      description: _description,
      isCompleted: _isCompleted,
      createTime: _createTime.toIso8601String(),
      endTime: _endTime.toIso8601String(),
    );

    int taskId = await _taskService.createNewTask(task);

    task.categories = _selectedCategories;
    for (CategoryTable ct in _selectedCategories) {
      await _tcdao.linkCategoryToTask(taskId, ct);
      print("Link ${ct.toString()} to task ${task.id}");
    }

    print(task.toString());

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
        padding: EdgeInsetsGeometry.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: <Widget>[
            Text(
              "Nova Tarefa",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            TextFormField(
              controller: namecontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Task Title',
              ),
              onSaved: (String? s) {
                setState(() {
                  _title = namecontroller.text;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha esse campo com texto';
                }
                return null;
              },
            ),
            TextFormField(
              maxLines: 7,
              controller: descriptioncontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Descrição da tarefa',
              ),
              onSaved: (String? s) {
                setState(() {
                  _description = descriptioncontroller.text;
                });
              },

              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha esse campo com texto';
                }
                return null;
              },
            ),
            FutureBuilder(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                return Wrap(
                  spacing: 6,
                  children: snapshot.data != null
                      ? snapshot.data!
                            .map<Widget>(
                              (CategoryTable cat) => FilterChip(
                                label: Text(cat.name),
                                selected: _selectedCategories.any(
                                  (selectedCat) => cat.id == selectedCat.id,
                                ),
                                onSelected: (bool selected) {
                                  print(selected.toString());
                                  print(cat.toString());
                                  setState(() {
                                    print(_selectedCategories.contains(cat));
                                    if (selected) {
                                      _selectedCategories.add(cat);
                                    } else {
                                      _selectedCategories.remove(cat);
                                    }
                                  });
                                },
                              ),
                            )
                            .toList()
                      : <Widget>[
                          FilterChip(
                            label: Text("No categories..."),
                            onSelected: null,
                          ),
                        ],
                );
              },
            ),
            ElevatedButton.icon(
              onPressed: () {},
              label: Text("New"),
              icon: Icon(Icons.add),
            ),

            /*Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                FutureBuilder(
                  future: _categoriesList,
                  builder: (context, snapshot) {
                    return DropdownMenu<CategoryTable>(
                      hintText: "Category",
                      width: null,

                      enableFilter: true,
                      requestFocusOnTap: false,
                      dropdownMenuEntries: UnmodifiableListView<MenuEntry>(
                        snapshot.data!.map(
                          (CategoryTable cat) =>
                              MenuEntry(value: cat, label: cat.name),
                        ),
                      ),
                      onSelected: (CategoryTable? cat) {
                        setState(() {
                          String catstring = cat.toString();

                          _selectedCategories = cat;
                          catstring = _selectedCategories.toString();
                        });
                      },
                    );
                  },
                ),

              ],
            ),*/
            InputDatePickerFormField(
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              errorFormatText: 'Wrong date format',
              onDateSubmitted: (date) {
                setState(() {
                  _endTime = date;
                });
              },
              onDateSaved: (date) {
                setState(() {
                  _endTime = date;
                });
              },
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                ElevatedButton(
                  onPressed: _submitTask,
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.green),
                  ),
                  child: Text("Criar Tarefa"),
                ),
                ElevatedButton(
                  onPressed: _exit,
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
