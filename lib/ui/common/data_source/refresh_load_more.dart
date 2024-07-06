import 'package:eos_mobile/shared/shared_libs.dart';

class RefreshLoadMore extends StatefulWidget {
  const RefreshLoadMore({
    required this.child,
    required this.isLastPage,
    Key? key,
    this.onRefresh,
    this.onLoadMore,
    this.noMoreWidget,
    this.scrollController,
  }) : super(key: key);

  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;
  final bool isLastPage;
  final Widget child;
  final Widget? noMoreWidget;
  final ScrollController? scrollController;

  @override
  State<RefreshLoadMore> createState() => _RefreshLoadMoreState();
}

class _RefreshLoadMoreState extends State<RefreshLoadMore> {
  // GLOBAL KEY
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  // CONTROLLER
  late ScrollController? _scrollController;

  // PROPERTIES
  bool _isLoading = false;

  // STATE
  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController!.addListener(() async {
      if (_scrollController!.position.pixels >= _scrollController!.position.maxScrollExtent) {
        if (_isLoading) return;

        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }

        if (!widget.isLastPage && widget.onLoadMore != null) {
          await widget.onLoadMore!();
        }

        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    if (widget.scrollController == null) _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      children: <Widget>[
        widget.child,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all($styles.insets.sm),
              child: _isLoading
                  ? const AppLoadingIndicator()
                  : widget.isLastPage
                      ? widget.noMoreWidget ??
                          Text('No hay más datos', style: $styles.textStyles.body)
                      : const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        if (_isLoading) return;
        await widget.onRefresh!();
      },
      child: content,
    );
  }
}
