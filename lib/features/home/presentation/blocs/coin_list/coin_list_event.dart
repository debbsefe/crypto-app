part of 'coin_list_bloc.dart';

@freezed
class CoinListEvent with _$CoinListEvent {
  const factory CoinListEvent.started(
      {required String currency, required String ids}) = Started;
}
