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
  String get ownerId => throw _privateConstructorUsedError;
  String get scheduleId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  String get day => throw _privateConstructorUsedError;
  String? get recipe => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodModelCopyWith<FoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodModelCopyWith<$Res> {
  factory $FoodModelCopyWith(FoodModel value, $Res Function(FoodModel) then) =
      _$FoodModelCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String ownerId,
      String scheduleId,
      String title,
      String period,
      String day,
      String? recipe,
      String? description,
      DateTime? time});
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
    Object? ownerId = freezed,
    Object? scheduleId = freezed,
    Object? title = freezed,
    Object? period = freezed,
    Object? day = freezed,
    Object? recipe = freezed,
    Object? description = freezed,
    Object? time = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: ownerId == freezed
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleId: scheduleId == freezed
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      period: period == freezed
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      day: day == freezed
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      recipe: recipe == freezed
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_FoodModelCopyWith<$Res> implements $FoodModelCopyWith<$Res> {
  factory _$$_FoodModelCopyWith(
          _$_FoodModel value, $Res Function(_$_FoodModel) then) =
      __$$_FoodModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String ownerId,
      String scheduleId,
      String title,
      String period,
      String day,
      String? recipe,
      String? description,
      DateTime? time});
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
    Object? ownerId = freezed,
    Object? scheduleId = freezed,
    Object? title = freezed,
    Object? period = freezed,
    Object? day = freezed,
    Object? recipe = freezed,
    Object? description = freezed,
    Object? time = freezed,
  }) {
    return _then(_$_FoodModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: ownerId == freezed
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleId: scheduleId == freezed
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      period: period == freezed
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      day: day == freezed
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      recipe: recipe == freezed
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
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
      this.time})
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
  final DateTime? time;

  @override
  String toString() {
    return 'FoodModel(id: $id, ownerId: $ownerId, scheduleId: $scheduleId, title: $title, period: $period, day: $day, recipe: $recipe, description: $description, time: $time)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FoodModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.ownerId, ownerId) &&
            const DeepCollectionEquality()
                .equals(other.scheduleId, scheduleId) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.period, period) &&
            const DeepCollectionEquality().equals(other.day, day) &&
            const DeepCollectionEquality().equals(other.recipe, recipe) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.time, time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(ownerId),
      const DeepCollectionEquality().hash(scheduleId),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(period),
      const DeepCollectionEquality().hash(day),
      const DeepCollectionEquality().hash(recipe),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(time));

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
      final DateTime? time}) = _$_FoodModel;
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
  DateTime? get time;
  @override
  @JsonKey(ignore: true)
  _$$_FoodModelCopyWith<_$_FoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}
