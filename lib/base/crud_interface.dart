abstract class CRUDInterface<T> {
  void get();

  void create<T>(T body);

  void update<T>(T body);

  void delete();
}
