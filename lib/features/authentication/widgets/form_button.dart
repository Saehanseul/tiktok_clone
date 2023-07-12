import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
  });

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        duration: const Duration(
          microseconds: 300,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: disabled
                ? Colors.grey.shade300
                : Theme.of(context).primaryColor),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(
            milliseconds: 300,
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabled ? Colors.grey.shade500 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          child: const Text("Next"),
        ),
      ),
    );
  }
}
