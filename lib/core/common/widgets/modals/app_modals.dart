import 'package:eos_mobile/shared/shared.dart';

class LoadingModal extends StatefulWidget {
  const LoadingModal({super.key});

  @override
  State<LoadingModal> createState() => _LoadingModalState();
}

class _LoadingModalState extends State<LoadingModal> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _BaseContentModal extends StatelessWidget {
  const _BaseContentModal({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight();
  }
}
