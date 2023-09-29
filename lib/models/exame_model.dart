class ExameModel {
  int? idExame;
  String? exameBase64;
  String? exameLabel;
  String? exameData;

  ExameModel({
    required this.idExame,
    this.exameBase64,
    this.exameLabel,
    this.exameData,
  });

  //transforma o map em objeto
  ExameModel.fromJson(Map map) {
    idExame = map['idExame'];
    exameBase64 = map['exameBase64'];
    exameLabel = map['exameLabel'];
    exameData = map['exameData'];
  }
}
