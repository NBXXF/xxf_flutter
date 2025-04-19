import 'package:get_it/get_it.dart' show GetIt;

///简化依赖注入
final GetIt getIt = GetIt.instance;

extension GetItExtensions on GetIt {
  ///内部会判断有没有注册
  T? tryGet<T extends Object>({String? instanceName}) {
    if (isRegistered<T>(instanceName: instanceName)) {
      return get<T>(instanceName: instanceName);
    }
    return null;
  }
}
