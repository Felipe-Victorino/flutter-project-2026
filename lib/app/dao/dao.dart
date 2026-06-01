abstract class Dao<T> {
  Future<int> insert(T t);

  Future<List<T>?> getAll();

  Future<T?> getById(int id);

  Future<void> update(T t);

  Future<void> remove(int id);
}
