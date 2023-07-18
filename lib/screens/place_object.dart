import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class PlaceObjectScreen extends StatefulWidget {
  const PlaceObjectScreen({super.key});

  @override
  State<PlaceObjectScreen> createState() => _PlaceObjectScreenState();
}

class _PlaceObjectScreenState extends State<PlaceObjectScreen> {
  ArCoreController? arCoreController;
  ArCoreNode? node;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Object"),
      ),
      body: Stack(
        children: [
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
            enableUpdateListener: true,
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            left: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    context.push('/product_categories_screen');
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    arCoreController?.addArCoreNode(
                      ArCoreReferenceNode(
                        name: 'Reference Node',

                        // shape: ArCoreSphere(
                        //   materials: [
                        //     ArCoreMaterial(
                        //       color: Colors.red,
                        //     ),
                        //   ],
                        //   radius: 0.1,
                        // ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.access_alarms_outlined,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onNodeTap = (name) => onTapHandler(name);
    arCoreController?.onPlaneTap = _handleOnPlaneTap;
    arCoreController?.onPlaneDetected = _handleOnPlaneDetected;
  }

  Future _addSphere(ArCoreHitTestResult hit) async {
    final moonMaterial = ArCoreMaterial(color: Colors.grey);

    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: 0.03,
    );

    final moon = ArCoreNode(
      shape: moonShape,
      position: vector.Vector3(0, 0, 0),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');

    final earthMaterial = ArCoreMaterial(
      color: const Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final earthShape = ArCoreSphere(
      materials: [earthMaterial],
      radius: 0.1,
    );

    final earth = ArCoreNode(
      shape: earthShape,
      children: [moon],
      position: hit.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
      rotation: hit.pose.rotation,
    );

    arCoreController?.addArCoreNodeWithAnchor(earth);
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addSphere(hit);
  }

  void _handleOnPlaneDetected(ArCorePlane plane) {
    if (node != null) {
      arCoreController?.removeNode(nodeName: node!.name);
    }
    _addSphereOnPlane(plane);
  }

  Future _addSphereOnPlane(ArCorePlane plane) async {
    final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');

    final material = ArCoreMaterial(
        color: Color.fromARGB(120, 66, 134, 244),
        textureBytes: textureBytes.buffer.asUint8List());
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    node = ArCoreNode(
        shape: sphere,
        position: plane.centerPose?.translation,
        rotation: plane.centerPose?.rotation);
    arCoreController?.addArCoreNodeWithAnchor(node!);
  }

  void onTapHandler(String name) {
    debugPrint("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('onNodeTap on $name')),
    );
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
