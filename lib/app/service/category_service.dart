import 'package:flutter_project/app/dao/task_category.dart';

import '../dao/category_dao.dart';
import '../model/category.dart';
import '../model/task.dart';

class CategoryService {
  final CategoryDao _dao = CategoryDao();
  final TaskCategoryDao _tcdao = TaskCategoryDao();

  Future<List<CategoryTable>?> getCategoryLists() async {
    return _dao.getAll();
  }

  Future<CategoryTable?> getCategoryById(int id) async {
    return _dao.getById(id);
  }

  void createNewCategory(CategoryTable category) async {
    _dao.insert(category);
  }

  Future<void> deleteCategory(CategoryTable cat) async {
    List<TaskTable> tasks = await _tcdao.getTasksForCategory(cat);
    for (TaskTable t in tasks) {
      _tcdao.unlinkCategoryFromTask(t, cat);
    }
    _dao.remove(cat.id!);
  }

  Future<void> updateCategory(CategoryTable cat) async {
    _dao.update(cat);
  }
}
