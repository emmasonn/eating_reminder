
import 'package:flutter/material.dart';

class AppCreditCardField extends StatefulWidget {
  const AppCreditCardField({Key? key}) : super(key: key);

  @override
  State<AppCreditCardField> createState() => _AppCreditCardFieldState();
}

class _AppCreditCardFieldState extends State<AppCreditCardField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(

        decoration: InputDecoration(
        prefix: SizedBox(
          child: Row(
            children: const [
              Text('+234'),
              Divider(
                color: Colors.black,
              )
            ],
          ),
        ),
          border: InputBorder.none,
          hintText: 'Card Number',
          hintStyle: theme.textTheme.headline6,

        ),
        keyboardType: TextInputType.number,
        autocorrect: false,

      ),
    );
  }
}
