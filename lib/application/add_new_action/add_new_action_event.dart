part of 'add_new_action_bloc.dart';

@freezed
class AddNewActionEvent with _$AddNewActionEvent {
  const factory AddNewActionEvent.actionsNameChange(String actionsName) =
      ActionsNameChange;

  const factory AddNewActionEvent.changePropertyForDevices(
    String propertyOfDevice,
  ) = ChangePropertyForDevices;

  const factory AddNewActionEvent.changeActionDevices(
    String actionForProperty,
  ) = ChangeActionDevices;

  const factory AddNewActionEvent.initialized() = Initialized;
}
