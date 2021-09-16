import 'package:crypto_app/core/error/failures.dart';
import 'package:crypto_app/features/home/data/models/coin_list_model.dart';
import 'package:dartz/dartz.dart';

abstract class CoinListRepository {
  Future<Either<Failure, List<CoinListModel>>> fetchCoinList(
      {required String ids, required String currency});
}
