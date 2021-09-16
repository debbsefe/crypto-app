// To parse this JSON data, do
//
//     final coinListModel = coinListModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'coin_list_model.freezed.dart';
part 'coin_list_model.g.dart';

CoinListModel coinListModelFromJson(String str) =>
    CoinListModel.fromJson(json.decode(str));

String coinListModelToJson(CoinListModel data) => json.encode(data.toJson());

@freezed
class CoinListModel with _$CoinListModel {
  const factory CoinListModel({
    String? coin,
    num? usd,
  }) = _CoinListModel;

  factory CoinListModel.fromJson(Map<String, dynamic> json) =>
      _$CoinListModelFromJson(json);
}

@freezed
class Coin with _$Coin {
  const factory Coin({
    num? usd,
  }) = _Coin;

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);
}
