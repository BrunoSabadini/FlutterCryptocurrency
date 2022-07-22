class AllAssetsDataModel {
  final String name;
  final String symbol;
  final String slug;
  final Map<String, dynamic> metrics;

  // final MetricsModel metricsModel;

  AllAssetsDataModel(this.name, this.symbol, this.slug, this.metrics);

  factory AllAssetsDataModel.fromJson(Map<String, dynamic> json) {
    return AllAssetsDataModel(
      json["name"],
      json["symbol"],
      json["slug"],
      json["metrics"],
    );
  }
}
