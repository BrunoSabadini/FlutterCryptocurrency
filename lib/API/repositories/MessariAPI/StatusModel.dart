class StatusModel {
  final String timestamp;
  final int elapsed;

  StatusModel(
    this.timestamp,
    this.elapsed,
  );
  StatusModel.fromJson(Map<String, dynamic> json)
      : timestamp = json["timestamp"],
        elapsed = json["elapsed"];
}
