import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomIosDialog extends StatelessWidget {
  const CustomIosDialog({
    super.key,
    required this.onPressed,
  });
  final Function() onPressed;
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width / 8.0),
        height: 250,
        child: Material(
          clipBehavior: Clip.hardEdge,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Terms & Conditions',
                  style: theme.textTheme.headline2?.copyWith(fontSize: 18.0),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 8.0),
                    // child: Text(
                    //   'By clicking continue, you\'re agreeing to this terms of services and you accept this Privacy policy.',
                    //   textAlign: TextAlign.justify,
                    //   style: theme.textTheme.subtitle2,
                    // ),
                    child: RichText(
                      text: TextSpan(
                          text:
                              'By clicking Continue, you\'re agreeing to this ',
                          style: theme.textTheme.subtitle1?.copyWith(
                            color: theme.primaryColorLight,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms of services',
                              style: theme.textTheme.subtitle1?.copyWith(
                                color: theme.primaryColor,
                              ),
                              onEnter: (event) {
                                log('I am clicked');
                              },
                            ),
                            TextSpan(
                              text: ' and you accept this ',
                              style: theme.textTheme.subtitle1?.copyWith(
                                color: theme.primaryColorLight,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy policy.',
                              style: theme.textTheme.subtitle1?.copyWith(
                                color: theme.primaryColor,
                              ),
                              onEnter: (event) {
                                log('I am clicked');
                              },
                            ),
                          ]),
                    ),
                  ),
                ),
                const Divider(),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'Continue',
                    style: theme.textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Future<void> showPolicyDialog(
//   BuildContext context,
//   Widget child, {
//   bool? dismissible,
// }) {
//   return showDialog(
//     context: context,
//     barrierDismissible: dismissible ?? false,
//     builder: (context) => child,
//   );
// }
