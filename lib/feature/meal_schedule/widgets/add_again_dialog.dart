import 'package:flutter/material.dart';
import 'package:informat/core/widgets/confirm_dialog.dart';
import 'package:nb_utils/nb_utils.dart';

class AddMoreFoodDialog extends StatelessWidget {
  const AddMoreFoodDialog({
    super.key,
    required this.onPressed,
  });
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 250,
      width: 220,
      child: Material(
        color: white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Do you want to add another food',
              style: theme.textTheme.bodyText1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('No',
                      style: theme.textTheme.subtitle1?.copyWith(
                          color: theme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'Okay',
                    style: theme.textTheme.subtitle1?.copyWith(
                      color: theme.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void showAddAgain(
  BuildContext context,
  void Function() onClicked,
) {
  showCustomDialog(
      context,
      Center(
        child: AddMoreFoodDialog(
          onPressed: onClicked,
        ),
      ));
}
