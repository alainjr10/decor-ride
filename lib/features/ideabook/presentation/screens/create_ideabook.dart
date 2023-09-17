import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:decor_ride/features/ideabook/domain/entities/create_ideabook_entity.dart';
import 'package:decor_ride/features/ideabook/presentation/providers/create_ideabooks_provider.dart';
import 'package:decor_ride/features/ideabook/presentation/states/create_ideabook_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final makePrivateProvider = StateProvider<bool>((ref) => false);

class CreateIdeabookScreen extends HookConsumerWidget {
  const CreateIdeabookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideabookNameController = useTextEditingController();
    final ideabookDescriptionController = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());
    bool makePrivate = false;
    ref.listen<CreateIdeabookState>(createIdeabookNotifierProvider, (_, state) {
      state.maybeWhen(
        orElse: () {},
        success: () {
          context.go('/ideabook');
        },
      );
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text("New IdeaBook"),
        actions: [
          TextButton(
            onPressed: () {
              if (formKey.value.currentState!.validate()) {
                final createIdeabookEntity = CreateIdeabookEntity(
                  ideabookName: ideabookNameController.text,
                  ideabookDescription: ideabookDescriptionController.text,
                  ideabookPrivate: ref.watch(makePrivateProvider),
                  ideabookId: "",
                );
                ref
                    .read(createIdeabookNotifierProvider.notifier)
                    .createIdeabook(createIdeabookEntity);
              }
            },
            child: const Text("CREATE"),
          ),
        ],
      ),
      body: ref.watch(createIdeabookNotifierProvider).when(
            initial: () => _createIdeabookForm(
                ref,
                formKey,
                ideabookNameController,
                context,
                ideabookDescriptionController,
                makePrivate),
            loading: () => Center(
              child: SizedBox(
                child: SpinKitThreeBounce(
                  size: 24,
                  color: context.colorScheme.primary,
                ),
              ),
            ),
            success: () => const Center(
              child: Text("Success"),
            ),
            error: (error) => Center(
              child: Text(error.toString()),
            ),
          ),
    );
  }

  SingleChildScrollView _createIdeabookForm(
      WidgetRef ref,
      ValueNotifier<GlobalKey<FormState>> formKey,
      TextEditingController ideabookNameController,
      BuildContext context,
      TextEditingController ideabookDescriptionController,
      bool makePrivate) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
      child: Form(
        key: formKey.value,
        child: Column(
          children: [
            TextFormField(
              controller: ideabookNameController,
              decoration: InputDecoration(
                labelText: "Ideabook Name",
                hintText: "Ideabook Name",
                hintStyle: TextStyle(
                  color: context.colorScheme.onPrimary,
                ),
                labelStyle: TextStyle(
                  color: context.colorScheme.onPrimary,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a description";
                }
                return null;
              },
            ),
            32.vGap,
            TextFormField(
              controller: ideabookDescriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Add a brief description",
                hintText: "Add a brief description",
                hintStyle: TextStyle(
                  color: context.colorScheme.onPrimary,
                ),
                labelStyle: TextStyle(
                  color: context.colorScheme.onPrimary,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a description";
                }
                return null;
              },
            ),
            40.vGap,
            SwitchListTile(
              value: ref.watch(makePrivateProvider),
              onChanged: (value) {
                ref.read(makePrivateProvider.notifier).update((state) => value);
              },
              title: const Text("Make Ideabook Private"),
            ),
          ],
        ),
      ),
    );
  }
}
