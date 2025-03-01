import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FittedScale extends SingleChildRenderObjectWidget {
  FittedScale({super.key, this.scale, this.scaleX, this.scaleY, super.child})
      : assert(!(scale == null && scaleX == null && scaleY == null),
            "At least one of 'scale', 'scaleX' and 'scaleY' is required to be non-null"),
        assert(scale == null || (scaleX == null && scaleY == null),
            "If 'scale' is non-null then 'scaleX' and 'scaleY' must be left null"),
        transform = Matrix4.diagonal3Values(
            scale ?? scaleX ?? 1.0, scale ?? scaleY ?? 1.0, 1.0);

  final double? scale;
  final double? scaleX;
  final double? scaleY;

  final Matrix4 transform;

  @override
  RenderScaledBox createRenderObject(BuildContext context) =>
      RenderScaledBox(transform: transform);

  @override
  void updateRenderObject(BuildContext context, RenderScaledBox renderObject) {
    renderObject.transform = transform;
  }
}

class RenderScaledBox extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  RenderScaledBox({
    required Matrix4 transform,
    RenderBox? child,
  }) : _paintTransform = transform {
    this.child = child;
  }

  Matrix4 _paintTransform;
  Matrix4 get transform => _paintTransform;
  set transform(Matrix4 value) {
    if (_paintTransform == value) {
      return;
    }
    _paintTransform = value;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (child == null) {
      return 0.0;
    }
    return child!.computeMinIntrinsicWidth(height) * transform[0].abs();
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child == null) {
      return 0.0;
    }
    return child!.computeMaxIntrinsicWidth(height) * transform[0].abs();
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child == null) {
      return 0.0;
    }
    return child!.computeMinIntrinsicHeight(width) * transform[5].abs();
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child == null) {
      return 0.0;
    }
    return child!.computeMaxIntrinsicHeight(width) * transform[5].abs();
  }

  @override
  @protected
  Size computeDryLayout(covariant BoxConstraints constraints) {
    if (child == null) {
      return constraints.smallest;
    }
    Size t = child!.getDryLayout(constraints);
    return Size(t.width * transform[0].abs(), t.height * transform[5].abs());
  }

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = Size(child!.size.width * transform[0].abs(),
          child!.size.height * transform[5].abs());
    } else {
      size = constraints.smallest;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    if (child == null) {
      return false;
    }
    return result.addWithPaintTransform(
      transform: _paintTransform,
      position: position,
      hitTest: (BoxHitTestResult result, Offset position) {
        return child!.hitTest(result, position: position);
      },
    );
  }

  void _paintChild(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      _transformLayer.layer = context.pushTransform(
        needsCompositing,
        offset,
        _paintTransform,
        _paintChild,
        oldLayer: _transformLayer.layer,
      );
    } else {
      _transformLayer.layer = null;
    }
  }

  final LayerHandle<TransformLayer> _transformLayer =
      LayerHandle<TransformLayer>();

  @override
  void dispose() {
    _transformLayer.layer = null;
    super.dispose();
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.multiply(_paintTransform);
    super.applyPaintTransform(child, transform);
  }
}
