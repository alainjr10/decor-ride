import 'package:decor_ride/app/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Coming Soon...\n Check Ideabooks section and create your first ideabook",
            style: context.textTheme.titleLarge!
                .copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          16.vGap,
          Text(
            "OR",
            style: context.textTheme.headlineMedium!
                .copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          16.vGap,
          TextButton(
            onPressed: () {
              context.push('/ar_main_view');
            },
            child: const Text("Demo AR View"),
          ),
        ],
      ),
    );
  }
}

// class HomeScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var isDarkMode = ref.watch(appThemeProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ArCore Demo'),
//       ),
//       body: ListView(
//         children: <Widget>[
//           ListTile(
//             onTap: () {
//               Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (context) => HelloWorld()));
//             },
//             title: Text("Hello World"),
//           ),
//           ListTile(
//             onTap: () {
//               // context.push('/place_object');
//               context.go('/place_object');
//             },
//             title: Text("Place Object"),
//           ),
//           ListTile(
//             onTap: () {
//               // Navigator.of(context)
//               //     .push(MaterialPageRoute(builder: (context) => ARMainView()));
//               context.pushNamed(
//                 'category_products_screen',
//                 pathParameters: {
//                   'categoryTag': 'furniture',
//                 },
//               ); // this is the category tag
//             },
//             title: Text("AR Main View"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const ModelViewerScreen()));
//             },
//             title: Text("Model Viewer Plus"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const LocalAndWebObjectsView()));
//             },
//             title: Text("AR Flutter Plugin"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => ObjectGesturesWidget()));
//             },
//             title: Text("AR Flutter Plugin - Objects On Plane"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => ImageObjectScreen()));
//             },
//             title: Text("Image"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => AugmentedPage()));
//             },
//             title: Text("AugmentedPage"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => MultipleAugmentedImagesPage()));
//             },
//             title: Text("Multiple augmented images"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => CustomObject()));
//             },
//             title: Text("Custom Anchored Object with onTap"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => RuntimeMaterials()));
//             },
//             title: Text("Change Materials Property in runtime"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => ObjectWithTextureAndRotation()));
//             },
//             title: Text("Custom object with texture and rotation listener "),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => AutoDetectPlane()));
//             },
//             title: Text("Plane detect handler"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => Matrix3DRenderingPage()));
//             },
//             title: Text("3D Matrix"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => AssetsObject()));
//             },
//             title: Text("Custom sfb object"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => RemoteObject()));
//             },
//             title: Text("Remote object"),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => AugmentedFacesScreen()));
//             },
//             title: Text("Augmented Faces"),
//           ),
//           ListTile(
//             leading: Icon(isDarkMode ? Icons.brightness_3 : Icons.sunny),
//             title: Text(
//               isDarkMode ? "Dark mode" : "Light mode",
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//             trailing: Consumer(
//               builder: (context, ref, child) {
//                 return Transform.scale(
//                   scale: 1.0,
//                   child: Switch(
//                     // activeColor: Colors.orange,
//                     onChanged: (value) {
//                       ref.read(appThemeProvider.notifier).state = value;
//                     },
//                     value: isDarkMode,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
