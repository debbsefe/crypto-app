import 'package:crypto_app/core/network/custom_interceptor.dart';
import 'package:crypto_app/core/utils/strings.dart';
import 'package:crypto_app/features/home/data/models/coin_list_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: Strings.baseUrl)
abstract class ApiClient {
  static Future<ApiClient> getInstance() async {
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

    return ApiClient(dio, baseUrl: Strings.baseUrl);
  }

  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/simple/price")
  Future<Map<String, Coin>> getCoinList(
    @Query("ids") String ids,
    @Query("vs_currencies") String currency,
  );
}
