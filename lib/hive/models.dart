
class EmpTraining {
  final String pernr;
  final String ename;
  final String persk;
  final String dept;
  final String inst;
  final String venue;
  final String progTitle;
  final String progCat;
  final String progType;
  final String begda;
  final String endda;

  const EmpTraining({
    required this.pernr,
    required this.ename,
    required this.persk,
    required this.dept,
    required this.inst,
    required this.venue,
    required this.progTitle,
    required this.progCat,
    required this.progType,
    required this.begda,
    required this.endda,
  });

  factory EmpTraining.fromJson(Map<String, dynamic> json) {
    return EmpTraining(
      pernr: json['Pernr'] as String,
      ename: json['Ename'] ?? '',
      persk: json['Persk'] ?? '',
      dept: json['Dept'] ?? '',
      inst: json['Inst'] ?? '',
      venue: json['Venue'] ?? '',
      progTitle: json['ProgTitle'] ?? '',
      progCat: json['ProgCat'] ?? '',
      progType: json['ProgType'] ?? '',
      begda: json['Begda'] ?? '',
      endda: json['Endda'] ?? '',
    );
  }
}