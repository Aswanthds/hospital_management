class Medicine {
  final String genericName;
  final String drugName;
  final String batchNumber;
  final String hsnCode;
  final DateTime expiryDate;
  final int unitNumber;
  final String type;
  final String drugDealer;
  final String manufacturer;
  final double purchaseCost;
  final double gst;
  final double discount;
  final double mrp;

  Medicine({
    required this.genericName,
    required this.drugName,
    required this.batchNumber,
    required this.hsnCode,
    required this.expiryDate,
    required this.unitNumber,
    required this.type,
    required this.drugDealer,
    required this.manufacturer,
    required this.purchaseCost,
    required this.gst,
    required this.discount,
    required this.mrp,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        genericName: json['genericName'] as String,
        drugName: json['drugName'] as String,
        batchNumber: json['batchNumber'] as String,
        hsnCode: json['hsnCode'] as String,
        expiryDate: DateTime.parse(json['expiryDate'] as String),
        unitNumber: json['unitNumber'] as int,
        type: json['type'] as String,
        drugDealer: json['drugDealer'] as String,
        manufacturer: json['manufacturer'] as String,
        purchaseCost: json['purchaseCost'] as double,
        gst: json['gst'] as double,
        discount: json['discount'] as double,
        mrp: json['mrp'] as double,
      );

  Map<String, dynamic> toJson() => {
        'genericName': genericName,
        'drugName': drugName,
        'batchNumber': batchNumber,
        'hsnCode': hsnCode,
        'expiryDate': expiryDate.toIso8601String(),
        'unitNumber': unitNumber,
        'type': type,
        'drugDealer': drugDealer,
        'manufacturer': manufacturer,
        'purchaseCost': purchaseCost,
        'gst': gst,
        'discount': discount,
        'mrp': mrp,
      };
}
