class AccidentField {
  static const id = 'id';
  static const userId = 'userId';
  static const policyNumber = 'policyNumber';
  static const carDamage = 'carDamage';
  static const injury = 'injury';
  static const opponent = 'opponent';
  static const accidentSituation = 'accidentSituation';

  static const createdAt = 'createdAt';
}

class Accident {
  final String? id;
  final String? userId;
  final String? policyNumber;
  final String? carDamage;
  final String? injury;
  final String? opponent;
  final String? accidentSituation;

  final DateTime? createdAt;

  Accident({
    this.id,
    this.userId,
    this.policyNumber,
    this.carDamage,
    this.injury,
    this.opponent,
    this.accidentSituation,
    this.createdAt,
  });
}
