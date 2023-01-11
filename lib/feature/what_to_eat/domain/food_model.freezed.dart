// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  String get ownerId => throw _privateConstructorUsedError;
  String get scheduleId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  String get day => throw _privateConstructorUsedError;
  String? get recipe => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodModelCopyWith<FoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodModelCopyWith<$Res> {
  factory $FoodModelCopyWith(FoodModel value, $Res Function(FoodModel) then) =
      _$FoodModelCopyWithImpl<$Res, FoodModel>;
  @useResult
  $Res call(
      {String id,
      String ownerId,
      String scheduleId,
      String title,
      String period,
      String day,
      String? recipe,
      String? description,
      DateTime? lastUpdated});
}

/// @nodoc
class _$FoodModelCopyWithImpl<$Res, $Val extends FoodModel>
    implements $FoodModelCopyWith<$Res> {
  _$FoodModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? scheduleId = null,
    Object? title = null,
    Object? period = null,
    Object? day = null,
    Object? recipe = freezed,
    Object? description = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleId: null == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      recipe: freezed == recipe
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FoodModelCopyWith<$Res> implements $FoodModelCopyWith<$Res> {
  factory _$$_FoodModelCopyWith(
          _$_FoodModel value, $Res Function(_$_FoodModel) then) =
      __$$_FoodModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String ownerId,
      String scheduleId,
      String title,
      String period,
      String day,
      String? recipe,
      String? description,
      DateTime? lastUpdated});
}

/// @nodoc
class __$$_FoodModelCopyWithImpl<$Res>
    extends _$FoodModelCopyWithImpl<$Res, _$_FoodModel>
    implements _$$_FoodModelCopyWith<$Res> {
  __$$_FoodModelCopyWithImpl(
      _$_FoodModel _value, $Res Function(_$_FoodModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? scheduleId = null,
    Object? title = null,
    Object? period = null,
    Object? day = null,
    Object? recipe = freezed,
    Object? description = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$_FoodModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleId: null == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      recipe: freezed == recipe
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_FoodModel extends _FoodModel {
  _$_FoodModel(
      {required this.id,
      required this.ownerId,
      required this.scheduleId,
      required this.title,
      required this.period,
      required this.day,
      this.recipe,
      this.description,
      this.lastUpdated})
      : super._();

  factory _$_FoodModel.fromJson(Map<String, dynamic> json) =>
      _$$_FoodModelFromJson(json);

  @override
  final String id;
  @override
  final String ownerId;
  @override
  final String scheduleId;
  @override
  final String title;
  @override
  final String period;
  @override
  final String day;
  @override
  final String? recipe;
  @override
  final String? description;
  @override
  final DateTime? lastUpdated;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FoodModelCopyWith<_$_FoodModel> get copyWith =>
      __$$_FoodModelCopyWithImpl<_$_FoodModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FoodModelToJson(
      this,
    );
  }
}

abstract class _FoodModel extends FoodModel {
  factory _FoodModel(
      {required final String id,
      required final String ownerId,
      required final String scheduleId,
      required final String title,
      required final String period,
      required final String day,
      final String? recipe,
      final String? description,
      final DateTime? lastUpdated}) = _$_FoodModel;
  _FoodModel._() : super._();

  factory _FoodModel.fromJson(Map<String, dynamic> json) =
      _$_FoodModel.fromJson;

  @override
  String get id;
  @override
  String get ownerId;
  @override
  String get scheduleId;
  @override
  String get title;
  @override
  String get period;
  @override
  String get day;
  @override
  String? get recipe;
  @override
  String? get description;
  @override
  DateTime? get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$_FoodModelCopyWith<_$_FoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}
