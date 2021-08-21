class RepairField {
  static const id = 'id';
  static const userId = 'userId';
  static const carMaker = 'carMaker';
  static const carType = 'carType';
  static const inspectionExpiration = 'inspectionExpiration';
  static const inquiry = 'inquiry';
  static const remark = 'remark';

  static const createdAt = 'createdAt';
}

class Repair {
  final String? id;
  final String? userId;
  final String? carMaker;
  final String? carType;
  final String? inspectionExpiration;
  final String? inquiry;
  final String? remark;

  final DateTime? createdAt;

  Repair({
    this.id,
    this.userId,
    this.carMaker,
    this.carType,
    this.inspectionExpiration,
    this.inquiry,
    this.remark,
    this.createdAt,
  });
}
