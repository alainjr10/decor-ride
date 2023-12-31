// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthStates {
  EmailAddress get emailAddress => throw _privateConstructorUsedError;
  Password get password => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  bool get showError => throw _privateConstructorUsedError;
  bool get authSuccess => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  Option<Either<AuthFailures, Unit>> get authFailureOrSuccess =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStatesCopyWith<AuthStates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStatesCopyWith<$Res> {
  factory $AuthStatesCopyWith(
          AuthStates value, $Res Function(AuthStates) then) =
      _$AuthStatesCopyWithImpl<$Res, AuthStates>;
  @useResult
  $Res call(
      {EmailAddress emailAddress,
      Password password,
      bool isSubmitting,
      bool showError,
      bool authSuccess,
      String errorMessage,
      Option<Either<AuthFailures, Unit>> authFailureOrSuccess});
}

/// @nodoc
class _$AuthStatesCopyWithImpl<$Res, $Val extends AuthStates>
    implements $AuthStatesCopyWith<$Res> {
  _$AuthStatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailAddress = null,
    Object? password = null,
    Object? isSubmitting = null,
    Object? showError = null,
    Object? authSuccess = null,
    Object? errorMessage = null,
    Object? authFailureOrSuccess = null,
  }) {
    return _then(_value.copyWith(
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as EmailAddress,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      showError: null == showError
          ? _value.showError
          : showError // ignore: cast_nullable_to_non_nullable
              as bool,
      authSuccess: null == authSuccess
          ? _value.authSuccess
          : authSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      authFailureOrSuccess: null == authFailureOrSuccess
          ? _value.authFailureOrSuccess
          : authFailureOrSuccess // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailures, Unit>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthStatesCopyWith<$Res>
    implements $AuthStatesCopyWith<$Res> {
  factory _$$_AuthStatesCopyWith(
          _$_AuthStates value, $Res Function(_$_AuthStates) then) =
      __$$_AuthStatesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {EmailAddress emailAddress,
      Password password,
      bool isSubmitting,
      bool showError,
      bool authSuccess,
      String errorMessage,
      Option<Either<AuthFailures, Unit>> authFailureOrSuccess});
}

/// @nodoc
class __$$_AuthStatesCopyWithImpl<$Res>
    extends _$AuthStatesCopyWithImpl<$Res, _$_AuthStates>
    implements _$$_AuthStatesCopyWith<$Res> {
  __$$_AuthStatesCopyWithImpl(
      _$_AuthStates _value, $Res Function(_$_AuthStates) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailAddress = null,
    Object? password = null,
    Object? isSubmitting = null,
    Object? showError = null,
    Object? authSuccess = null,
    Object? errorMessage = null,
    Object? authFailureOrSuccess = null,
  }) {
    return _then(_$_AuthStates(
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as EmailAddress,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      showError: null == showError
          ? _value.showError
          : showError // ignore: cast_nullable_to_non_nullable
              as bool,
      authSuccess: null == authSuccess
          ? _value.authSuccess
          : authSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      authFailureOrSuccess: null == authFailureOrSuccess
          ? _value.authFailureOrSuccess
          : authFailureOrSuccess // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailures, Unit>>,
    ));
  }
}

/// @nodoc

class _$_AuthStates with DiagnosticableTreeMixin implements _AuthStates {
  const _$_AuthStates(
      {required this.emailAddress,
      required this.password,
      required this.isSubmitting,
      required this.showError,
      required this.authSuccess,
      required this.errorMessage,
      required this.authFailureOrSuccess});

  @override
  final EmailAddress emailAddress;
  @override
  final Password password;
  @override
  final bool isSubmitting;
  @override
  final bool showError;
  @override
  final bool authSuccess;
  @override
  final String errorMessage;
  @override
  final Option<Either<AuthFailures, Unit>> authFailureOrSuccess;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthStates(emailAddress: $emailAddress, password: $password, isSubmitting: $isSubmitting, showError: $showError, authSuccess: $authSuccess, errorMessage: $errorMessage, authFailureOrSuccess: $authFailureOrSuccess)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthStates'))
      ..add(DiagnosticsProperty('emailAddress', emailAddress))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('isSubmitting', isSubmitting))
      ..add(DiagnosticsProperty('showError', showError))
      ..add(DiagnosticsProperty('authSuccess', authSuccess))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('authFailureOrSuccess', authFailureOrSuccess));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthStates &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.showError, showError) ||
                other.showError == showError) &&
            (identical(other.authSuccess, authSuccess) ||
                other.authSuccess == authSuccess) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.authFailureOrSuccess, authFailureOrSuccess) ||
                other.authFailureOrSuccess == authFailureOrSuccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, emailAddress, password,
      isSubmitting, showError, authSuccess, errorMessage, authFailureOrSuccess);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthStatesCopyWith<_$_AuthStates> get copyWith =>
      __$$_AuthStatesCopyWithImpl<_$_AuthStates>(this, _$identity);
}

abstract class _AuthStates implements AuthStates {
  const factory _AuthStates(
      {required final EmailAddress emailAddress,
      required final Password password,
      required final bool isSubmitting,
      required final bool showError,
      required final bool authSuccess,
      required final String errorMessage,
      required final Option<Either<AuthFailures, Unit>>
          authFailureOrSuccess}) = _$_AuthStates;

  @override
  EmailAddress get emailAddress;
  @override
  Password get password;
  @override
  bool get isSubmitting;
  @override
  bool get showError;
  @override
  bool get authSuccess;
  @override
  String get errorMessage;
  @override
  Option<Either<AuthFailures, Unit>> get authFailureOrSuccess;
  @override
  @JsonKey(ignore: true)
  _$$_AuthStatesCopyWith<_$_AuthStates> get copyWith =>
      throw _privateConstructorUsedError;
}
