import 'package:decor_ride/app/providers/global_providers.dart';
import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/common/widgets/custom_elevated_button.dart';
import 'package:decor_ride/features/auth/domain/entities/create_user_entity.dart';
import 'package:decor_ride/features/auth/presentation/providers/auth_provider.dart';
import 'package:decor_ride/features/auth/presentation/providers/states/auth_states.dart';
import 'package:decor_ride/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum UserType { homeowner, professional }

final userTypeProvider = StateProvider<UserType>((ref) {
  return UserType.homeowner;
});

class PersonalDetailsScreen extends HookConsumerWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final postCodeController = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());

    final registerProvider = ref.watch(authNotifierProvider);

    ref.listen<AuthStates>(authNotifierProvider, (_, state) {
      if (state.authSuccess == true &&
          state.showError == false &&
          state.isSubmitting == false) {
        context.go('/');
      } else if (state.authSuccess == false && state.showError == true) {
        // context.showErrorSnackBar("Error registering user");
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey.value,
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
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "First name cannot be empty";
                          }
                          return null;
                        },
                      ),
                      24.vGap,
                      CustomTextField(
                        controller: lastNameController,
                        hintText: "Last Name",
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Last name cannot be empty";
                          }
                          return null;
                        },
                      ),
                      24.vGap,
                      CustomTextField(
                        controller: postCodeController,
                        hintText: "Postcode",
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Postcode cannot be empty";
                          }
                          return null;
                        },
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
                          value: UserType.homeowner,
                          groupValue: ref.watch(userTypeProvider),
                          contentPadding: EdgeInsets.zero,
                          activeColor: context.colorScheme.primary,
                          onChanged: (value) {
                            ref.read(userTypeProvider.notifier).state = value!;
                          },
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
                          groupValue: ref.watch(userTypeProvider),
                          contentPadding: EdgeInsets.zero,
                          activeColor: context.colorScheme.primary,
                          onChanged: (value) {
                            ref.read(userTypeProvider.notifier).state = value!;
                          },
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
                    isLoading: registerProvider.isSubmitting,
                    backgroundColor: context.colorScheme.primary,
                    foregroundColor: context.colorScheme.onSecondaryContainer,
                    height: 50.0,
                    onPressed: () {
                      if (formKey.value.currentState!.validate()) {
                        CreateUserEntity createUserEntity = CreateUserEntity(
                          email: ref.watch(emailProvider),
                          password: ref.watch(passwordProvider),
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          postCode: postCodeController.text,
                          userType: ref.watch(userTypeProvider).name.toString(),
                        );
                        "user entity is ${createUserEntity.toString()}".log();
                        "state before read is $registerProvider".log();
                        ref
                            .read(authNotifierProvider.notifier)
                            .registerUserWithEmailAndPassword(
                                createUserEntity: createUserEntity);
                        "state After read is $registerProvider".log();
                        // context.go('/');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
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
    this.validator,
  });

  final TextEditingController controller;
  final String? hintText;
  // validator function
  final String? Function(String?)? validator;

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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator ?? (value) => null,
    );
  }
}
