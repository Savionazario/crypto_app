import 'package:crypto_app/layers/core/constants/currency_icons.dart';
import 'package:crypto_app/layers/domain/services/icon_service.dart';

class IconServiceImpl implements IconService{
  @override
  String getIconPath(String? code) {
    return currencyIcons[code] ?? currencyIcons["USD"]!;
  }
}