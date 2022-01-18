import 'package:kaylee/repositories/repositories.dart';

abstract class RepositoryProvider {
  KnowledgeRepository get knowledge;

  AdvertiseRepository get advertise;
}
