import 'package:cybear_jinni/domain/devices/abstract_device/core_failures.dart';
import 'package:cybear_jinni/infrastructure/core/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';

Either<CoreFailure<String>, String> validateGenericLightStateNotEmty(
  String input,
) {
  if (input == true.toString()) {
    return right(DeviceActions.on.toString());
  } else if (input == false.toString()) {
    return right(DeviceActions.off.toString());
  }
  return right(input);
}

/// Return all the valid actions for blinds
List<String> lightAllValidActions() {
  return [
    DeviceActions.off.toString(),
    DeviceActions.on.toString(),
  ];
}
