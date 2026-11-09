import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  const srcIconPath =
      r'C:\Users\cbal\.gemini\antigravity\brain\b2f1d23b-cbe5-46ee-b44e-5cf4c11a2e07\app_icon_hr_1024_1794212112625.jpg';
  const srcBgPath =
      r'C:\Users\cbal\.gemini\antigravity\brain\b2f1d23b-cbe5-46ee-b44e-5cf4c11a2e07\japandi_background_1794149291118.jpg';
  const projectRoot = r'C:\Antigravity_Projects\GraphologyHR';

  final rawBytes = File(srcIconPath).readAsBytesSync();
  final master = img.decodeImage(rawBytes)!;

  void savePng(String relPath, int size) {
    final resized = img.copyResize(
      master,
      width: size,
      height: size,
      interpolation: img.Interpolation.cubic,
    );
    final outFile = File('$projectRoot\\$relPath');
    outFile.parent.createSync(recursive: true);
    outFile.writeAsBytesSync(img.encodePng(resized));
  }

  // Brand & Store assets
  savePng(r'assets\images\app_icon.png', 512);
  savePng(r'store_assets\app_icon_1024.png', 1024);

  if (File(srcBgPath).existsSync()) {
    final bgDest = File('$projectRoot\\assets\\images\\japandi_background.jpg');
    bgDest.parent.createSync(recursive: true);
    File(srcBgPath).copySync(bgDest.path);
  }

  // Android mipmaps
  savePng(r'android\app\src\main\res\mipmap-mdpi\ic_launcher.png', 48);
  savePng(r'android\app\src\main\res\mipmap-hdpi\ic_launcher.png', 72);
  savePng(r'android\app\src\main\res\mipmap-xhdpi\ic_launcher.png', 96);
  savePng(r'android\app\src\main\res\mipmap-xxhdpi\ic_launcher.png', 144);
  savePng(r'android\app\src\main\res\mipmap-xxxhdpi\ic_launcher.png', 192);

  // Web icons
  savePng(r'web\favicon.png', 64);
  savePng(r'web\icons\Icon-192.png', 192);
  savePng(r'web\icons\Icon-512.png', 512);
  savePng(r'web\icons\Icon-maskable-192.png', 192);
  savePng(r'web\icons\Icon-maskable-512.png', 512);

  // iOS AppIcon.appiconset
  final iosSizes = <String, int>{
    'Icon-App-20x20@1x.png': 20,
    'Icon-App-20x20@2x.png': 40,
    'Icon-App-20x20@3x.png': 60,
    'Icon-App-29x29@1x.png': 29,
    'Icon-App-29x29@2x.png': 58,
    'Icon-App-29x29@3x.png': 87,
    'Icon-App-40x40@1x.png': 40,
    'Icon-App-40x40@2x.png': 80,
    'Icon-App-40x40@3x.png': 120,
    'Icon-App-60x60@2x.png': 120,
    'Icon-App-60x60@3x.png': 180,
    'Icon-App-76x76@1x.png': 76,
    'Icon-App-76x76@2x.png': 152,
    'Icon-App-83.5x83.5@2x.png': 167,
    'Icon-App-1024x1024@1x.png': 1024,
  };
  for (final entry in iosSizes.entries) {
    savePng(
      'ios\\Runner\\Assets.xcassets\\AppIcon.appiconset\\${entry.key}',
      entry.value,
    );
  }

  // macOS AppIcon.appiconset
  final macSizes = <String, int>{
    'app_icon_16.png': 16,
    'app_icon_32.png': 32,
    'app_icon_64.png': 64,
    'app_icon_128.png': 128,
    'app_icon_256.png': 256,
    'app_icon_512.png': 512,
    'app_icon_1024.png': 1024,
  };
  for (final entry in macSizes.entries) {
    savePng(
      'macos\\Runner\\Assets.xcassets\\AppIcon.appiconset\\${entry.key}',
      entry.value,
    );
  }

  stdout.writeln('Generated all Graphology HR icons successfully.');
}
