// Copyright 2020-2022 TechAurelian. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data/info_bit.dart';

/// A widget that displays an [InfoBit].
///
/// The widget displays the text of the info bit with the actual value in bold.
class InfoBitView extends StatelessWidget {
  /// Creates a widget that displays an [InfoBit].
  const InfoBitView({
    Key? key,
    required this.infoBit,
    this.isListView = false,
  }) : super(key: key);

  /// The info bit to display.
  final InfoBit infoBit;

  /// Whether this widget is being displayed in a list view.
  final bool isListView;

  @override
  Widget build(BuildContext context) {
    final TextAlign textAlign = isListView ? TextAlign.left : TextAlign.center;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Display the info bit's title.
          Text(
            infoBit.title,
            style: Theme.of(context).textTheme.caption,
            textAlign: textAlign,
          ),
          const SizedBox(height: 4.0),

          // Display the info bit's text and value.
          RichText(
            textAlign: textAlign,
            text: TextSpan(
              children: _getInfoBitRichText(),
              style: isListView
                  ? Theme.of(context).textTheme.headline6
                  : Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the info bit's text and value as a list of [InlineSpan]s, with the value in bold.
  ///
  /// Acknowledgement: This method was inspired by the build() method of the [ParsedText] widget in
  /// the [parsed_text](https://pub.dev/packages/flutter_parsed_text) package.
  List<InlineSpan> _getInfoBitRichText() {
    List<InlineSpan> widgets = [];

    infoBit.text.splitMapJoin(
      InfoBit.infoPlaceholder,
      onMatch: (Match match) {
        if (infoBit.value != null) {
          widgets.add(
            TextSpan(
              text: infoBit.value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }
        return '';
      },
      onNonMatch: (String text) {
        widgets.add(TextSpan(text: text));
        return '';
      },
    );

    return widgets;
  }
}
