import 'package:flutter/material.dart';
import 'package:openbn/core/theme/app_text_styles.dart';

class ThemedButton extends StatelessWidget {
  final String text;
  OutlinedBorder? shape;
  void Function()? onPressed;
  bool disabled;
   ThemedButton({super.key, required this.text,this.shape,this.disabled = false,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: shape,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding:const  EdgeInsets.only(right: 10,left: 10)
      ),
      
      onPressed: onPressed,
      child: Text(text,style: MyTextStyle.chipTextWhite,),
    );
  }
}
