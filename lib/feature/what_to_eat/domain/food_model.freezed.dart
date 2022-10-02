// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'food_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FoodModel _$FoodModelFromJson(Map<String, dynamic> json) {
  return _FoodModel.fromJson(json);
}

/// @nodoc
mixin _$FoodModel {
  String get id => throw _privateConstructorUsedError;
  List<String> get foods => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodModelCopyWith<FoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodModelCopyWith<$Res> {
  factory $FoodModelCopyWith(FoodModel value, $Res Function(FoodModel) then) =
      _$FoodModelCopyWithImpl<$Res>;
  $Res call({String id, List<String> foods});
}

/// @nodoc
class _$FoodModelCopyWithImpl<$Res> implements $FoodModelCopyWith<$Res> {
  _$FoodModelCopyWithImpl(this._value, this._then);

  final FoodModel _value;
  // ignore: unused_field
  final $Res Function(FoodModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? foods = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      foods: foods == freezed
          ? _value.foods
          : foods // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$$_FoodModelCopyWith<$Res> implements $FoodModelCopyWith<$Res> {
  factory _$$_FoodModelCopyWith(
          _$_FoodModel value, $Res Function(_$_FoodModel) then) =
      __$$_FoodModelCopyWithImpl<$Res>;
  @override
  $Res call({String id, List<String> foods});
}

/// @nodoc
class __$$_FoodModelCopyWithImpl<$Res> extends _$FoodModelCopyWithImpl<$Res>
    implements _$$_FoodModelCopyWith<$Res> {
  __$$_FoodModelCopyWithImpl(
      _$_FoodModel _value, $Res Function(_$_FoodModel) _then)
      : super(_value, (v) => _then(v as _$_FoodModel));

  @override
  _$_FoodModel get _value => super._value as _$_FoodModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? foods = freezed,
  }) {
    return _then(_$_FoodModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      foods: foods == freezed
          ? _value._foods
          : foods // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_FoodModel implements _FoodModel {
  _$_FoodModel({required this.id, required final List<String> foods})
      : _foods = foods;

  factory _$_FoodModel.fromJson(Map<String, dynamic> json) =>
      _$$_FoodModelFromJson(json);

  @override
  final String id;
  final List<String> _foods;
  @override
  List<String> get foods {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foods);
  }

  @override
  String toString() {
    return 'FoodModel(id: $id, foods: $foods)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FoodModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other._foods, _foods));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(_foods));

  @JsonKey(ignore: true)
  @override
  _$$_FoodModelCopyWith<_$_FoodModel> get copyWith =>
      __$$_FoodModelCopyWithImpl<_$_FoodModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FoodModelToJson(
      this,
    );
  }
}

abstract class _FoodModel implements FoodModel {
  factory _FoodModel(
      {required final String id,
      required final List<String> foods}) = _$_FoodModel;

  factory _FoodModel.fromJson(Map<String, dynamic> json) =
      _$_FoodModel.fromJson;

  @override
  String get id;
  @override
  List<String> get foods;
  @override
  @JsonKey(ignore: true)
  _$$_FoodModelCopyWith<_$_FoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}
