import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/api_constants.dart';

/// Maintains quota & credit infrastructure in the background.
/// When ApiConstants.enablePaywallInUi is false (internal corporate rollout),
/// canAnalyze always returns true while still tracking usage counts cleanly.
class GraphologyQuotaManager {
  static const int maxFreeAnalyses = 2;
  static const String _keyFreeUsed = 'hr_graphology_free_used';
  static const String _keyPurchasedCredits = 'hr_graphology_purchased_credits';
  static const String _keyIsPro = 'hr_graphology_is_pro';

  final SharedPreferences _prefs;

  GraphologyQuotaManager(this._prefs);

  int get freeUsed => _prefs.getInt(_keyFreeUsed) ?? 0;

  int get remainingFree =>
      (maxFreeAnalyses - freeUsed).clamp(0, maxFreeAnalyses);

  int get purchasedCredits => _prefs.getInt(_keyPurchasedCredits) ?? 0;

  bool get isPro => _prefs.getBool(_keyIsPro) ?? false;

  bool get canAnalyze =>
      !ApiConstants.enablePaywallInUi ||
      isPro ||
      remainingFree > 0 ||
      purchasedCredits > 0;

  Future<void> consumeValidAnalysis() async {
    if (!ApiConstants.enablePaywallInUi || isPro) return;
    if (remainingFree > 0) {
      await _prefs.setInt(_keyFreeUsed, freeUsed + 1);
    } else if (purchasedCredits > 0) {
      await _prefs.setInt(_keyPurchasedCredits, purchasedCredits - 1);
    }
  }

  Future<void> addPurchasedCredits(int count) async {
    await _prefs.setInt(_keyPurchasedCredits, purchasedCredits + count);
  }

  Future<void> setProActive(bool active) async {
    await _prefs.setBool(_keyIsPro, active);
  }
}
