import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/helpers/image_processors.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';

class ScheduleMealCard extends StatelessWidget {
  const ScheduleMealCard({
    super.key,
    required this.foodModel,
  });
  final FoodModel foodModel;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          foodModel.period,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          foodModel.mealTime ?? '',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: theme.primaryColor),
          child: Container(
            height: 150,
            width: 150,
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: foodModel.imageUrl != null
                ? getImageWidget(foodModel.imageUrl!)
                : const Card(
                    child: CircleAvatar(
                      child: Icon(Icons.food_bank),
                    ),
                  ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
            width: 200,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Text(
              foodModel.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 14,
              ),
            ))
      ],
    );
  }
}
