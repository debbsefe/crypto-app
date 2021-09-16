import 'package:crypto_app/core/error/failures.dart';
import 'package:crypto_app/features/home/data/datasources/coin_list_remote_data_source.dart';
import 'package:crypto_app/features/home/data/models/coin_list_model.dart';
import 'package:crypto_app/features/home/domain/repositories/coin_list_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: CoinListRepository, env: [Environment.prod])
class CoinListRepositoryImpl implements CoinListRepository {
  final CoinListRemoteDataSource remote;

  CoinListRepositoryImpl({
    required this.remote,
  });

  @override
  Future<Either<Failure, List<CoinListModel>>> fetchCoinList(
      {required String ids, required String currency}) async {
    try {
      final model = await remote.getCoinList(ids, currency);
      return (Right(model));
    } on DioError catch (error) {
      return Left(error.toFailure());
    }
  }
}
