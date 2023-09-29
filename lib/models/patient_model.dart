import 'exame_model.dart';

class PatientModel {
  var itemKey;
  String? nome;
  String? cpf;
  String? leito;
  String? prescricao;
  String? hipotese;
  String? evolucao;
  String? parametros;
  List<ExameModel>? exames;
  String? informacoes;

  PatientModel({
    required this.itemKey,
    required this.nome,
    required this.cpf,
    required this.leito,
    required this.prescricao,
    required this.hipotese,
    required this.evolucao,
    required this.parametros,
    this.exames = const [],
    required this.informacoes,
  });

  PatientModel.fromJson(Map map) {
    nome = map['nome'];
    cpf = map['cpf'];
    leito = map['leito'];
    prescricao = map['prescricao'];
    hipotese = map['hipotese'];
    evolucao = map['evolucao'];
    parametros = map['parametros'];
    exames = map['exames'];
    informacoes = map['informacoes'];
  }
}


//Vai ser necessário adaptar o recebimento dos exames.
// (json['cart_item_list'] as List<dynamic>?)
//             ?.map((e) => CartListItem.fromJson(e as Map))
//             .toList() ??
//         []

