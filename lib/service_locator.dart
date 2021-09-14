import 'package:crypto_app/core/network/api_base_helper.dart';
import 'package:crypto_app/core/utils/strings.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:crypto_app/service_locator.config.dart';

final sl = GetIt.instance;

@injectableInit
Future<void> init(String environment) async =>
    $initGetIt(sl, environment: environment);

@Injectable()
@module
abstract class ThirdPartyServicesModule {
  @preResolve
  Future<Dio> get dio => DioInstance.getDio();
}

class DioInstance {
  static Future<Dio> getDio() async {
    final BaseOptions options = BaseOptions(
      baseUrl: Strings.baseUrl,
      connectTimeout: 60000,
      receiveTimeout: 60000,
      validateStatus: (status) {
        return status! < 500;
      },
    );
    Dio dio = Dio();
    dio.options = options;

    dio.interceptors.add(CustomInterceptor());

    return dio;
  }
}
