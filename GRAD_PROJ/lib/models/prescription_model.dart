class PrescriptionModel {
  String status;
  List medications;

  PrescriptionModel({
    required this.status,
    required this.medications,
  });

  factory PrescriptionModel.fromJson(json) {
    return PrescriptionModel(
      status: json['prescription']['status'],
      medications: json['prescription']['medications'],
    );
  }
}
