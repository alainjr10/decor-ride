import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/common/widgets/custom_elevated_button.dart';
import 'package:decor_ride/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum UserType { homeowner, professional }

class PersonalDetailsScreen extends ConsumerWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController postCodeController = TextEditingController();
    UserType? selectedUserType;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            60.vGap,
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Introduce yourself",
                      style: kH3TextStyle(context),
                    ),
                    40.vGap,
                    CustomTextField(
                      controller: firstNameController,
                      hintText: "First Name",
                    ),
                    24.vGap,
                    CustomTextField(
                      controller: lastNameController,
                      hintText: "Last Name",
                    ),
                    24.vGap,
                    CustomTextField(
                      controller: postCodeController,
                      hintText: "Postcode",
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Use current location",
                          style: context.textTheme.bodySmall!.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    8.vGap,
                    Text(
                      "Which describes you best",
                      style: context.textTheme.titleLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    8.vGap,
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: context.theme.disabledColor,
                      ),
                      child: RadioListTile(
                        value: UserType.professional,
                        groupValue: selectedUserType,
                        contentPadding: EdgeInsets.zero,
                        activeColor: context.colorScheme.onPrimary,
                        onChanged: (value) {},
                        title: Text(
                          "I'm a homeowner",
                          style: context.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "I am a homeowner or interested in home design",
                          style: context.textTheme.bodySmall,
                        ),
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: context.theme.disabledColor,
                      ),
                      child: RadioListTile(
                        value: UserType.professional,
                        groupValue: selectedUserType,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (value) {},
                        title: Text(
                          "I'm a professional",
                          style: context.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "I offer home improvement services or sell home products",
                          style: context.textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 90.0,
              color: context.colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomElevatedButton(
                  text: "DONE",
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.colorScheme.onSecondaryContainer,
                  height: 50.0,
                  onPressed: () {
                    context.go('/');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
  });

  final TextEditingController controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        hintStyle: TextStyle(
          color: context.colorScheme.onPrimary,
        ),
        labelStyle: TextStyle(
          color: context.colorScheme.onPrimary,
        ),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: context.colorScheme.secondaryContainer,
          ),
        ),
      ),
    );
  }
}
