import 'package:cybear_jinni/domain/user/user_errors.dart';
import 'package:cybear_jinni/domain/user/user_failures.dart';
import 'package:cybear_jinni/domain/user/user_validators.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class UserValueObjectAbstract<T> {
  const UserValueObjectAbstract();

  Either<UserFailures<T>, T> get value;

  /// Throws [UnexpectedValueError] containing the [UserFailures]
  T getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold((f) => throw UserUnexpectedValueError(f), id);
  }

  Either<UserFailures<dynamic>, Unit> get failureOrUnit {
    return value.fold((l) => left(l), (r) => right(unit));
  }

  bool isValid() => value.isRight();

  @override
  String toString() => 'Value($value)';

  @override
  @nonVirtual
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is UserValueObjectAbstract<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

class UserUniqueId extends UserValueObjectAbstract<String?> {
  factory UserUniqueId() {
    return UserUniqueId._(right(const Uuid().v1()));
  }

  factory UserUniqueId.fromUniqueString(String? uniqueId) {
    assert(uniqueId != null);
    return UserUniqueId._(right(uniqueId!));
  }

  const UserUniqueId._(this.value);

  @override
  final Either<UserFailures<String>, String> value;
}

class UserEmail extends UserValueObjectAbstract<String> {
  factory UserEmail(String input) {
    return UserEmail._(
      validateUserEmailNotEmpty(input),
    );
  }

  const UserEmail._(this.value);

  @override
  final Either<UserFailures<String>, String> value;

  static const maxLength = 1000;
}

class UserName extends UserValueObjectAbstract<String> {
  factory UserName(String input) {
    return UserName._(
      validateUserNameNotEmpty(input),
    );
  }

  const UserName._(this.value);

  @override
  final Either<UserFailures<String>, String> value;

  static const maxLength = 1000;
}

class UserPass extends UserValueObjectAbstract<String> {
  factory UserPass(String input) {
    return UserPass._(
      validateUserNameNotEmpty(input),
    );
  }

  const UserPass._(this.value);

  @override
  final Either<UserFailures<String>, String> value;

  static const maxLength = 1000;
}

class UserFirstName extends UserValueObjectAbstract<String> {
  factory UserFirstName(String input) {
    return UserFirstName._(
      validateUserNameNotEmpty(input),
    );
  }

  const UserFirstName._(this.value);

  @override
  final Either<UserFailures<String>, String> value;

  static const maxLength = 1000;
}

class UserLastName extends UserValueObjectAbstract<String> {
  factory UserLastName(String input) {
    return UserLastName._(
      validateUserNameNotEmpty(input),
    );
  }

  const UserLastName._(this.value);

  @override
  final Either<UserFailures<String>, String> value;

  static const maxLength = 1000;
}
