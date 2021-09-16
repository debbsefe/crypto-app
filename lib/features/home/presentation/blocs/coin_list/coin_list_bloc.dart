import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_app/features/home/data/models/coin_list_model.dart';
import 'package:crypto_app/features/home/domain/usecases/fetch_coin_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';
part 'coin_list_bloc.freezed.dart';

@LazySingleton()
class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  CoinListBloc(this.fetchCoinList) : super(const _Initial());
  final FetchCoinList fetchCoinList;

  @override
  Stream<CoinListState> mapEventToState(
    CoinListEvent event,
  ) async* {
    if (event is CoinListEvent) {
      ///yield loading
      yield const CoinListState.loading();

      /// call usecase
      final _failureOrSuccess =
          await fetchCoinList(Params(currency: event.currency, ids: event.ids));

      ///yield either failure or success depending on response
      yield _failureOrSuccess.fold(
        (failure) =>
            _Error(failure.message ?? 'Something went wrong, please try again'),
        (success) => _Loaded(success),
      );
    }
  }
}
