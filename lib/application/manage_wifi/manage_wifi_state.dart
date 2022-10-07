part of 'manage_wifi_bloc.dart';

@freezed
class ManageWifiState with _$ManageWifiState {
  factory ManageWifiState.initial() = Initial;

  // factory ConnectToHomeWifiState.initialized() => ScanForWiFi;

  factory ManageWifiState.loading() = Loading;

  factory ManageWifiState.wifiIsDisabled() = WifiIsDisabled;

  factory ManageWifiState.wifiIsEnabled(String? currentWiFiName) =
      WifiIsEnabled;

  factory ManageWifiState.loaded() = Loaded;

  factory ManageWifiState.error() = Error;
}
