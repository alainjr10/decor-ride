import 'package:decor_ride/app/providers/app_theme_provider.dart';
import 'package:decor_ride/screens/augmented_faces.dart';
import 'package:decor_ride/screens/augmented_images.dart';
import 'package:decor_ride/screens/image_object.dart';
import 'package:decor_ride/screens/matri_3d.dart';
import 'package:decor_ride/screens/multiple_augmented_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'screens/hello_world.dart';
import 'screens/custom_object.dart';
import 'screens/runtime_materials.dart';
import 'screens/texture_and_rotation.dart';
import 'screens/assets_object.dart';
import 'screens/auto_detect_plane.dart';
import 'screens/remote_object.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDarkMode = ref.watch(appThemeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArCore Demo'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HelloWorld()));
            },
            title: Text("Hello World"),
          ),
          ListTile(
            onTap: () {
              // context.push('/place_object');
              context.go('/place_object');
            },
            title: Text("Place Object"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ImageObjectScreen()));
            },
            title: Text("Image"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AugmentedPage()));
            },
            title: Text("AugmentedPage"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MultipleAugmentedImagesPage()));
            },
            title: Text("Multiple augmented images"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CustomObject()));
            },
            title: Text("Custom Anchored Object with onTap"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RuntimeMaterials()));
            },
            title: Text("Change Materials Property in runtime"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ObjectWithTextureAndRotation()));
            },
            title: Text("Custom object with texture and rotation listener "),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AutoDetectPlane()));
            },
            title: Text("Plane detect handler"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Matrix3DRenderingPage()));
            },
            title: Text("3D Matrix"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AssetsObject()));
            },
            title: Text("Custom sfb object"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RemoteObject()));
            },
            title: Text("Remote object"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AugmentedFacesScreen()));
            },
            title: Text("Augmented Faces"),
          ),
          ListTile(
            leading: Icon(isDarkMode ? Icons.brightness_3 : Icons.sunny),
            title: Text(
              isDarkMode ? "Dark mode" : "Light mode",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Consumer(
              builder: (context, ref, child) {
                return Transform.scale(
                  scale: 1.0,
                  child: Switch(
                    // activeColor: Colors.orange,
                    onChanged: (value) {
                      ref.read(appThemeProvider.notifier).state = value;
                    },
                    value: isDarkMode,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
