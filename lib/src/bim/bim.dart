
import 'package:brick_bootstrap5_plus/brick_bootstrap5_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bim_app.dart';
import 'bim_web.dart';

class BIM extends StatefulWidget {
  const BIM({super.key});

  @override
  State<BIM> createState() => BIMState();
}

class BIMState extends State<BIM> {
  GlobalKey<BimWebState> webMapKey = GlobalKey<BimWebState>();
  GlobalKey<BimAppState> appMapKey = GlobalKey<BimAppState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  postMessage(dynamic data) {
    GetPlatform.isWeb
        ? webMapKey.currentState?.postMessage(data)
        : appMapKey.currentState?.postMessage(data);
  }

  @override
  Widget build(BuildContext context) {
    return BRow(children: [
      BCol(
        classNames: 'col-24',
        child: BRow(children: [
          BCol(
            classNames: 'col-6 p-5',
            child: ElevatedButton(
              onPressed: () {
                postMessage({'src': './bike.glb'});
              },
              child: Text('bike.glb'),
            ),
          ),
          BCol(
            classNames: 'col-6 p-5',
            child: ElevatedButton(
              onPressed: () {
                postMessage({'src': './modelNew.gltf'});
              },
              child: Text('modelNew.gltf'),
            ),
          ),
          BCol(
            classNames: 'col-6 p-5',
            child: ElevatedButton(
              onPressed: () {
                postMessage({'src': './build.glb'});
              },
              child: Text('build.glb'),
            ),
          ),
          BCol(
            classNames: 'col-6 p-5',
            child: ElevatedButton(
              onPressed: () {
                postMessage({'src': './Dragon.glb'});
              },
              child: Text('Dragon.glb'),
            ),
          ),
          BCol(
            classNames: 'col-6 p-5',
            child: ElevatedButton(
              onPressed: () {
                postMessage({'src': './pioche.glb'});
              },
              child: Text('pioche.glb'),
            ),
          ),
          BCol(
            classNames: 'col-6 p-5',
            child: ElevatedButton(
              onPressed: () {
                postMessage({'src': './Notebook.glb'});
              },
              child: Text('Notebook.glb'),
            ),
          ),
          BCol(
            classNames: 'col-6 p-5',
            child: ElevatedButton(
              onPressed: () {
                postMessage({'src': './iphone.glb'});
              },
              child: Text('iphone.glb'),
            ),
          ),
          BCol(
            classNames: 'col-6 p-5',
            child: ElevatedButton(
              onPressed: () {
                postMessage({'src': './Only_Spider.glb'});
              },
              child: Text('Only_Spider.glb'),
            ),
          ),
          BCol(
            classNames: 'col-6 p-5',
            child: ElevatedButton(
              onPressed: () {
                postMessage({'src': './Wolf-Blender-2.82a.glb'});
              },
              child: Text('Wolf-Blender-2.82a.glb'),
            ),
          ),
          BCol(
            classNames: 'col-6 p-5',
            child: ElevatedButton(
              onPressed: () {
                postMessage({'src': './girl.glb'});
              },
              child: Text('girl.glb'),
            ),
          ),
        ]),
      ),
      BCol(
        classNames: 'col-24',
        child:
            GetPlatform.isWeb ? BimWeb(key: webMapKey) : BimApp(key: appMapKey),
      ),
    ]);
    /* SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                GetPlatform.isWeb
                    ? BimWeb(key: webMapKey)
                    : BimApp(key: appMapKey),
                Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: ElevatedButton(
                      onPressed: () {
                        postMessage({'src': './bike.glb'});
                      },
                      child: Text('发送Flutter信息')),
                ),
              ],
            ),
          ),
        ],
      ),
    ); */
  }
}
