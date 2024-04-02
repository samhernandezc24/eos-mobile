import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/core/common/widgets/modals/full_screen_web_view.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDialogContent extends StatelessWidget {
  const AboutDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    /// METHODS
    void handleTap(String url) {
      if (PlatformInfo.isDesktopOrWeb) {
        launchUrl(Uri.parse(url));
      } else {
        Navigator.push(context, CupertinoPageRoute<void>(builder: (_) => FullScreenWebView(url)));
      }
    }

    List<TextSpan> buildSpan(String text, {Map<String, List<String>>? linkSupplants}) {
      if (linkSupplants?.isNotEmpty ?? false) {
        final RegExp r = RegExp(r'\{\w+\}');
        final matches = r.allMatches(text);
        final List<String> a = text.split(r);

        final supplantKeys = matches.map((x) => x.group(0));
        final sortedEntries = supplantKeys.map((x) => linkSupplants?.entries.firstWhere((element) => element.key == x));

        final List<TextSpan> lstSpans = <TextSpan>[];
        for (var i = 0; i < a.length; i++) {
          lstSpans.add(TextSpan(text: a[i]));
          if (i < sortedEntries.length) {
            final String label = sortedEntries.elementAt(i)!.value[0];
            final String link = sortedEntries.elementAt(i)!.value[1];
            lstSpans.add(
              TextSpan(
                text: label,
                recognizer: TapGestureRecognizer()..onTap = () => handleTap(link),
                style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
              ),
            );
          }
        }
        return lstSpans;
      } else {
        return [TextSpan(text: text)];
      }
    }

    double fontSize = $styles.textStyles.body.fontSize!;
    fontSize *= MediaQuery.of(context).textScaler.scale(1);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Gap($styles.insets.sm),
          RichText(
            text: TextSpan(
              style: $styles.textStyles.bodySmall.copyWith(color: Colors.black, fontSize: fontSize),
              children: <InlineSpan>[
                ...buildSpan(
                  $strings.homeMenuAboutApp,
                  linkSupplants: {
                    '{heavyLiftUrl}' : ['Heavy-Lift Rigging Services & Consulting Mexico', 'https://heavy-lift.com.mx'],
                  },
                ),
                ...buildSpan($strings.homeMenuAboutBuilt, linkSupplants: {'{flutterUrl}' : ['Flutter', 'https://flutter.dev/']}),
                ...buildSpan('\n\n'),
                ...buildSpan($strings.homeMenuAboutProcess),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
