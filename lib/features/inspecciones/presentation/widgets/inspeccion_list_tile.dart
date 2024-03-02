import 'package:eos_mobile/shared/shared.dart';

class InspeccionListTile extends StatelessWidget {
  const InspeccionListTile({
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.subtitle3,
    required this.thumbnail,
    required this.publishedDate,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final String subtitle3;
  final String publishedDate;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular($styles.corners.sm),
          border: Border.all(
            color: Theme.of(context).highlightColor,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all($styles.insets.xs),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(aspectRatio: 1, child: thumbnail),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 2, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.labelLarge!.color,
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Requerimiento: ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: subtitle1,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .color,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .fontSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'No. económico: ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: subtitle2,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .color,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .fontSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Tipo de unidad: ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: subtitle3,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .color,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .fontSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Fecha: ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: publishedDate,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .color,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .fontSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
