part of 'vendors_bloc.dart';

@freezed
class VendorsState with _$VendorsState {
  const factory VendorsState({
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _VendorsEvent;
// }) = _AddServiceState;

  factory VendorsState.initialized() => VendorsState(
        authFailureOrSuccessOption: none(),
      );

  const factory VendorsState.loading() = Loading;

  const factory VendorsState.loaded(KtList<VendorData> vendorsList) = Loaded;

  const factory VendorsState.error() = Error;
}
