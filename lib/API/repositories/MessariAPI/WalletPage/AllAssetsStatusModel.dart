class AllAssetsStatusModel {
  final String timestamp;
  final int elapsed;

  AllAssetsStatusModel(
    this.timestamp,
    this.elapsed,
  );
  AllAssetsStatusModel.fromJson(Map<String, dynamic> json)
      : timestamp = json["timestamp"],
        elapsed = json["elapsed"];
}
