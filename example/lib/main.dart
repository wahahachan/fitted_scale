import 'package:flutter/material.dart';
import 'package:fitted_scale/fitted_scale.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Scale down
            Text('FittedScale (0.6x Flutter logo):',
                textScaler: TextScaler.linear(1.2)),
            Row(children: [
              Container(
                color: Colors.amber,
                child: FittedScale(
                    scale: 0.6,
                    child: FlutterLogo(
                      size: 110,
                    )),
              ),
              Container(
                color: Colors.green,
                child: FlutterLogo(
                  size: 110,
                ),
              ),
            ]),
            Text('Transform.scale (0.6x Flutter logo):',
                textScaler: TextScaler.linear(1.2)),
            Row(children: [
              Container(
                color: Colors.amber,
                child: Transform.scale(
                    scale: 0.7,
                    child: FlutterLogo(
                      size: 110,
                    )),
              ),
              Container(
                color: Colors.green,
                child: FlutterLogo(
                  size: 110,
                ),
              ),
            ]),
            Divider(),
            SizedBox(height: 10),
            // Scale 2X icon button
            Text('FittedScale (2x Icon button):',
                textScaler: TextScaler.linear(1.2)),
            Row(children: [
              FittedScale(
                  scale: 2,
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.read_more))),
              Container(
                color: Colors.green,
                child: FlutterLogo(
                  size: 110,
                ),
              ),
            ]),
            Text('Transform.scale (2x Icon button):',
                textScaler: TextScaler.linear(1.2)),
            Row(children: [
              Transform.scale(
                  scale: 2,
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.read_more))),
              Container(
                color: Colors.green,
                child: FlutterLogo(
                  size: 110,
                ),
              ),
            ]),
            Divider(),
            SizedBox(height: 10),
            // Scale 2X icon button
            Text('FittedScale (Scale X & Scale Y independently):',
                textScaler: TextScaler.linear(1.2)),
            Row(children: [
              Container(
                color: Colors.amber,
                child: FittedScale(
                    scaleX: 2.4,
                    child: FlutterLogo(
                      size: 110,
                    )),
              ),
              Container(
                  color: Colors.green,
                  child: FittedScale(
                    scaleY: 0.75,
                    child: FlutterLogo(
                      size: 110,
                    ),
                  )),
            ]),
            Text('Transform.scale (Scale X & Scale Y independently):',
                textScaler: TextScaler.linear(1.2)),
            Row(children: [
              Container(
                color: Colors.amber,
                child: Transform.scale(
                    scaleX: 2.4,
                    child: FlutterLogo(
                      size: 110,
                    )),
              ),
              Container(
                  color: Colors.green,
                  child: Transform.scale(
                    scaleY: 0.75,
                    child: FlutterLogo(
                      size: 110,
                    ),
                  )),
            ]),
          ],
        )),
      ),
    );
  }
}
