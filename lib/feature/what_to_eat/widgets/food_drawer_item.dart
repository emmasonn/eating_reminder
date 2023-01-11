import 'package:flutter/material.dart';

class FoodDrawerItem extends StatelessWidget {
  const FoodDrawerItem({
    Key? key,
    required this.title,
    this.icon,
    required this.isActive,
    required this.onPressed,
  }) : super(key: key);

  final bool isActive;
  final String title;
  final IconData? icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: isActive ? 'RubikBold' : 'RubikRegular',
                fontSize: isActive ? 16 : 14,
                color: isActive ? theme.primaryColor : theme.primaryColorLight,
              ),
            ),
            if (icon != null) ...[
              Icon(
                Icons.verified,
                size: 14,
                color: theme.primaryColor,
              )
            ]
          ],
        ),
      ),
    );
  }
}
