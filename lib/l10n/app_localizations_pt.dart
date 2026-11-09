// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Graphology HR';

  @override
  String get appSubtitle =>
      'Avaliação Corporativa de Disciplina, Resiliência e Adequação ao Cargo';

  @override
  String get navStudio => 'Avaliar Candidato';

  @override
  String get navArchive => 'Arquivo';

  @override
  String get navSettings => 'Definições';

  @override
  String get candidateContextTitle => 'CANDIDATO E CARGO ALVO (OPCIONAL)';

  @override
  String get candidateNameHint =>
      'Código ou nome do candidato (ex: Candidato #104)';

  @override
  String get targetRoleLabel => 'Perfil do Cargo';

  @override
  String get roleGeneral => 'Corporativo Geral';

  @override
  String get roleLeadership => 'Direção / Liderança';

  @override
  String get roleExecution => 'Operações / Executor (Doer)';

  @override
  String get roleSales => 'Vendas e Comunicação';

  @override
  String get roleTechnical => 'Técnico / Especialista';

  @override
  String get modeSelectorLabel => 'SELECIONE O MODO DE AVALIAÇÃO';

  @override
  String get modeHandwritingTitle =>
      'Escrita (Disciplina de Trabalho e Execução)';

  @override
  String get modeHandwritingDesc =>
      'Autodisciplina, organização, resiliência sob pressão e entrega prática';

  @override
  String get modeSignatureTitle =>
      'Assinatura (Postura Corporativa, Autoridade e Ego)';

  @override
  String get modeSignatureDesc =>
      'Presença executiva, ambição, limites de ego e projeção de autoridade';

  @override
  String get modeCombinedTitle =>
      'Escrita + Assinatura (Hábito Real vs. Máscara de Entrevista)';

  @override
  String get modeCombinedDesc =>
      'Compara a vitrine apresentada na entrevista com a disciplina real de execução';

  @override
  String get uploadHandwritingTitle => 'Foto da Escrita / Nota do Candidato';

  @override
  String get uploadSignatureTitle => 'Foto da Assinatura do Candidato';

  @override
  String get captureGuideHandwriting =>
      'Carregue uma foto nítida da nota manuscrita do candidato.';

  @override
  String get captureGuideSignature =>
      'Carregue uma foto nítida da assinatura do candidato.';

  @override
  String get cameraButton => 'Câmara';

  @override
  String get galleryButton => 'Ficheiro / Galeria';

  @override
  String get analyzeButton => 'Analisar Adequação Corporativa e Caráter';

  @override
  String get analyzingWait =>
      'A avaliar autodisciplina, capacidade de gestão, resiliência e adequação ao cargo...';

  @override
  String get disclaimerShortText =>
      'Aviso de RH e Privacidade: Relatório complementar de apoio à entrevista; a IA pode cometer erros. Não tome decisões de contratação apenas com base neste relatório. Os dados não são armazenados.';

  @override
  String get disclaimerLinkLabel =>
      'Ler Aviso de Apoio à Decisão de RH e Zero Retenção de Dados';

  @override
  String get disclaimerDialogTitle =>
      'Aviso de Apoio à Decisão de RH e Privacidade';

  @override
  String get disclaimerDialogBody =>
      '1. Apoio Complementar e Falibilidade da IA:\nEsta análise serve apenas para gerar hipóteses e perguntas de entrevista. A IA pode errar; nunca tome uma decisão positiva ou negativa de contratação apenas com base neste relatório.\n\n2. Zero Retenção de Dados:\nAs imagens e dados do candidato nunca são guardados em servidores; são processados apenas em memória para análise instantânea.';

  @override
  String get reportSummaryTitle => 'Resumo Executivo e Adequação Corporativa';

  @override
  String get spectrumSectionTitle => 'Espectro Corporativo de 4 Eixos';

  @override
  String get axisManageability => 'Gerenciabilidade e Conformidade';

  @override
  String get axisRoleType => 'Arquétipo Operacional';

  @override
  String get axisResilience =>
      'Tolerância à Pressão (Resiliência vs. Fragilidade)';

  @override
  String get axisDiscipline => 'Autodisciplina e Organização';

  @override
  String get reportComparisonTitle =>
      'Hábito Real (Escrita) vs. Máscara na Entrevista (Assinatura)';

  @override
  String get reportDimensionsTitle =>
      'Avaliação Corporativa de RH em 6 Dimensões';

  @override
  String get dimDiscipline =>
      '1. Autodisciplina, Organização e Capacidade de Execução';

  @override
  String get dimManageability =>
      '2. Relação com Autoridade e Gerenciabilidade (Rebelde vs. Gerenciável)';

  @override
  String get dimRoleNature =>
      '3. Arquétipo de Função: Líder, Executor (Doer) ou Focado em Vitrine?';

  @override
  String get dimResilience =>
      '4. Resiliência ao Stress vs. Fragilidade Emocional';

  @override
  String get dimTeamEgo =>
      '5. Comunicação em Equipa, Ego e Gestão de Conflitos';

  @override
  String get dimRedFlags =>
      '6. Riscos de Contratação (Red Flags) e Perguntas de Entrevista';

  @override
  String get physicalMetricsTitle => 'Evidência Física Observada';

  @override
  String get metricSlant => 'Inclinação';

  @override
  String get metricPressure => 'Pressão';

  @override
  String get metricBaseline => 'Alinhamento';

  @override
  String get metricSize => 'Dimensão';

  @override
  String get metricZones => 'Zonas';

  @override
  String get metricConnectivity => 'Ligação';

  @override
  String get metricSpacing => 'Ordem e Margens';

  @override
  String get metricSignatureStyle => 'Assinatura e Ênfase';

  @override
  String get archiveTitle => 'Arquivo de Candidatos';

  @override
  String get archiveEmpty => 'Nenhuma avaliação de candidato arquivada ainda.';

  @override
  String get settingsTitle => 'Definições de RH';

  @override
  String get settingsLanguage => 'Idioma do Relatório';

  @override
  String get settingsTheme => 'Modo Escuro';

  @override
  String get closeButton => 'Fechar';
}
