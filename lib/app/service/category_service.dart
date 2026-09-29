import 'package:flutter_project/app/dao/task_category.dart';

import '../dao/category_dao.dart';
import '../model/category.dart';
import '../model/task.dart';

class CategoryServiceCloud {
  final CategoryDaoCloud _dao = CategoryDaoCloud();

  Future<List<CategoryCloud?>> getAll() async {
    return await _dao.getAll();
  }

  Future<String> createNewCategory(CategoryCloud category) async {
    return await _dao.insert(category);
  }

  Future<CategoryCloud?> getById(String id) async {
    return await _dao.getById(id);
  }

  Future<String> deleteCategory(String id) async {
    return await _dao.remove(id);
  }

  Future<String> updateCategory(CategoryCloud category) async {
    return await _dao.update(category);
  }
}

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
