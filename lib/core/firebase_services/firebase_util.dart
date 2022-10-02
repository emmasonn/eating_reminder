enum FilterType { equals, greaterThan, whereIn }

class WhereClause {
  const WhereClause._({
    required this.fieldName,
    required this.type,
    required this.value,
  });

  final String fieldName;
  final Object type;
  final Object value;

  const factory WhereClause.equals({
    required String fieldName,
    required Object value,
  }) = _WhereClauseEqual;

  const factory WhereClause.greaterThan({
    required String fieldName,
    required Object value,
  }) = _WhereClauseGreaterThan;

  const factory WhereClause.whereIn({
    required String fieldName,
    required List<Object> value,
  }) = _WhereClauseWhereIn;
}

class _WhereClauseEqual extends WhereClause {
  const _WhereClauseEqual({
    required String fieldName,
    required Object value,
  }) : super._(fieldName: fieldName, type: FilterType.equals, value: value);
}

class _WhereClauseGreaterThan extends WhereClause {
  const _WhereClauseGreaterThan({
    required String fieldName,
    required Object value,
  }) : super._(
          fieldName: fieldName,
          type: FilterType.greaterThan,
          value: value,
        );
}

class _WhereClauseWhereIn extends WhereClause {
  const _WhereClauseWhereIn({
    required String fieldName,
    required List<Object> value,
  }) : super._(
          fieldName: fieldName,
          type: FilterType.whereIn,
          value: value,
        );
}
