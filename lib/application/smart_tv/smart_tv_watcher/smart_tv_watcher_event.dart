part of 'smart_tv_watcher_bloc.dart';

@freezed
class SmartTvWatcherEvent with _$SmartTvWatcherEvent {
  const factory SmartTvWatcherEvent.watchAllStarted() = WatchAllSmartTvStarted;

  const factory SmartTvWatcherEvent.smartTvReceived(
    Either<DevicesFailure, KtList<DeviceEntityAbstract?>> failureOrDevices,
  ) = Smart_tvReceived;
}
