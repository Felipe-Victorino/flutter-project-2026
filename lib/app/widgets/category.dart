import 'package:flutter/material.dart';
import 'package:flutter_project/app/model/category.dart';
import 'package:flutter_project/app/screens/edit_category.dart';
import 'package:flutter_project/app/service/category_service.dart';

class CategoryCard extends StatefulWidget {
  final CategoryTable category;
  final Function callback;

  const CategoryCard({
    super.key,
    required this.category,
    required this.callback,
  });

  @override
  State<StatefulWidget> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  CategoryService service = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.start,
          spacing: 12,
          children: [
            Text(widget.category.name),
            Divider(),

            Wrap(
              spacing: 12,
              crossAxisAlignment: .center,
              runAlignment: .spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute<void>(
                        builder: (context) =>
                            EditCategoryPage(category: widget.category),
                      ),
                    );

                    widget.callback();
                  },
                  label: const Text("Editar"),
                  icon: const Icon(Icons.edit),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Removing a category"),
                          content: const SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                  'You are deleting this category permanently,',
                                ),
                                Text(
                                  'Are you sure you want to remove this task?',
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  print("Removing");
                                  service.deleteCategory(widget.category);
                                  widget.callback();
                                });

                                Navigator.pop(context);
                              },
                              child: const Text("Yes, delete task"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                widget.callback();
                              },
                              child: const Text("No, do not delete it"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  label: Text("Remover"),
                  icon: Icon(Icons.remove_circle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
