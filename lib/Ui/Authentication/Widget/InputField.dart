import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final String? hintText;
  final String? errorText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final bool? enabled;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool different;

  const InputField({
    super.key,
    required this.controller,
    this.title,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.different = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: different ? bgColor :secondaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            cursorColor: Colors.white,
            enabled: enabled,
            maxLines: maxLines,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
            decoration: InputDecoration(
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white54,
                      fontWeight: FontWeight.w400,
                    ),
                enabledBorder:  OutlineInputBorder(
                  borderSide: BorderSide(
                    color: different ? bgColor: const Color.fromRGBO(74, 77, 84, 0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  //gapPadding: 16,
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                errorText: errorText),
          ),
        ),
      ],
    );
  }
}
