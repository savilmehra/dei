import 'package:flutter/material.dart';

import '../../../utilities/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      required this.text,
      required this.press,
      this.isLoading = false})
      : super(key: key);
  final String text;
  final VoidCallback press;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),

                )
            ),
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),),
        key: Key("LoginButtonKey"),
        onPressed: () => press(),
        child: isLoading
            ? CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
