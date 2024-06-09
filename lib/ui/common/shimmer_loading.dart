import 'package:eos_mobile/shared/shared_libraries.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      margin: EdgeInsets.only(bottom: $styles.insets.lg),
      child: Container(
        padding: EdgeInsets.all($styles.insets.xs),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 235,
              child: Shimmer.fromColors(
                baseColor       : Colors.grey.shade300,
                highlightColor  : Colors.grey.shade200,
                child: Container(
                  width       : 60,
                  height      : 60,
                  decoration  : BoxDecoration(
                    borderRadius  : BorderRadius.circular($styles.corners.md),
                    color         : Colors.white,
                  ),
                ),
              ),
            ),
            Gap($styles.insets.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                        child: Container(
                          height      : 20,
                          width       : 100,
                          decoration  : BoxDecoration(
                            borderRadius  : BorderRadius.circular($styles.corners.md),
                            color         : Colors.white,
                          ),
                        ),
                      ),
                      Gap($styles.insets.xs),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                        child: Container(
                          height      : 20,
                          width       : 160,
                          decoration  : BoxDecoration(
                            borderRadius  : BorderRadius.circular($styles.corners.md),
                            color         : Colors.white,
                          ),
                        ),
                      ),
                      Gap($styles.insets.xs),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                        child: Container(
                          height      : 20,
                          width       : 100,
                          decoration  : BoxDecoration(
                            borderRadius  : BorderRadius.circular($styles.corners.md),
                            color         : Colors.white,
                          ),
                        ),
                      ),
                      Gap($styles.insets.xs),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                        child: Container(
                          height      : 20,
                          width       : 160,
                          decoration  : BoxDecoration(
                            borderRadius  : BorderRadius.circular($styles.corners.md),
                            color         : Colors.white,
                          ),
                        ),
                      ),
                      Gap($styles.insets.xs),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                        child: Container(
                          height      : 20,
                          width       : 100,
                          decoration  : BoxDecoration(
                            borderRadius  : BorderRadius.circular($styles.corners.md),
                            color         : Colors.white,
                          ),
                        ),
                      ),
                      Gap($styles.insets.xs),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                        child: Container(
                          height      : 20,
                          width       : 160,
                          decoration  : BoxDecoration(
                            borderRadius  : BorderRadius.circular($styles.corners.md),
                            color         : Colors.white,
                          ),
                        ),
                      ),
                      Gap($styles.insets.xs),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                        child: Container(
                          height      : 20,
                          width       : 100,
                          decoration  : BoxDecoration(
                            borderRadius  : BorderRadius.circular($styles.corners.md),
                            color         : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
