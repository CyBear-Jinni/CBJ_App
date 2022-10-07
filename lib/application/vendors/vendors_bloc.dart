import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cybear_jinni/domain/auth/auth_failure.dart';
import 'package:cybear_jinni/domain/vendors/i_vendor_repository.dart';
import 'package:cybear_jinni/domain/vendors/vendor.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

part 'vendors_bloc.freezed.dart';
part 'vendors_event.dart';
part 'vendors_state.dart';

@injectable
class VendorsBloc extends Bloc<VendorsEvent, VendorsState> {
  VendorsBloc(this._vendorRepository) : super(VendorsState.initialized()) {
    on<Initialized>(_initialized);
  }

  final IVendorsRepository _vendorRepository;

  Future<void> _initialized(
    Initialized event,
    Emitter<VendorsState> emit,
  ) async {
    final vendorsList = await _vendorRepository.getVendors();
    emit(
      vendorsList.fold(
        (f) => const VendorsState.error(),
        (vendorsListSuccess) => VendorsState.loaded(vendorsListSuccess),
      ),
    );
  }
}
