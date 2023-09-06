import 'dart:developer';

import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/features/ar_and_products/presentation/providers/product_actions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_math/vector_math_64.dart' as math64;
import 'package:badges/badges.dart' as badges;

final nodeIsSelectedProvider = StateProvider<bool>((ref) => false);

class ARMainView extends ConsumerStatefulWidget {
  const ARMainView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ARMainViewState();
}

class _ARMainViewState extends ConsumerState<ARMainView> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  String? selectedNodeUrl;
  String? selectedProductId;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('AR Main View'),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            ARView(
              onARViewCreated: onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            ),
            Positioned(
              top: 12.0,
              right: 12.0,
              child: badges.Badge(
                badgeContent: ref.watch(getCartCountProvider).maybeWhen(
                      orElse: () => Text(
                        '0',
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                      data: (count) => Text(
                        '$count',
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: context.theme.colorScheme.primary,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12.0,
              left: 12.0,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.close,
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
            Positioned(
              // alignment: FractionalOffset.bottomCenter,
              bottom: 8.0,
              right: 32.0,
              left: 32.0,
              child: ref.watch(nodeIsSelectedProvider) == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            ref
                                .read(productActionsNotifierProvider.notifier)
                                .addProductToCart(
                                    productId: selectedProductId!);
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                width: 45.0,
                                height: 45.0,
                                child: Center(
                                  child: ref
                                      .watch(productActionsNotifierProvider)
                                      .maybeWhen(
                                        orElse: () => const Icon(
                                          Icons.add_shopping_cart_rounded,
                                          size: 24.0,
                                          color: Colors.white,
                                        ),
                                        addingToCart: () => const SizedBox(
                                          height: 20.0,
                                          width: 20.0,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                ),
                              ),
                              8.vGap,
                              Text(
                                "Add to Cart",
                                style: context.theme.textTheme.bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                width: 45.0,
                                height: 45.0,
                                child: const Center(
                                  child: Icon(
                                    Icons.info,
                                    size: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              8.vGap,
                              Text(
                                "Info",
                                style: context.theme.textTheme.bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                width: 45.0,
                                height: 45.0,
                                child: const Center(
                                  child: Icon(
                                    Icons.control_point_duplicate,
                                    size: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              8.vGap,
                              Text(
                                "Duplicate",
                                style: context.theme.textTheme.bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                width: 45.0,
                                height: 45.0,
                                child: const Center(
                                  child: Icon(
                                    Icons.delete_outline,
                                    size: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              8.vGap,
                              Text(
                                "Delete",
                                style: context.theme.textTheme.bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                width: 45.0,
                                height: 45.0,
                                child: const Center(
                                  child: Icon(
                                    Icons.move_down_rounded,
                                    size: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              8.vGap,
                              Text(
                                "Reposition",
                                style: context.theme.textTheme.bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
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
                                      width: 2.0,
                                      color: const Color(0xFFFFFFFF)),
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
                            await context
                                .push<Map<String, dynamic>>(
                                    '/product_categories_screen')
                                .then((value) {
                              selectedNodeUrl = value!['modelUrl'];
                              selectedProductId = value['productId'];
                              log("Selected node url is $selectedNodeUrl");
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
                                      width: 2.0,
                                      color: const Color(0xFFFFFFFF)),
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
                      ],
                    ),
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
    ref.read(nodeIsSelectedProvider.notifier).update((state) => false);
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
    int number = nodes.length;
    // "length of nodes is ${nodes.length}".log();
    // "nodes is ${nodes.toString()}".log();
    // "nodes first data is ${this.nodes.first.data} and node name is ${this.nodes.first.name} "
    //     .log();
    // "nodes last data is ${this.nodes.last.data} and node name is and node name is ${this.nodes.last.name} \n "
    //     .log();
    ARNode? selectedNode = this.nodes.firstWhere(
          (element) => element.name == nodes.first,
          orElse: () => ARNode(type: NodeType.webGLB, uri: ""),
        );
    selectedProductId = selectedNode.data!['nodeId'];
    "\n data additional data for the selected node is ${selectedNode.data} \n"
        .log();
    if (number > 0 && ref.watch(nodeIsSelectedProvider) == false) {
      ref.read(nodeIsSelectedProvider.notifier).update((state) => true);
    } else if (number > 0 && ref.watch(nodeIsSelectedProvider) == true) {
      setState(() {
        number = 0;
      });
      ref.read(nodeIsSelectedProvider.notifier).update((state) => false);
    }
  }

  Future<void> onPlaneOrPointTapped(
    List<ARHitTestResult> hitTestResults,
  ) async {
    if (selectedNodeUrl == null) {
      arSessionManager!.onError("No node selected");
      log("No image model has been selected");
      ref.read(nodeIsSelectedProvider.notifier).update((state) => false);
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
        scale: math64.Vector3(1.0, 1.0, 1.0),
        position: math64.Vector3(0.0, 0.0, 0.0),
        rotation: math64.Vector4(1.0, 0.0, 0.0, 0.0),
        data: {
          'nodeId': selectedProductId,
        },
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
