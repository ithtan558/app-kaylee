import 'package:anth_package/anth_package.dart' hide RepositoryProvider;
import 'package:kaylee/repositories/src/advertise/advertise_repository.dart';
import 'package:kaylee/repositories/src/advertise/advertise_repository_impl.dart';
import 'package:kaylee/repositories/src/knowledge/knowledge_repository.dart';
import 'package:kaylee/repositories/src/knowledge/knowledge_repository_impl.dart';
import 'package:kaylee/repositories/src/repository_provider.dart';
import 'package:kaylee/services/services.dart';

@Injectable(as: RepositoryProvider)
class RepositoryProviderImpl implements RepositoryProvider {
  final ServiceProvider _serviceProvider;

  RepositoryProviderImpl({required ServiceProvider serviceProvider})
      : _serviceProvider = serviceProvider;

  @override
  KnowledgeRepository get knowledge => KnowledgeRepositoryImpl(
      commonService: _serviceProvider.provideCommonService());

  @override
  AdvertiseRepository get advertise => AdvertiseRepositoryImpl(
        advertiseService: _serviceProvider.provideAdvertiseService(),
        commonService: _serviceProvider.provideCommonService(),
      );
}
