Fitted scale is a widget that scales its child prior to layout. Unlike `Transform.scale()`, which applies a transform just prior to painting, this widget applies its scaling prior to layout, which means the entire rendered box consumes only as much space as required by the scaled child. You may think of this as the scaling version of `RotatedBox`.

![simple demo](https://github.com/wahahachan/fitted_scale/blob/master/example/img/scale1.png?raw=true)

## Usage

Scale your widget in a similar way as `Transform.scale()`

Apply a uniform scaling:

```dart
FittedScale(
  scale: 0.6,
  child: FlutterLogo( size: 110 )
),
```

Specify horizontal and/or vertical scaling independently:

```dart
FittedScale(
  scaleX: 0.6,
  scaleY: 1.3,
  child: FlutterLogo( size: 110 )
),
```

## More examples

This is an example of scaling up an material `IconButton`. The finally layout is more desirable compared to adopting `Transform.scale()`.

```dart
Row(children: [
  FittedScale(
    scale: 2.0,
    child: IconButton( onPressed: () {}, icon: Icon(Icons.read_more))),
  Container(
    color: Colors.green,
    child: FlutterLogo( size: 110 ),
  ),
])
```

![simple demo](https://github.com/wahahachan/fitted_scale/blob/master/example/img/scale2.png?raw=true)

Performing scaling prior to layout can sometimes avoid unwanted clipping.

```dart
Row(children: [
  Container(
    color: Colors.amber,
    child: FittedScale(
        scaleX: 2.4,
        child: FlutterLogo( size: 110 )),
  ),
  Container(
    color: Colors.green,
    child: FittedScale(
      scaleY: 0.75,
      child: FlutterLogo( size: 110 )),
  ),
]),
```

![simple demo](https://github.com/wahahachan/fitted_scale/blob/master/example/img/scale3.png?raw=true)

Notice that if the above is implemented with `Transform.scale()`, two sides of the Flutter logo(yellow background) will be trimmed.
