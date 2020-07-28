abstract class CRUDInterface<T> {
  void get();

  void create(T body);

  void update(T body);

  void delete();
}
