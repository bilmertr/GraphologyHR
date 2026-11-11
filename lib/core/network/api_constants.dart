class ApiConstants {
  ApiConstants._();

  /// Live Cloudflare Worker BFF endpoint protecting GEMINI_API_KEY
  static const String cloudflareWorkerUrl =
      'https://graphology.developer-6e8.workers.dev/analyze';

  /// Client identifier header sent to the BFF
  static const String clientHeaderValue = 'graphology-hr-v2';

  static const String geminiModelName = 'gemini-3.8-flash';

  static const Duration requestTimeout = Duration(seconds: 90);

  /// Kept in infrastructure for future B2B/SaaS monetization.
  /// Set to false for internal corporate HR rollout so users are never shown a paywall.
  static const bool enablePaywallInUi = false;

  /// Official BilmerTR Corporate HR Disclaimer & Zero-Data-Retention URL
  static const String officialDisclaimerUrl =
      'https://www.bilmertr.com/graphology_hr_disclaimer/';
}
