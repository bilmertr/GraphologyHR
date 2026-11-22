class HrTextFormatter {
  HrTextFormatter._();

  static const String _sectionHeadingUnion =
      r'Dikkat\s+Edilmesi\s+Gereken[^:\n]{0,48}:'
      r'|Potansiyel\s+Riskler[^:\n]{0,48}:'
      r'|Mülakatta\s+Sorulması\s+Gereken[^:\n]{0,48}:'
      r'|Davranışsal\s+Mülakat\s+Soruları[^:\n]{0,48}:'
      r'|Mülakat\s+Soruları[^:\n]{0,48}:'
      r'|Doğrulama\s+Soruları[^:\n]{0,48}:'
      r'|(?:Recommended\s+)?(?:Behavioral\s+)?Interview\s+Questions[^:\n]{0,48}:'
      r'|Probing\s+Questions[^:\n]{0,48}:'
      r'|(?:Potential\s+|Hiring\s+)?(?:Watch-?Outs|Risks|Red\s+Flags)[^:\n]{0,48}:'
      r'|(?:Adfærdsbaserede\s+)?Interviewspørgsmål[^:\n]{0,48}:'
      r'|(?:Verhaltensbezogene\s+)?Interviewfragen[^:\n]{0,48}:'
      r"|Preguntas\s+de\s+entrevista[^:\n]{0,48}:"
      r"|Questions\s+d'entretien[^:\n]{0,48}:"
      r'|Domande\s+di\s+colloquio[^:\n]{0,48}:'
      r'|Sollicitatievragen[^:\n]{0,48}:'
      r'|Intervjufrågor[^:\n]{0,48}:';

  static final RegExp _semicolonNumberedRegex = RegExp(
    r'[ \t]*;[ \t]+(?=(?:\([1-9]\)|[1-9][.)])\s)',
  );

  static final RegExp _semicolonNamedItemRegex = RegExp(
    r'[ \t]*;[ \t]+(?=(?:Red\s+Flag|Watch-?Out|Hiring\s+Risk|Risk|Behavioral\s+Interview\s+Question|Interview\s+Question|Probing\s+Question|Mülakat\s+Sorusu|Doğrulama\s+Sorusu|Soru|Question|Spørgsmål|Frage|Pregunta)\s+[1-9]\b)',
    caseSensitive: false,
  );

  static final RegExp _sectionHeadingBlockRegex = RegExp(
    r'(?:(^|\n)|(\S)[ \t]+)(' + _sectionHeadingUnion + r')(?:[ \t]+(?=\S))?',
    caseSensitive: false,
  );

  static final RegExp _namedItemRegex = RegExp(
    r'(?:(^|\n)|(\S)[ \t]+)((?:Red\s+Flag|Watch-?Out|(?:Hiring\s+|Potential\s+)?Risk|(?:Recommended\s+|Behavioral\s+|Probing\s+)*(?:Interview\s+)?Question|(?:Davranışsal\s+)?(?:Mülakat\s+|Doğrulama\s+)?Sorusu|Soru|Spørgsmål|Frage|Pregunta)\s+[1-9]\b)',
    caseSensitive: false,
  );

  static final RegExp _inlineParenOrRightParenRegex = RegExp(
    r'(?<=\S)[ \t]+(?=(?:\([1-9]\)|[1-9]\))\s)',
  );

  static final RegExp _inlineDotNumberedRegex = RegExp(
    r'(?<=[:.!?;])[ \t]+(?=[1-9]\.\s+[A-ZÇĞİÖŞÜ"“«\x27])',
  );

  static final RegExp _inlineBulletRegex = RegExp(
    r'(?<=\S)[ \t]+(?=•\s)',
  );

  static final RegExp _leadingNumberNormalizeRegex = RegExp(
    r'^(?:\(([1-9])\)|([1-9])\))\s+',
  );

  static final RegExp _itemPrefixRegex = RegExp(
    r'^(?:[1-9]\.|•|(?:Red\s+Flag|Watch-?Out|(?:Hiring\s+|Potential\s+)?Risk|(?:Behavioral\s+|Probing\s+)?(?:Interview\s+)?Question|(?:Mülakat\s+|Doğrulama\s+)?Sorusu|Soru|Spørgsmål|Frage|Pregunta)\s+[1-9]\b)',
    caseSensitive: false,
  );

  static final RegExp _interviewKeywordRegex = RegExp(
    r'mülakat|soru|interview|question|spørgsmål|frage|pregunta|entretien|colloquio|sollicitatie|intervju',
    caseSensitive: false,
  );

  /// Formats Dimension 6 (Red Flags & Behavioral Interview Questions) so every
  /// section heading, risk item, and interview question sits on its own paragraph.
  static String formatRedFlags(String raw) {
    var text = raw.replaceAll('\r\n', '\n').replaceAll('\r', '\n').trim();
    if (text.isEmpty) return '';

    text = text.replaceAll(_semicolonNumberedRegex, '\n\n');
    text = text.replaceAll(_semicolonNamedItemRegex, '\n\n');

    text = text.replaceAllMapped(_sectionHeadingBlockRegex, (m) {
      final linePrefix = m.group(1);
      final nonWs = m.group(2);
      final heading = m.group(3)!;
      final before = nonWs != null ? '$nonWs\n\n' : (linePrefix ?? '');
      return '$before$heading\n\n';
    });

    text = text.replaceAllMapped(_namedItemRegex, (m) {
      final linePrefix = m.group(1);
      final nonWs = m.group(2);
      final item = m.group(3)!;
      final before = nonWs != null ? '$nonWs\n\n' : (linePrefix ?? '');
      return '$before$item';
    });

    text = text.replaceAll(_inlineParenOrRightParenRegex, '\n\n');
    text = text.replaceAll(_inlineDotNumberedRegex, '\n\n');
    text = text.replaceAll(_inlineBulletRegex, '\n\n');

    final paragraphs = <String>[];
    for (final rawLine in text.split('\n')) {
      var line = rawLine.trim();
      if (line.isEmpty) continue;
      line = line.replaceFirstMapped(_leadingNumberNormalizeRegex, (m) {
        final digit = m.group(1) ?? m.group(2)!;
        return '$digit. ';
      });
      paragraphs.add(line);
    }

    return paragraphs.join('\n\n');
  }

  /// Splits formatted Dimension 6 text into clean non-empty paragraphs.
  static List<String> splitParagraphs(String raw) {
    final formatted = formatRedFlags(raw);
    if (formatted.isEmpty) return const [];
    return formatted
        .split('\n\n')
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList(growable: false);
  }

  /// Returns true if a paragraph represents a short section subheading ending in `:`.
  static bool isSectionHeading(String paragraph) {
    final p = paragraph.trim();
    if (!p.endsWith(':') || p.length > 95) return false;
    return !_itemPrefixRegex.hasMatch(p);
  }

  /// Returns true if a section heading introduces interview probing questions.
  static bool isInterviewHeading(String paragraph) {
    return isSectionHeading(paragraph) &&
        _interviewKeywordRegex.hasMatch(paragraph);
  }
}
