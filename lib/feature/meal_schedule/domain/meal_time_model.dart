import 'package:equatable/equatable.dart';

class MealTimeModel extends Equatable {
  final String title;
  final String? time;
  const MealTimeModel({
    required this.title,
    this.time,
  });
  @override
  List<Object?> get props => [
    '$title-$time',
   
  ];
}
