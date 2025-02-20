import 'package:auto_route/auto_route.dart';
import 'package:cbj_integrations_controller/integrations_controller.dart';
import 'package:cybearjinni/domain/cbj_comp/cbj_comp_entity.dart';
import 'package:cybearjinni/presentation/atoms/atoms.dart';
import 'package:cybearjinni/presentation/core/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/kt.dart';

class CBJCompCardWithDevicesControll extends StatelessWidget {
  const CBJCompCardWithDevicesControll({
    required this.cbjCompEntity,
  });

  final CbjCompEntity cbjCompEntity;

  Widget devicesTypes(BuildContext context) {
    final List<Widget> typesList = [];
    final KtList<GenericLightDE> deviceEntityList =
        cbjCompEntity.cBJCompDevices!.getOrCrash();

    for (final GenericLightDE deviceEntity in deviceEntityList.asList()) {
      //
      if (deviceEntity.entityTypes.getOrCrash() !=
          EntityTypes.undefined.toString()) {
        typesList.add(
          ColoredBox(
            color: Colors.yellowAccent.withOpacity(0.3),
            child: TextAtom(
              'Type: ${deviceEntity.entityTypes.getOrCrash()}',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
        );
      } else {
        typesList.add(
          ColoredBox(
            color: Colors.orange.withOpacity(0.3),
            child: TextAtom(
              'Type ${deviceEntity.entityTypes.getOrCrash()} is not supported',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
        );
      }
    }
    if (typesList.isEmpty) {
      typesList.add(const TextAtom('Computer does not contain any devices'));
    }

    final Column deviceColumn = Column(
      children: typesList.toList(),
    );

    return deviceColumn;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).textTheme.bodyLarge!.color!,
        ),
        color: Colors.purpleAccent.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                ),
                bottom: BorderSide(
                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
            ),
            child: devicesTypes(context),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.greenAccent,
              ),
            ),
            onPressed: () {
              context.router.replace(
                ConfigureNewCbjCompRoute(cbjCompEntity: cbjCompEntity),
              );
            },
            child: TextAtom(
              'Set up computer',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// CBJCompBloc
