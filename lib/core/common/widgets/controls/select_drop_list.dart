import 'package:eos_mobile/core/common/data/dropdown_model.dart';
import 'package:eos_mobile/shared/shared.dart';

class SelectDropList extends StatefulWidget {
  const SelectDropList({
    required this.itemSelected,
    required this.dropListModel,
    required this.showIcon,
    required this.showArrowIcon,
    required this.onOptionSelected,
    super.key,
    this.paddingLeft = 20,
    this.paddingRight = 20,
    this.paddingTop = 20,
    this.paddingBottom = 20,
    this.icon,
    this.arrowIconSize = 20,
    this.textColorTitle,
    this.textSizeTitle = 16,
    this.paddingDropItem,
    this.arrowColor,
    this.textColorItem,
    this.textSizeItem = 14,
    this.showBorder = true,
    this.width,
    this.borderRadius,
    this.height,
    this.heightBottomContainer,
    this.boxShadow,
    this.borderColor,
    this.hintColorTitle,
    this.containerDecoration,
    this.containerPadding,
    this.shadowColor,
    this.suffixIcon,
    this.containerMargin,
    this.borderSize = 1,
    this.dropbBoxborderRadius,
    this.dropboxborderColor,
    this.dropboxColor,
  });

  final OptionItem itemSelected;
  final DropListModel dropListModel;
  final Function(OptionItem optionItem) onOptionSelected;
  final bool showIcon;
  final bool showArrowIcon;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final Widget? icon;
  final double arrowIconSize;
  final Color? arrowColor;
  final Color? textColorTitle;
  final Color? hintColorTitle;
  final double textSizeTitle;
  final Color? textColorItem;
  final double textSizeItem;
  final bool showBorder;
  final Color? borderColor;
  final Color? shadowColor;
  final double borderSize;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? containerPadding;
  final EdgeInsetsGeometry? containerMargin;
  final Decoration? containerDecoration;
  final double? heightBottomContainer;
  final IconData? suffixIcon;
  final EdgeInsetsGeometry? paddingDropItem;
  final Color? dropboxborderColor;
  final Color? dropboxColor;
  final BorderRadiusGeometry? dropbBoxborderRadius;

  @override
  SelectDropListState createState() => SelectDropListState();
}

class SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
  late OptionItem optionItemSelected;
  late AnimationController expandController;
  late Animation<double> animation;
  bool isShow = false;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    optionItemSelected = OptionItem(
      id: widget.itemSelected.id,
      title: widget.itemSelected.title,
    );
    expandController = AnimationController(
      vsync: this,
      duration: $styles.times.fast,
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.linear,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.paddingLeft,
        right: widget.paddingRight,
        top: widget.paddingTop,
        bottom: widget.paddingBottom,
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: widget.height ?? 50,
            width: widget.width ?? MediaQuery.of(context).size.width,
            padding: widget.containerPadding ??
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            // margin: widget.containerMargin ?? const EdgeInsets.only(top: 10),
            decoration: widget.showBorder
                ? widget.containerDecoration ??
                    BoxDecoration(
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(10.0),
                      border: Border.all(
                        color: widget.borderColor ?? Colors.black,
                        width: widget.borderSize,
                      ),
                      // color: Colors.white,
                    )
                : widget.containerDecoration ??
                    BoxDecoration(
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(10.0),
                      // color: Colors.white,
                      boxShadow: widget.boxShadow ??
                          [
                            BoxShadow(
                              blurRadius: 2,
                              color: widget.shadowColor ?? Colors.black26,
                            ),
                          ],
                    ),
            child: Row(
              children: <Widget>[
                Visibility(
                    visible: widget.showIcon,
                    child: widget.icon != null
                        ? widget.icon!
                        : const Icon(
                            Icons.menu,
                            color: Colors.black,
                          )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    isShow = !isShow;
                    _runExpandCheck();
                    setState(() {});
                  },
                  child: Text(
                    optionItemSelected.title,
                    style: TextStyle(
                        color: optionItemSelected.id == '0' ||
                                optionItemSelected.id == null
                            ? widget.hintColorTitle ?? Colors.grey
                            : widget.textColorTitle ?? Colors.black,
                        fontSize: widget.textSizeTitle),
                  ),
                )),
                Visibility(
                  visible: widget.showArrowIcon,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        isShow = !isShow;
                        _runExpandCheck();
                        setState(() {});
                      },
                      child: Icon(
                        isShow
                            ? Icons.arrow_drop_down
                            : widget.suffixIcon ?? Icons.arrow_right,
                        color: widget.arrowColor ?? Colors.black,
                        size: widget.arrowIconSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(5),
          SizeTransition(
            axisAlignment: 1,
            sizeFactor: animation,
            child: Container(
              height: widget.heightBottomContainer ?? 200,
              margin: const EdgeInsets.only(bottom: 20, left: 2, right: 2),
              padding: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                border:
                    Border.all(color: widget.dropboxborderColor ?? Colors.grey),
                borderRadius: widget.dropbBoxborderRadius ??
                    const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                // color: widget.dropboxColor ?? Colors.white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.black26,
                  )
                ],
              ),
              child: Scrollbar(
                thickness: 4,
                thumbVisibility: true,
                interactive: true,
                controller: scrollController,
                scrollbarOrientation: ScrollbarOrientation.right,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: _buildDropListOptions(
                    widget.dropListModel.listOptionItems,
                    context,
                    widget.textColorItem,
                    widget.textSizeItem,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildDropListOptions(
    List<OptionItem> items,
    BuildContext context,
    Color? textColorItem,
    double textSizeItem,
  ) {
    return Column(
      children: items
          .map(
            (item) => _buildSubMenu(
              item,
              context,
              textColorItem,
              textSizeItem,
            ),
          )
          .toList(),
    );
  }

  Widget _buildSubMenu(
    OptionItem item,
    BuildContext context,
    Color? textColorItem,
    double textSizeItem,
  ) {
    return Padding(
      padding: widget.paddingDropItem ??
          const EdgeInsets.only(left: 20, top: 15, bottom: 5),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                item.title,
                style: $styles.textStyles.bodySmall,
                maxLines: 3,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        onTap: () {
          optionItemSelected = item;
          isShow = false;
          expandController.reverse();
          widget.onOptionSelected(item);
        },
      ),
    );
  }
}