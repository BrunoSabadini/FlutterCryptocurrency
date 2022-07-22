import 'AllAssetsDataModel.dart';
import 'AllAssetsStatusModel.dart';

class AllAssetsBigDataModel {
  final AllAssetsStatusModel statusModel;
  final List<AllAssetsDataModel> dataModel;

  AllAssetsBigDataModel({
    required this.dataModel,
    required this.statusModel,
  });

  factory AllAssetsBigDataModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;

    List<AllAssetsDataModel> dataModelList =
        dataList.map((e) => AllAssetsDataModel.fromJson(e)).toList();

    return AllAssetsBigDataModel(
      statusModel: AllAssetsStatusModel.fromJson(json["status"]),
      dataModel: dataModelList,
    );
  }

  AllAssetsBigDataModel.withError(String error)
      : statusModel = AllAssetsStatusModel(error, 0),
        dataModel = [];
}
