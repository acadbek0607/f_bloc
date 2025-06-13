import 'package:f_bloc/auth/core/utils/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.iconPath,
    required this.label,
    this.horizontalPadding = 100.0,
  });

  final String iconPath;
  final String label;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: SvgPicture.asset(iconPath, width: 25),
      label: Text(
        label,
        style: const TextStyle(fontSize: 17, color: Pallete.whiteColor),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: horizontalPadding,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Pallete.borderColor, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
