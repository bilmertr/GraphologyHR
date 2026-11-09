import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../settings/providers/settings_provider.dart';
import '../domain/graphology_quota_manager.dart';
import '../models/subscription_product.dart';

class QuotaState {
  final int remainingFree;
  final int purchasedCredits;
  final bool isPro;
  final bool canAnalyze;
  final List<SubscriptionProduct> catalog;

  const QuotaState({
    required this.remainingFree,
    required this.purchasedCredits,
    required this.isPro,
    required this.canAnalyze,
    required this.catalog,
  });
}

final quotaManagerProvider = Provider<GraphologyQuotaManager>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return GraphologyQuotaManager(prefs);
});

class QuotaNotifier extends StateNotifier<QuotaState> {
  final GraphologyQuotaManager _manager;
  final String _locale;

  QuotaNotifier(this._manager, this._locale) : super(_buildState(_manager, _locale));

  static QuotaState _buildState(GraphologyQuotaManager m, String locale) {
    return QuotaState(
      remainingFree: m.remainingFree,
      purchasedCredits: m.purchasedCredits,
      isPro: m.isPro,
      canAnalyze: m.canAnalyze,
      catalog: [
        SubscriptionProduct.singleForLocale(locale),
        SubscriptionProduct.pack5ForLocale(locale),
        SubscriptionProduct.proMonthlyForLocale(locale),
      ],
    );
  }

  Future<void> consumeValidAnalysis() async {
    await _manager.consumeValidAnalysis();
    state = _buildState(_manager, _locale);
  }
}

final quotaProvider = StateNotifierProvider<QuotaNotifier, QuotaState>((ref) {
  final manager = ref.watch(quotaManagerProvider);
  final settings = ref.watch(settingsProvider);
  return QuotaNotifier(manager, settings.languageCode);
});
