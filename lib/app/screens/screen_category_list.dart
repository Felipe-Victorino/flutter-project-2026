import 'package:flutter/material.dart';
import 'package:flutter_project/app/service/category_service.dart';
import 'package:flutter_project/app/widgets/category.dart';
import 'package:flutter_project/app/widgets/task.dart';

import '../model/category.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Future<List<CategoryTable>?>? _catList;
  final CategoryService service = CategoryService();

  void _refreshList() {
    setState(() {
      _catList = service.getCategoryLists();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(28),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .stretch,
        children: <Widget>[
          FutureBuilder(
            future: _catList,
            builder: (context, snapshot) {
              return Expanded(
                child: snapshot.data == null
                    ? EmptyList()
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            category: snapshot.data![index],
                            callback: () {
                              setState(() {
                                // This forces the parent widget to rebuild and
                                // pull the fresh, updated categories from the database!
                                _catList = service.getCategoryLists();
                              });
                            },
                          );
                        },
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
