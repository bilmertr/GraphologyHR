import 'package:in_app_purchase/in_app_purchase.dart';

class SubscriptionProduct {
  static const String singleCreditProductId = 'graphology_hr_credit_1';
  static const String pack5CreditsProductId = 'graphology_hr_credit_5';
  static const String proMonthlyProductId = 'graphology_hr_pro_monthly';

  static const Set<String> allProductIds = {
    singleCreditProductId,
    pack5CreditsProductId,
    proMonthlyProductId,
  };

  final String productId;
  final String title;
  final String description;
  final String displayPrice;
  final double rawPrice;
  final String currencyCode;
  final int creditCount;
  final bool isSubscription;
  final ProductDetails? productDetails;

  const SubscriptionProduct({
    required this.productId,
    required this.title,
    required this.description,
    required this.displayPrice,
    required this.rawPrice,
    required this.currencyCode,
    required this.creditCount,
    this.isSubscription = false,
    this.productDetails,
  });

  factory SubscriptionProduct.singleForLocale(String locale) {
    final isTr = locale.toLowerCase().startsWith('tr');
    return SubscriptionProduct(
      productId: singleCreditProductId,
      title: isTr ? 'Tekli Aday Değerlendirme Kredisi' : 'Single Candidate Credit',
      description: isTr
          ? '1 adet kurumsal aday karakter & uyum raporu'
          : '1 complete corporate candidate assessment',
      displayPrice: isTr ? '20,00 ₺' : '\$1.00',
      rawPrice: isTr ? 20.0 : 1.0,
      currencyCode: isTr ? 'TRY' : 'USD',
      creditCount: 1,
    );
  }

  factory SubscriptionProduct.pack5ForLocale(String locale) {
    final isTr = locale.toLowerCase().startsWith('tr');
    return SubscriptionProduct(
      productId: pack5CreditsProductId,
      title: isTr ? "5'li Kurumsal İK Paketi" : '5-Candidate HR Pack',
      description: isTr
          ? '5 adet kurumsal aday analizi (Tekli fiyatın 3 katı avantajlı paket)'
          : '5 complete candidate assessments (3x single price value pack)',
      displayPrice: isTr ? '60,00 ₺' : '\$3.00',
      rawPrice: isTr ? 60.0 : 3.0,
      currencyCode: isTr ? 'TRY' : 'USD',
      creditCount: 5,
    );
  }

  factory SubscriptionProduct.proMonthlyForLocale(String locale) {
    final isTr = locale.toLowerCase().startsWith('tr');
    return SubscriptionProduct(
      productId: proMonthlyProductId,
      title: isTr ? 'Aylık Sınırsız Kurumsal İK Pro' : 'Monthly Unlimited HR Pro',
      description: isTr
          ? 'Sınırsız aday analizi ve arşivleme'
          : 'Unlimited candidate assessments and archiving',
      displayPrice: isTr ? '149,99 ₺ / ay' : '\$4.99 / mo',
      rawPrice: isTr ? 149.99 : 4.99,
      currencyCode: isTr ? 'TRY' : 'USD',
      creditCount: 999,
      isSubscription: true,
    );
  }
}
