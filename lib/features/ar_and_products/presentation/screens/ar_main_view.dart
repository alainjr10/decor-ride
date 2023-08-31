import 'dart:developer';
import 'dart:io';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:decor_ride/app/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math_64.dart' as math64;

class ARMainView extends StatefulWidget {
  const ARMainView({Key? key}) : super(key: key);
  @override
  // _ARMainViewState createState() => _ARMainViewState();
  State<ARMainView> createState() => _ARMainViewState();
}

class _ARMainViewState extends State<ARMainView> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  String? selectedNodeUrl;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  Directory? _appDocumentsDirectory;

  void _requestAppDocumentsDirectory() async {
    _appDocumentsDirectory = await getApplicationDocumentsDirectory();
    log("App documents directory is ${_appDocumentsDirectory!.path}");
  }

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   arSessionManager!.onInitialize(
  //     showFeaturePoints: false,
  //     showPlanes: true,
  //     customPlaneTexturePath: "assets/triangle.png",
  //     showWorldOrigin: true,
  //     handlePans: true,
  //     handleRotation: true,
  //   );
  //   arObjectManager!.onInitialize();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Main View'),
      ),
      body: SizedBox(
        child: Stack(
          children: [
            ARView(
              onARViewCreated: onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            ),
            Positioned(
              // alignment: FractionalOffset.bottomCenter,
              bottom: 8.0,
              right: 32.0,
              left: 32.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 2.0, color: const Color(0xFFFFFFFF)),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.label_rounded,
                                size: 24.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          8.vGap,
                          Text(
                            "List",
                            style: context.theme.textTheme.bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onTakeScreenshot();
                      },
                      icon: Icon(
                        Icons.circle,
                        size: 64.0,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // arSessionManager!.dispose();
                        context
                            .push<String>('/product_categories_screen')
                            .then((value) {
                          // setState(() {
                          selectedNodeUrl = value;
                          log("Selected node url is $selectedNodeUrl");
                          // });
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 2.0, color: const Color(0xFFFFFFFF)),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.chair_rounded,
                                size: 24.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          8.vGap,
                          Text(
                            "Add",
                            style: context.theme.textTheme.bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    // ElevatedButton(
                    //     onPressed: onRemoveEverything,
                    //     child: Text("Remove Everything")),
                    // ElevatedButton(
                    //     onPressed: onTakeScreenshot,
                    //     child: const Text("Take Screenshot")),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          // customPlaneTexturePath: "assets/triangle.png",
          showWorldOrigin: false,
          handlePans: true,
          handleRotation: true,
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager!.onNodeTap = onNodeTapped;
    this.arObjectManager!.onPanStart = onPanStarted;
    this.arObjectManager!.onPanChange = onPanChanged;
    this.arObjectManager!.onPanEnd = onPanEnded;
    this.arObjectManager!.onRotationStart = onRotationStarted;
    this.arObjectManager!.onRotationChange = onRotationChanged;
    this.arObjectManager!.onRotationEnd = onRotationEnded;
  }

  Future<void> onRemoveEverything() async {
    /*nodes.forEach((node) {
      this.arObjectManager.removeNode(node);
    });*/
    anchors.forEach((anchor) {
      this.arAnchorManager!.removeAnchor(anchor);
    });
    anchors = [];
  }

  Future<void> onTakeScreenshot() async {
    var image = await arSessionManager!.snapshot();
    // ignore: use_build_context_synchronously
    await showDialog(
        context: context,
        builder: (_) => Dialog(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: image, fit: BoxFit.cover)),
              ),
            ));
  }

  Future<void> onNodeTapped(List<String> nodes) async {
    var number = nodes.length;
    arSessionManager!.onError("Tapped $number node(s)");
  }

  Future<void> onPlaneOrPointTapped(
    List<ARHitTestResult> hitTestResults,
  ) async {
    if (selectedNodeUrl == null) {
      arSessionManager!.onError("No node selected");
      log("No image model has been selected");
      Fluttertoast.showToast(
        msg: "No image model has been selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: context.theme.colorScheme.secondary,
        textColor: context.theme.colorScheme.onSecondary,
        fontSize: 16.0,
      );
      // _requestAppDocumentsDirectory();
      return;
    }
    log("\n[[[[[[[[ Selected image is $selectedNodeUrl\n\n ]]]]]]]]");
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    var newAnchor =
        ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
    bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);
    if (didAddAnchor!) {
      "adding anchor".log();
      anchors.add(newAnchor);
      // Add note to anchor
      var newNode = ARNode(
        type: NodeType.webGLB,
        uri: selectedNodeUrl!,
        // "https://firebasestorage.googleapis.com/v0/b/decor-ride.appspot.com/o/vintage_wooden_chair_lowpoly.glb?alt=media&token=e69acf11-cf08-47b6-8973-df49e0722a10",
        // "https://firebasestorage.googleapis.com/v0/b/decor-ride.appspot.com/o/modchair2.glb?alt=media&token=292f7c7c-d3e6-415d-9a6f-f30fcdb29f00",
        // "https://firebasestorage.googleapis.com/v0/b/decor-ride.appspot.com/o/mod_couch.glb?alt=media&token=22940e7f-ad3f-4e09-8e9e-52129d9117f2",
        scale: math64.Vector3(1.0, 1.0, 1.0),
        position: math64.Vector3(0.0, 0.0, 0.0),
        rotation: math64.Vector4(1.0, 0.0, 0.0, 0.0),
      );
      "about to add node to anchor".log();
      bool? didAddNodeToAnchor = await arObjectManager!.addNode(
        newNode,
        planeAnchor: newAnchor,
      );
      if (didAddNodeToAnchor!) {
        "added new node".log();
        nodes.add(newNode);
        selectedNodeUrl = null;
      } else {
        arSessionManager!.onError("Adding Node to Anchor failed");
      }
    } else {
      arSessionManager!.onError("Adding Anchor failed");
    }
  }

  onPanStarted(String nodeName) {
    print("Started panning node " + nodeName);
  }

  onPanChanged(String nodeName) {
    print("Continued panning node " + nodeName);
  }

  onPanEnded(String nodeName, Matrix4 newTransform) {
    print("Ended panning node " + nodeName);
    // ignore: unused_local_variable
    final pannedNode =
        this.nodes.firstWhere((element) => element.name == nodeName);

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //pannedNode.transform = newTransform;
  }

  onRotationStarted(String nodeName) {
    print("Started rotating node " + nodeName);
  }

  onRotationChanged(String nodeName) {
    print("Continued rotating node " + nodeName);
  }

  onRotationEnded(String nodeName, Matrix4 newTransform) {
    print("Ended rotating node " + nodeName);
    // ignore: unused_local_variable
    final rotatedNode =
        this.nodes.firstWhere((element) => element.name == nodeName);

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //rotatedNode.transform = newTransform;
  }
}
