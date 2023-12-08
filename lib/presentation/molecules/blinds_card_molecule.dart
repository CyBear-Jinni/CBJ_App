import 'package:cbj_integrations_controller/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cybear_jinni/presentation/atoms/atoms.dart';
import 'package:flutter/material.dart';

class BlindsCardMolecule extends StatelessWidget {
  const BlindsCardMolecule(this._deviceEntity);

  final GenericLightDE _deviceEntity;

  @override
  Widget build(BuildContext context) {
    final deviceState = _deviceEntity.entityStateGRPC.getOrCrash();
    final deviceAction = _deviceEntity.lightSwitchState!.getOrCrash();

    if (deviceAction == EntityActions.on.toString()) {
      if (deviceState == EntityStateGRPC.ack.toString()) {
        // toggleColor = const Color(0xFFFFDF5D);
      }
    } else {
      if (deviceState == EntityStateGRPC.ack.toString()) {
        // toggleColor = Theme.of(context).primaryColorDark;
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: const TextAtom(
        'Blinds action is not yet supported when adding new blinds',
      ),
    );
  }
}