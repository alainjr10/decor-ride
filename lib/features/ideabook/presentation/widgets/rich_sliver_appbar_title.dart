import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/features/ideabook/domain/entities/get_ideabook_entity.dart';
import 'package:decor_ride/utils/constants.dart';
import 'package:flutter/material.dart';

class SliverAppbarRichTitle extends StatelessWidget {
  const SliverAppbarRichTitle({
    super.key,
    required this.ideabookEntity,
  });

  final GetIdeabookEntity ideabookEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          ideabookEntity.ideabookName,
          style: kH3TextStyle(context),
        ),
        16.vGap,
        SizedBox(
          width: 140.0,
          height: 50.0,
          child: Stack(
            children: [
              Positioned(
                right: 4.0,
                child: Container(
                  width: 40.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "A",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                child: Container(
                  width: 110.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Text(
                      "+ INVITE",
                      style: context.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
