import 'dart:math' as math;
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;

/// Deterministic pixel-level computer vision measurements extracted directly
/// from the candidate's handwriting/signature image.
/// Acts as the Stage 1 Gatekeeper and Stage 2 Grounding Anchor so the AI never hallucinates.
class PixelTelemetry {
  final String sha256Hash;
  final bool isValidInkSample;
  final String? invalidReasonKey;
  final double inkCoveragePercent;
  final double pressureIndex; // 0.0 (feather-light) to 1.0 (heavy/embossed)
  final double slantDegrees; // negative = leftward, 0 = vertical, positive = rightward
  final double baselineSlopeDegrees; // positive = ascending, negative = descending
  final double upperZoneRatio;
  final double middleZoneRatio;
  final double lowerZoneRatio;
  final double leftMarginRatio;
  final double rightMarginRatio;
  final double connectivityIndex; // 0.0 (disconnected) to 1.0 (highly connected)
  final double strokeAngularityIndex; // 0.0 (rounded garland) to 1.0 (sharp angular)

  const PixelTelemetry({
    required this.sha256Hash,
    required this.isValidInkSample,
    this.invalidReasonKey,
    required this.inkCoveragePercent,
    required this.pressureIndex,
    required this.slantDegrees,
    required this.baselineSlopeDegrees,
    required this.upperZoneRatio,
    required this.middleZoneRatio,
    required this.lowerZoneRatio,
    required this.leftMarginRatio,
    required this.rightMarginRatio,
    required this.connectivityIndex,
    required this.strokeAngularityIndex,
  });

  Map<String, dynamic> toJson() => {
        'sha256Hash': sha256Hash,
        'isValidInkSample': isValidInkSample,
        'inkCoveragePercent':
            double.parse(inkCoveragePercent.toStringAsFixed(2)),
        'pressureIndex': double.parse(pressureIndex.toStringAsFixed(2)),
        'slantDegrees': double.parse(slantDegrees.toStringAsFixed(1)),
        'baselineSlopeDegrees':
            double.parse(baselineSlopeDegrees.toStringAsFixed(1)),
        'upperZoneRatio': double.parse(upperZoneRatio.toStringAsFixed(2)),
        'middleZoneRatio': double.parse(middleZoneRatio.toStringAsFixed(2)),
        'lowerZoneRatio': double.parse(lowerZoneRatio.toStringAsFixed(2)),
        'leftMarginRatio': double.parse(leftMarginRatio.toStringAsFixed(2)),
        'rightMarginRatio': double.parse(rightMarginRatio.toStringAsFixed(2)),
        'connectivityIndex': double.parse(connectivityIndex.toStringAsFixed(2)),
        'strokeAngularityIndex':
            double.parse(strokeAngularityIndex.toStringAsFixed(2)),
      };
}

class PixelGraphologyExtractor {
  /// Extracts deterministic geometric & ink-density metrics from raw image bytes.
  static PixelTelemetry analyzeBytes(Uint8List bytes) {
    final hash = sha256.convert(bytes).toString();
    final decoded = img.decodeImage(bytes);

    if (decoded == null || decoded.width < 40 || decoded.height < 40) {
      return PixelTelemetry(
        sha256Hash: hash,
        isValidInkSample: false,
        invalidReasonKey: 'UNDECODABLE_OR_TOO_SMALL',
        inkCoveragePercent: 0,
        pressureIndex: 0,
        slantDegrees: 0,
        baselineSlopeDegrees: 0,
        upperZoneRatio: 0.33,
        middleZoneRatio: 0.34,
        lowerZoneRatio: 0.33,
        leftMarginRatio: 0.1,
        rightMarginRatio: 0.1,
        connectivityIndex: 0.5,
        strokeAngularityIndex: 0.5,
      );
    }

    final work = decoded.width > 360
        ? img.copyResize(decoded, width: 360)
        : decoded;
    final w = work.width;
    final h = work.height;
    final totalPixels = w * h;

    double sumLum = 0;
    double sumSat = 0;
    final lumGrid = Float64List(totalPixels);

    int idx = 0;
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        final p = work.getPixel(x, y);
        final r = p.r.toDouble();
        final g = p.g.toDouble();
        final b = p.b.toDouble();
        final lum = 0.299 * r + 0.587 * g + 0.114 * b;
        lumGrid[idx++] = lum;
        sumLum += lum;

        final maxC = math.max(r, math.max(g, b));
        final minC = math.min(r, math.min(g, b));
        final sat = maxC == 0 ? 0.0 : (maxC - minC) / maxC;
        sumSat += sat;
      }
    }

    final meanLum = sumLum / totalPixels;
    final meanSat = sumSat / totalPixels;

    final threshold = math.max(40.0, meanLum * 0.74);

    int inkCount = 0;
    double inkDarknessSum = 0;
    int minX = w, maxX = 0, minY = h, maxY = 0;
    double leftYWeighted = 0;
    int leftInkCount = 0;
    double rightYWeighted = 0;
    int rightInkCount = 0;

    int upperCount = 0;
    int middleCount = 0;
    int lowerCount = 0;

    int horizontalNeighbors = 0;
    int diagonalRightNeighbors = 0;
    int diagonalLeftNeighbors = 0;

    for (int y = 1; y < h - 1; y++) {
      for (int x = 1; x < w - 1; x++) {
        final lum = lumGrid[y * w + x];
        if (lum < threshold) {
          inkCount++;
          inkDarknessSum += (threshold - lum) / threshold;
          if (x < minX) minX = x;
          if (x > maxX) maxX = x;
          if (y < minY) minY = y;
          if (y > maxY) maxY = y;

          if (x < w ~/ 2) {
            leftYWeighted += y;
            leftInkCount++;
          } else {
            rightYWeighted += y;
            rightInkCount++;
          }

          if (lumGrid[y * w + (x + 1)] < threshold) {
            horizontalNeighbors++;
          }
          if (lumGrid[(y - 1) * w + (x + 1)] < threshold) {
            diagonalRightNeighbors++;
          }
          if (lumGrid[(y - 1) * w + (x - 1)] < threshold) {
            diagonalLeftNeighbors++;
          }
        }
      }
    }

    final inkPercent = (inkCount / totalPixels) * 100.0;
    final isValid = inkPercent >= 0.15 && inkPercent <= 46.0 && meanSat <= 0.42;

    if (!isValid || inkCount == 0) {
      return PixelTelemetry(
        sha256Hash: hash,
        isValidInkSample: false,
        invalidReasonKey: inkPercent < 0.15
            ? 'BLANK_OR_NO_INK'
            : 'NOT_A_DOCUMENT_OR_TOO_DARK',
        inkCoveragePercent: inkPercent,
        pressureIndex: 0.5,
        slantDegrees: 0,
        baselineSlopeDegrees: 0,
        upperZoneRatio: 0.33,
        middleZoneRatio: 0.34,
        lowerZoneRatio: 0.33,
        leftMarginRatio: 0.1,
        rightMarginRatio: 0.1,
        connectivityIndex: 0.5,
        strokeAngularityIndex: 0.5,
      );
    }

    final boxHeight = math.max(1, maxY - minY);
    for (int y = minY; y <= maxY; y++) {
      final relY = (y - minY) / boxHeight;
      for (int x = minX; x <= maxX; x++) {
        if (lumGrid[y * w + x] < threshold) {
          if (relY < 0.33) {
            upperCount++;
          } else if (relY < 0.67) {
            middleCount++;
          } else {
            lowerCount++;
          }
        }
      }
    }

    final zoneTotal = math.max(1, upperCount + middleCount + lowerCount);
    final upperRatio = upperCount / zoneTotal;
    final middleRatio = middleCount / zoneTotal;
    final lowerRatio = lowerCount / zoneTotal;

    final rawPressure = (inkDarknessSum / inkCount) * 1.45;
    final pressureIdx = rawPressure.clamp(0.22, 0.95);

    final diagTotal =
        math.max(1, diagonalRightNeighbors + diagonalLeftNeighbors);
    final diagDiff =
        (diagonalRightNeighbors - diagonalLeftNeighbors) / diagTotal;
    final slantDeg = (diagDiff * 38.0).clamp(-18.0, 24.0);

    double baselineDeg = 0.0;
    if (leftInkCount > 10 && rightInkCount > 10) {
      final meanLeftY = leftYWeighted / leftInkCount;
      final meanRightY = rightYWeighted / rightInkCount;
      final dy = meanLeftY - meanRightY;
      final dx = w * 0.45;
      baselineDeg = (math.atan2(dy, dx) * 180.0 / math.pi).clamp(-12.0, 12.0);
    }

    final leftMargin = (minX / w).clamp(0.01, 0.45);
    final rightMargin = ((w - maxX) / w).clamp(0.01, 0.45);
    final connectivity =
        (horizontalNeighbors / math.max(1, inkCount)).clamp(0.15, 0.92);
    final angularity =
        ((diagonalRightNeighbors + diagonalLeftNeighbors) /
                math.max(1, inkCount * 1.6))
            .clamp(0.18, 0.90);

    return PixelTelemetry(
      sha256Hash: hash,
      isValidInkSample: true,
      inkCoveragePercent: inkPercent,
      pressureIndex: pressureIdx,
      slantDegrees: slantDeg,
      baselineSlopeDegrees: baselineDeg,
      upperZoneRatio: upperRatio,
      middleZoneRatio: middleRatio,
      lowerZoneRatio: lowerRatio,
      leftMarginRatio: leftMargin,
      rightMarginRatio: rightMargin,
      connectivityIndex: connectivity,
      strokeAngularityIndex: angularity,
    );
  }
}
