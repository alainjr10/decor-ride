import 'package:decor_ride/app/theme_extension.dart';
import 'package:flutter/material.dart';

class MoreIdeasTab extends StatelessWidget {
  const MoreIdeasTab({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "https://st.hzcdn.com/simgs/pictures/bedrooms/sims-hilditch-cotswold-manor-house-sims-hilditch-img~e231e0960447b138_3-1715-1-2bb87ae.jpg",
      "https://st.hzcdn.com/simgs/ea1140a30fbc0276_3-0537/traditional-bedroom.jpg",
      "https://st.hzcdn.com/simgs/e7f1a2bc0256f5a8_3-5674/transitional-bedroom.jpg",
      "https://st.hzcdn.com/simgs/c5e111a1001bb5cd_3-6994/transitional-bedroom.jpg",
      "https://st.hzcdn.com/simgs/pictures/bedrooms/vern-yip-s-rosemary-beach-vacation-home-marvin-img~f4d1e1650b75a040_3-7990-1-dda2238.jpg",
      "https://st.hzcdn.com/simgs/pictures/bedrooms/altis-wl-harder-inc-img~79f1e4b1087679b7_3-9216-1-636f256.jpg",
    ];
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 1 / 1.2,
      ),
      itemCount: 12,
      itemBuilder: (_, index) {
        return images.map((e) {
          return Stack(
            children: [
              Container(
                height: context.height,
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    image: NetworkImage(e),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  width: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.secondary.withOpacity(0.9),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      size: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList()[index % 6];
      },
    );
  }
}
