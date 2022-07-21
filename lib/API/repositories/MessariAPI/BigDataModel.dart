import 'package:work_project/API/repositories/MessariAPI/StatusModel.dart';

class BigDataModel {
  final StatusModel statusModel;
  final String? name;
  final String? symbol;
  final String? slug;
  final List values;

  BigDataModel({
    this.name,
    this.symbol,
    this.slug,
    required this.values,
    required this.statusModel,
  });

  factory BigDataModel.fromJson(Map<String, dynamic> json) {
    var dataDictionary = json['data'] as Map<String, dynamic>;
    String symbol = dataDictionary["symbol"];
    String name = dataDictionary["name"];
    String slug = dataDictionary["slug"];
    List values = dataDictionary["values"];

    return BigDataModel(
        statusModel: StatusModel.fromJson(json["status"]),
        name: name,
        slug: slug,
        symbol: symbol,
        values: values);
  }
  BigDataModel.withError(String error, this.name, this.symbol, this.slug)
      : statusModel = StatusModel(error, 0),
        values = [];
}
