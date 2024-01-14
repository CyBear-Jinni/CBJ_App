import 'dart:collection';

import 'package:cbj_integrations_controller/integrations_controller.dart';
import 'package:cybearjinni/domain/connections_service.dart';
import 'package:cybearjinni/presentation/atoms/atoms.dart';
import 'package:cybearjinni/presentation/molecules/molecules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Show light toggles in a container with the background color from smart area
/// object
class RgbwLightMolecule extends StatefulWidget {
  const RgbwLightMolecule(this.entity);

  final GenericRgbwLightDE entity;

  @override
  State<RgbwLightMolecule> createState() => _RgbwLightMoleculeState();
}

class _RgbwLightMoleculeState extends State<RgbwLightMolecule> {
  int colorTemperature = 4500;
  HSVColor hsvColor = HSVColor.fromColor(Colors.white);
  double brightness = 100;

  @override
  void initState() {
    super.initState();
    _initialized();
  }

  Future _initialized() async {
    final GenericRgbwLightDE rgbwLightDe = widget.entity;

    int lightColorTemperature =
        int.parse(rgbwLightDe.lightColorTemperature.getOrCrash());

    if (lightColorTemperature > 10000) {
      lightColorTemperature = 10000;
    }

    double lightBrightness =
        double.parse(rgbwLightDe.lightBrightness.getOrCrash());

    if (lightBrightness > 100) {
      lightBrightness = 100;
    }

    setState(() {
      colorTemperature = lightColorTemperature;
      brightness = lightBrightness;
    });
  }

  void _onChange(bool value) {
    setEntityState(
      EntityProperties.lightSwitchState,
      value ? EntityActions.on : EntityActions.off,
    );
  }

  void setEntityState(
    EntityProperties entityProperties,
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
      RequestActionObject(
        uniqueIdByVendor: uniqueIdByVendor,
        property: entityProperties,
        actionType: action,
        value: value,
      ),
    );
  }

  Future _changeBrightness(double value) async {
    setState(() {
      brightness = value;
    });
    setEntityState(
      EntityProperties.lightBrightness,
      EntityActions.actionNotSupported,
      value: HashMap.from({ActionValues.brightness: value.round()}),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;
    final TextTheme textTheme = themeData.textTheme;

    return Column(
      children: [
        DeviceNameRowMolecule(
          widget.entity.cbjEntityName.getOrCrash()!,
          SwitchAtom(
            variant: SwitchVariant.light,
            onToggle: _onChange,
            action: widget.entity.lightSwitchState.action,
            state: widget.entity.entityStateGRPC.state,
          ),
        ),
        const SeparatorAtom(variant: SeparatorVariant.reletedElements),
        LightColorMods(entity: widget.entity),
        Row(
          children: [
            const FaIcon(FontAwesomeIcons.solidSun),
            Expanded(
              child: Slider(
                thumbColor: colorScheme.onBackground,
                activeColor: colorScheme.tertiary,
                inactiveColor: colorScheme.outline,
                value: brightness,
                divisions: 100,
                min: 1,
                max: 100,
                onChanged: _changeBrightness,
              ),
            ),
            SizedBox(
              width: 45,
              child: TextAtom(
                '${brightness.round()}%',
                style: textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LightColorMods extends StatefulWidget {
  const LightColorMods({
    required this.entity,
    this.brightness = 100,
    this.colorTemperature = 4500,
    this.hsvColor,
  });

  final GenericRgbwLightDE entity;
  final int colorTemperature;
  final HSVColor? hsvColor;
  final double brightness;

  @override
  State<StatefulWidget> createState() {
    return _LightColorMods();
  }
}

class _LightColorMods extends State<LightColorMods> {
  late int colorTemperature;
  late HSVColor hsvColor;
  late double brightness;

  @override
  void initState() {
    super.initState();
    hsvColor = widget.hsvColor ?? HSVColor.fromColor(Colors.white);
    colorTemperature = widget.colorTemperature;
    brightness = widget.brightness;
    _initialized();
  }

  Future _initialized() async {
    final GenericRgbwLightDE rgbwLightDe = widget.entity;

    int lightColorTemperature =
        int.parse(rgbwLightDe.lightColorTemperature.getOrCrash());

    if (lightColorTemperature > 10000) {
      lightColorTemperature = 10000;
    }

    double lightBrightness =
        double.parse(rgbwLightDe.lightBrightness.getOrCrash());

    if (lightBrightness > 100) {
      lightBrightness = 100;
    }

    setState(() {
      colorTemperature = lightColorTemperature;
      brightness = lightBrightness;
    });
  }

  void setEntityState(
    EntityProperties entityProperties,
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
      RequestActionObject(
        uniqueIdByVendor: uniqueIdByVendor,
        property: entityProperties,
        actionType: action,
        value: value,
      ),
    );
  }

  Future _changeColorTemperature(int newColorTemperature) async {
    setState(() {
      colorTemperature = newColorTemperature;
    });
    setEntityState(
      EntityProperties.lightColorTemperature,
      EntityActions.changeTemperature,
      value: HashMap.from({ActionValues.temperature: newColorTemperature}),
    );
  }

  Future _changeHsvColor(HSVColor newHsvColor) async {
    setState(() {
      hsvColor = newHsvColor;
    });

    setEntityState(
      EntityProperties.color,
      EntityActions.hsvColor,
      value: HashMap.from({
        ActionValues.alpha: newHsvColor.alpha,
        ActionValues.hue: newHsvColor.hue,
        ActionValues.saturation: newHsvColor.saturation,
        ActionValues.value: newHsvColor.value,
      }),
    );
  }

  late Widget colorModeWidget;
  int colorModFocus = 0;

  Widget getWhiteModeWidget() {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          stops: const [0.1, 0.5, 0.9],
          colors: [
            Colors.orangeAccent[200]!,
            Colors.white,
            Colors.lightBlue[200]!,
          ],
        ),
      ),
      child: Slider(
        activeColor: Colors.black.withOpacity(0.8),
        value: colorTemperature.toDouble(),
        min: 900,
        max: 10000,
        onChanged: (double newRating) {
          _changeColorTemperature(newRating.toInt());
        },
      ),
    );
  }

  Widget getHsvColorModeWidget() {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ColorPickerArea(
        hsvColor,
        _changeHsvColor,
        PaletteType.hsvWithValue,
      ),
    );
  }

  Future _showWhiteMode() async {
    setState(() {
      colorModFocus = 0;
      colorModeWidget = getWhiteModeWidget();
    });
  }

  Future _showColorMode() async {
    setState(() {
      colorModFocus = 1;
      colorModeWidget = getHsvColorModeWidget();
    });
  }

  Widget lightModBarFocus() {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    return Column(
      children: [
        colorModeWidget,
        const SeparatorAtom(variant: SeparatorVariant.reletedElements),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              child: TextAtom(
                'White',
                style: TextStyle(
                  color: (colorModFocus == 0)
                      ? colorScheme.primary
                      : colorScheme.onBackground,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                _showWhiteMode();
              },
            ),
            OutlinedButton(
              child: TextAtom(
                'Color',
                style: TextStyle(
                  color: (colorModFocus == 1)
                      ? colorScheme.primary
                      : colorScheme.onBackground,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                _showColorMode();
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (colorModFocus == 0) {
      colorModeWidget = getWhiteModeWidget();
    } else {
      colorModeWidget = getHsvColorModeWidget();
    }

    return lightModBarFocus();
  }
}
