import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';

import '../../Authentication/Widget/InputField.dart';

class PostForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final TextEditingController descriptionController;

  const PostForm(
      {super.key,
      required this.titleController,
      required this.amountController,
      required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        InputField(
          controller: titleController,
          hintText: "job title",
          title: "Job Title",
          different: true,
        ),
        const SizedBox(
          height: 10,
        ),
        InputField(
          controller: amountController,
          hintText: "amount",
          title: "Amount",
          different: true,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Description",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: descriptionController,
          obscureText: false,
          cursorColor: Colors.white,
          enabled: true,
          maxLines: 4,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
          decoration: InputDecoration(
            fillColor: bgColor,
            filled: true,
            hintText: "description",
            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white54,
                  fontWeight: FontWeight.w400,
                ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(74, 77, 84, 0.2),
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
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
