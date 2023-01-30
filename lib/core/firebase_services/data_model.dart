import 'package:equatable/equatable.dart';

abstract class DataModel extends Equatable {
  final String? id;
  final String? imageUrl;
  const DataModel({
    this.id,
    this.imageUrl,
  });
}
