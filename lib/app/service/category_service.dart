import '../dao/category_dao.dart';
import '../model/category.dart';

class CategoryService {
  final CategoryDao _dao = CategoryDao();

  Future<List<CategoryTable>?> getCategoryLists() async {
    return _dao.getAll();
  }

  Future<CategoryTable?> getCategoryById(int id) async {
    return _dao.getById(id);
  }

  void createNewCategory(CategoryTable category) async {
    _dao.insert(category);
  }
}
