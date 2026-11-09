// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Graphology HR';

  @override
  String get appSubtitle =>
      'Evaluación Corporativa de Disciplina, Resiliencia y Ajuste al Puesto';

  @override
  String get navStudio => 'Evaluar Candidato';

  @override
  String get navArchive => 'Archivo';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get candidateContextTitle => 'CANDIDATO Y PUESTO OBJETIVO (OPCIONAL)';

  @override
  String get candidateNameHint =>
      'Código o nombre del candidato (ej. Candidato #104)';

  @override
  String get targetRoleLabel => 'Perfil del Puesto';

  @override
  String get roleGeneral => 'Corporativo General';

  @override
  String get roleLeadership => 'Directivo / Liderazgo';

  @override
  String get roleExecution => 'Operaciones / Ejecutor (Doer)';

  @override
  String get roleSales => 'Ventas y Comunicación';

  @override
  String get roleTechnical => 'Técnico / Analítico';

  @override
  String get modeSelectorLabel => 'SELECCIONE MODO DE EVALUACIÓN';

  @override
  String get modeHandwritingTitle =>
      'Escritura (Disciplina Laboral y Ejecución)';

  @override
  String get modeHandwritingDesc =>
      'Autodisciplina, capacidad organizativa, resiliencia y seguimiento operativo';

  @override
  String get modeSignatureTitle =>
      'Firma (Persona Corporativa, Autoridad y Ego)';

  @override
  String get modeSignatureDesc =>
      'Presencia ejecutiva, ambición, límites del ego y proyección de autoridad';

  @override
  String get modeCombinedTitle =>
      'Escritura + Firma (Hábito Real vs. Máscara de Entrevista)';

  @override
  String get modeCombinedDesc =>
      'Compara la imagen proyectada en la entrevista con la disciplina real de trabajo';

  @override
  String get uploadHandwritingTitle => 'Foto de Escritura / Nota del Candidato';

  @override
  String get uploadSignatureTitle => 'Foto de Firma del Candidato';

  @override
  String get captureGuideHandwriting =>
      'Suba una foto clara de la nota manuscrita del candidato.';

  @override
  String get captureGuideSignature =>
      'Suba una foto clara de la firma del candidato.';

  @override
  String get cameraButton => 'Cámara';

  @override
  String get galleryButton => 'Archivo / Galería';

  @override
  String get analyzeButton => 'Analizar Ajuste Corporativo y Carácter';

  @override
  String get analyzingWait =>
      'Evaluando autodisciplina, capacidad de gestión, resiliencia y ajuste al rol...';

  @override
  String get disclaimerShortText =>
      'Aviso de RR.HH. y Privacidad: Informe de apoyo para entrevistas; la IA puede cometer errores. No tome decisiones de contratación solo con este informe. Los datos e imágenes no se almacenan.';

  @override
  String get disclaimerLinkLabel =>
      'Leer Aviso de Apoyo a Decisiones y Cero Retención de Datos';

  @override
  String get disclaimerDialogTitle =>
      'Descargo de Responsabilidad de RR.HH. y Privacidad';

  @override
  String get disclaimerDialogBody =>
      '1. Herramienta de Apoyo y Falibilidad de la IA:\nEste análisis es una herramienta complementaria para generar preguntas de entrevista. La IA puede equivocarse; nunca tome una decisión positiva o negativa de contratación basada únicamente en este informe.\n\n2. Cero Retención de Datos:\nLas imágenes y datos del candidato nunca se guardan en servidores; solo se procesan en memoria para el análisis instantáneo.';

  @override
  String get reportSummaryTitle => 'Resumen Ejecutivo y Ajuste Corporativo';

  @override
  String get spectrumSectionTitle => 'Espectro Corporativo de 4 Ejes';

  @override
  String get axisManageability => 'Capacidad de Gestión y Apego a Normas';

  @override
  String get axisRoleType => 'Arquetipo de Rol Operativo';

  @override
  String get axisResilience =>
      'Tolerancia a la Presión (Resiliencia vs. Fragilidad)';

  @override
  String get axisDiscipline => 'Autodisciplina y Organización';

  @override
  String get reportComparisonTitle =>
      'Hábito Real (Escritura) vs. Máscara en Entrevista (Firma)';

  @override
  String get reportDimensionsTitle =>
      'Evaluación Corporativa de RR.HH. en 6 Dimensiones';

  @override
  String get dimDiscipline =>
      '1. Autodisciplina, Organización y Capacidad de Cierre';

  @override
  String get dimManageability =>
      '2. Relación con la Autoridad y Gestionabilidad (¿Rebelde o Dirigible?)';

  @override
  String get dimRoleNature =>
      '3. Arquetipo de Rol: ¿Líder, Ejecutor (Doer) o Figura de Escaparate?';

  @override
  String get dimResilience =>
      '4. Resiliencia al Estrés vs. Fragilidad Emocional';

  @override
  String get dimTeamEgo =>
      '5. Comunicación en Equipo, Ego y Manejo de Conflictos';

  @override
  String get dimRedFlags =>
      '6. Riesgos de Contratación (Red Flags) y Preguntas de Entrevista';

  @override
  String get physicalMetricsTitle => 'Evidencia Física Observada';

  @override
  String get metricSlant => 'Inclinación';

  @override
  String get metricPressure => 'Presión';

  @override
  String get metricBaseline => 'Dirección';

  @override
  String get metricSize => 'Tamaño';

  @override
  String get metricZones => 'Zonas';

  @override
  String get metricConnectivity => 'Conexión';

  @override
  String get metricSpacing => 'Orden y Márgenes';

  @override
  String get metricSignatureStyle => 'Firma y Énfasis';

  @override
  String get archiveTitle => 'Archivo de Candidatos';

  @override
  String get archiveEmpty => 'Aún no hay evaluaciones archivadas.';

  @override
  String get settingsTitle => 'Ajustes de RR.HH.';

  @override
  String get settingsLanguage => 'Idioma del Informe';

  @override
  String get settingsTheme => 'Modo Oscuro';

  @override
  String get closeButton => 'Cerrar';
}
