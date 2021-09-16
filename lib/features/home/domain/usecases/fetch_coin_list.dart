import 'package:crypto_app/core/error/failures.dart';
import 'package:crypto_app/core/usecases/usecase.dart';
import 'package:crypto_app/features/home/data/models/coin_list_model.dart';
import 'package:crypto_app/features/home/domain/repositories/coin_list_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FetchCoinList extends UseCase<List<CoinListModel>, Params> {
  FetchCoinList(this.repository);

  final CoinListRepository repository;

  @override
  Future<Either<Failure, List<CoinListModel>>> call(Params params) async {
    return await repository.fetchCoinList(
        currency: params.currency, ids: params.ids);
  }
}

class Params extends Equatable {
  final String currency;
  final String ids;

  const Params({required this.currency, required this.ids});
  @override
  List<Object?> get props => throw UnimplementedError();
}
