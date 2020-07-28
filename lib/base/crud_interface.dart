abstract class CRUDInterface {
  void get();

  void create<T>(T body);

  void update<T>(T body);

  void delete();
}
