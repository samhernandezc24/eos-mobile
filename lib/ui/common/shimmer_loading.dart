import 'package:eos_mobile/shared/shared_libraries.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 20.0,
            color: Colors.grey[300],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 20.0,
            color: Colors.grey[300],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 20.0,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
