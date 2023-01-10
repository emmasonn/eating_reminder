import 'package:equatable/equatable.dart';

abstract class DataModel extends Equatable {
   final String? id;
   const DataModel({required this.id});
  //  DataModel copyWith2(String? newId);
}