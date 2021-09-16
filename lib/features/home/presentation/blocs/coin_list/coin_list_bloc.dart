import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_app/core/error/failures.dart';
import 'package:crypto_app/features/home/data/models/coin_list_model.dart';
import 'package:crypto_app/features/home/domain/usecases/fetch_coin_list.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';
part 'coin_list_bloc.freezed.dart';

@LazySingleton()
class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  CoinListBloc(this.usecase) : super(const _Initial());
  final FetchCoinList usecase;

  @override
  Stream<CoinListState> mapEventToState(
    CoinListEvent event,
  ) async* {
    if (event is CoinListEvent) {
      yield const CoinListState.loading();
      final _failureOrSuccess =
          await usecase(Params(currency: event.currency, ids: event.ids));
      yield* _eitherLoadedOrErrorState(_failureOrSuccess);
    }
  }

  Stream<CoinListState> _eitherLoadedOrErrorState(
    Either<Failure, List<CoinListModel>> failureOrSuccess,
  ) async* {
    yield failureOrSuccess.fold(
      (failure) => _Error(failure.message ?? 'unhandled'),
      (success) => _Loaded(success),
    );
  }
}