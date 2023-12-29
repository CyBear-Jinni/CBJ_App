part of 'package:cybearjinni/domain/connections_service.dart';

class _DemoConnectionService implements ConnectionsService {
  StreamController<MapEntry<String, DeviceEntityBase>>? stream;
  @override
  Future dispose() async {
    stream?.close();
  }

  @override
  Future<HashMap<String, DeviceEntityBase>> get getAllEntities async =>
      DemoConnectionController.getAllEntities();

  @override
  Future searchDevices() async {}

  @override
  void setEntityState({
    required HashMap<VendorsAndServices, HashSet<String>> uniqueIdByVendor,
    required EntityProperties property,
    required EntityActions actionType,
    HashMap<ActionValues, dynamic>? value,
  }) {}

  @override
  Stream<MapEntry<String, DeviceEntityBase>> watchEntities() {
    stream?.close();

    stream = StreamController.broadcast();
    return stream!.stream;
  }
}