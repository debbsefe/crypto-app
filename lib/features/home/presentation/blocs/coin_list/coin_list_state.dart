part of 'coin_list_bloc.dart';

@freezed
class CoinListState with _$CoinListState {
  const factory CoinListState.initial() = _Initial;
  const factory CoinListState.loading() = _Loading;
  const factory CoinListState.loaded(List<CoinListModel> content) = _Loaded;
  const factory CoinListState.error(String message) = _Error;
}
