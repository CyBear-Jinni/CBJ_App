import 'dart:collection';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:cbj_integrations_controller/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/abstract_entity/device_entity_base.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/entity_type_utils.dart';
import 'package:cbj_integrations_controller/infrastructure/generic_entities/generic_smart_tv_entity/generic_smart_tv_entity.dart';
import 'package:cybearjinni/domain/connections_service.dart';
import 'package:cybearjinni/presentation/atoms/atoms.dart';
import 'package:cybearjinni/presentation/molecules/molecules.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Show switch toggles in a container with the background color from smart room
/// object
class SmartTvMolecule extends StatefulWidget {
  const SmartTvMolecule(this.entity);

  final GenericSmartTvDE entity;

  @override
  State<SmartTvMolecule> createState() => _SmartTvMoleculeState();
}

class _SmartTvMoleculeState extends State<SmartTvMolecule> {
  Future onVolumeUp() async {
    FlushbarHelper.createLoading(
      message: 'Volume Up',
      linearProgressIndicator: const LinearProgressIndicator(),
    ).show(context);

    setEntityState(EntityProperties.smartTvSwitchState, EntityActions.volumeUp);
  }

  Future onVolumeDown() async {
    FlushbarHelper.createLoading(
      message: 'Volume Down',
      linearProgressIndicator: const LinearProgressIndicator(),
    ).show(context);

    setEntityState(
      EntityProperties.smartTvSwitchState,
      EntityActions.volumeDown,
    );
  }

  Future onPlay() async {
    FlushbarHelper.createLoading(
      message: 'Play video',
      linearProgressIndicator: const LinearProgressIndicator(),
    ).show(context);

    setEntityState(EntityProperties.smartTvSwitchState, EntityActions.play);
  }

  Future onNetflix() async {
    FlushbarHelper.createLoading(
      message: 'Open Netflix',
      linearProgressIndicator: const LinearProgressIndicator(),
    ).show(context);

    setEntityState(
      EntityProperties.openUrl,
      EntityActions.open,
      value: HashMap.from({ActionValues.url: 'netflix'}),
    );
  }

  void onPause() {
    FlushbarHelper.createLoading(
      message: 'Close open app',
      linearProgressIndicator: const LinearProgressIndicator(),
    ).show(context);

    setEntityState(EntityProperties.smartTvSwitchState, EntityActions.pause);
  }

  void setEntityState(
    EntityProperties property,
    EntityActions action, {
    HashMap<ActionValues, dynamic>? value,
  }) {
    final VendorsAndServices? vendor =
        widget.entity.cbjDeviceVendor.vendorsAndServices;
    if (vendor == null) {
      return;
    }
    final HashMap<VendorsAndServices, HashSet<String>> uniqueIdByVendor =
        HashMap();
    uniqueIdByVendor.addEntries(
      [
        MapEntry(
          vendor,
          HashSet<String>()
            ..addAll([widget.entity.deviceCbjUniqueId.getOrCrash()]),
        ),
      ],
    );
    ConnectionsService.instance.setEntityState(
      uniqueIdByVendor: uniqueIdByVendor,
      property: property,
      actionType: action,
      value: value,
    );
  }

  void playVideo(String url) {
    FlushbarHelper.createLoading(
      message: 'Open the url',
      linearProgressIndicator: const LinearProgressIndicator(),
    ).show(context);

    setEntityState(
      EntityProperties.openUrl,
      EntityActions.open,
      value: HashMap.from({ActionValues.url: url}),
    );
  }

  void openUrlPopUp() {
    String url =
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/big_buck_bunny_1080p.mp4';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          title: const TextAtom(
            'Open URL',
            style: TextStyle(fontSize: 24.0),
          ),
          content: SizedBox(
            height: 400,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: url,
                      onChanged: (textInUrl) {
                        url = textInUrl;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter URL here',
                        labelText: 'URL',
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        playVideo(url);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        // fixedSize: Size(250, 50),
                      ),
                      child: const TextAtom(
                        "Submit",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: DeviceNameRow(
        widget.entity.cbjEntityName.getOrCrash()!,
        ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SeparatorAtom(SeparatorVariant.generalSpacing),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey,
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide.lerp(
                        const BorderSide(color: Colors.white60),
                        const BorderSide(color: Colors.white60),
                        22,
                      ),
                    ),
                  ),
                  onPressed: onPause,
                  child: Tab(
                    icon: FaIcon(
                      FontAwesomeIcons.pause,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    child: TextAtom(
                      'Pause',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SeparatorAtom(SeparatorVariant.closeWidgets),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey,
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide.lerp(
                        const BorderSide(color: Colors.white60),
                        const BorderSide(color: Colors.white60),
                        22,
                      ),
                    ),
                  ),
                  onPressed: onPlay,
                  child: Tab(
                    icon: FaIcon(
                      FontAwesomeIcons.play,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    child: TextAtom(
                      'Play',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SeparatorAtom(SeparatorVariant.generalSpacing),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey,
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide.lerp(
                        const BorderSide(color: Colors.white60),
                        const BorderSide(color: Colors.white60),
                        22,
                      ),
                    ),
                  ),
                  onPressed: onVolumeDown,
                  child: Tab(
                    icon: FaIcon(
                      FontAwesomeIcons.volumeLow,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    child: TextAtom(
                      'Down',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SeparatorAtom(SeparatorVariant.closeWidgets),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey,
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide.lerp(
                        const BorderSide(color: Colors.white60),
                        const BorderSide(color: Colors.white60),
                        22,
                      ),
                    ),
                  ),
                  onPressed: onVolumeUp,
                  child: Tab(
                    icon: FaIcon(
                      FontAwesomeIcons.volumeHigh,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    child: TextAtom(
                      'Up',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SeparatorAtom(SeparatorVariant.generalSpacing),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey,
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide.lerp(
                        const BorderSide(color: Colors.white60),
                        const BorderSide(color: Colors.white60),
                        22,
                      ),
                    ),
                  ),
                  onPressed: onNetflix,
                  child: Tab(
                    icon: FaIcon(
                      FontAwesomeIcons.video,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    child: TextAtom(
                      'Netflix',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SeparatorAtom(SeparatorVariant.generalSpacing),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey,
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide.lerp(
                        const BorderSide(color: Colors.white60),
                        const BorderSide(color: Colors.white60),
                        22,
                      ),
                    ),
                  ),
                  onPressed: openUrlPopUp,
                  child: Tab(
                    icon: FaIcon(
                      FontAwesomeIcons.video,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    child: TextAtom(
                      'Video',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SeparatorAtom(SeparatorVariant.generalSpacing),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
