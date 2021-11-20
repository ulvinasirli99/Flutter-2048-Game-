import 'package:firebase_admob/firebase_admob.dart';

class AdsService {
  static final AdsService _instance = AdsService._internal();

  final String _interstitialAds = 'ca-app-pub-1064653046120204/4968350523';

  factory AdsService() => _instance;
  MobileAdTargetingInfo _targetingInfo;

  AdsService._internal() {
    _targetingInfo = MobileAdTargetingInfo();
  }

  showBanner() {
    BannerAd banner = BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.smartBanner,
        targetingInfo: _targetingInfo);

    banner
      ..load()
      ..show(anchorOffset: 50);

    banner.dispose();
  }

  showInterstitial() {
    InterstitialAd interstitialAd = InterstitialAd(
        adUnitId: _interstitialAds, targetingInfo: _targetingInfo);

    interstitialAd
      ..load()
      ..show();

    interstitialAd.dispose();
  }
}
