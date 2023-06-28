class PatientModel {
  String nome;
  String cpf;
  String leito;
  String prescricao;
  String hipotese;
  String evolucao;
  String parametros;
  String exames;
  String informacoes;

  PatientModel({
    required this.nome,
    required this.cpf,
    required this.leito,
    required this.prescricao,
    required this.hipotese,
    required this.evolucao,
    required this.parametros,
    required this.exames,
    required this.informacoes,
  });
}
