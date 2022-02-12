import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_revision/common/app_colors.dart';
import 'package:store_revision/common/app_resources.dart';

class DialogWrapperWidget extends StatelessWidget {
  final Widget child;

  const DialogWrapperWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: FutureBuilder<List<DrawableRoot>?>(
        future: _loadSvgs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return CustomPaint(
              painter: _DialogPainter(svgs: snapshot.data!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 17, top: 19),
                    child: GestureDetector(
                        child: Container(
                          color: AppColors.white,
                          width: 15,
                          child: SvgPicture.asset(AppResources.exitSignIcon),
                        ),
                        onTap: () => Navigator.pop(context)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 102.8,
                      right: 8,
                      bottom: 103.8,
                      left: 8,
                    ),
                    child: child,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Future<List<DrawableRoot>> _loadSvgs() async {
    return [
      await svg.fromSvgString(
          await rootBundle.loadString(AppResources.dialogFrame), 'SVG_DEBUG'),
      await svg.fromSvgString(
          await rootBundle.loadString(AppResources.dialogTop), 'SVG_DEBUG'),
      await svg.fromSvgString(
          await rootBundle.loadString(AppResources.dialogBottom), 'SVG_DEBUG'),
    ];
  }
}

class _DialogPainter extends CustomPainter {
  List<DrawableRoot>? svgs;
  _DialogPainter({this.svgs});

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final paint = Paint()
      ..color = AppColors.dialogBackgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const offset = 4.0;
    final frameBounds = Rect.fromPoints(const Offset(offset, offset),
        Offset(size.width - offset, size.height - offset));
    final frame = RRect.fromRectAndRadius(
      frameBounds,
      const Radius.circular(10.5),
    );
    canvas.drawRRect(frame, paint);

    // draw top part
    Size desiredSize = Size(size.width - offset * 4, 94.8);

    canvas.save();
    canvas.translate(offset * 2, offset * 2);
    Size svgSize = svgs![1].viewport.size;
    var matrix = Matrix4.identity();
    matrix.scale(
        desiredSize.width / svgSize.width, desiredSize.height / svgSize.height);
    canvas.transform(matrix.storage);
    svgs?[1].draw(canvas,
        Rect.zero); // the second argument is not used in DrawableRoot.draw() method
    canvas.restore();

    // draw bottom part
    desiredSize = Size(size.width - offset * 4, 95.8);
    canvas.save();
    canvas.translate(offset * 2, size.height - offset * 2 - desiredSize.height);
    svgSize = svgs![2].viewport.size;
    matrix = Matrix4.identity();
    matrix.scale(
        desiredSize.width / svgSize.width, desiredSize.height / svgSize.height);
    canvas.transform(matrix.storage);
    svgs?[2].draw(canvas,
        Rect.zero); // the second argument is not used in DrawableRoot.draw() method
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
