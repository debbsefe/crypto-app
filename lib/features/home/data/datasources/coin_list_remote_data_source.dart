import 'package:crypto_app/core/network/api_client.dart';
import 'package:crypto_app/features/home/data/models/coin_list_model.dart';
import 'package:injectable/injectable.dart';

abstract class CoinListRemoteDataSource {
  Future<List<CoinListModel>> getCoinList(String ids, String currency);
}

@LazySingleton(as: CoinListRemoteDataSource)
class CoinListRemoteDataSourceImpl implements CoinListRemoteDataSource {
  final ApiClient client;

  CoinListRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<CoinListModel>> getCoinList(String ids, String currency) async {
    var result = await client.getCoinList(ids, currency);
    List<CoinListModel> coinList = [];
    result.forEach((k, v) => coinList.add(CoinListModel(coin: k, usd: v.usd)));
    return coinList;
  }
}
