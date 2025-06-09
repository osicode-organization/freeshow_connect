import 'package:cupertino_lists_enhanced/app_type.dart';
import 'package:cupertino_lists_enhanced/selection_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_single_selection_page.dart';

Future<T?> myShowCupertinoSingleSelectionPage<T>({
  required BuildContext context,
  required Widget title,
  required List<SelectionItem<T>> children,
  T? initial,
  IconData? selectedTrailingIcon,
  ValueChanged<T?>? onChanged,
  bool useRootNavigator = true,
  Widget? header,
  Widget? footer,
  CupertinoListSectionType? headerType,
  CupertinoListSectionType? footerType,
  AppType routeType = AppType.cupertino,
  AppType scaffoldType = AppType.cupertino,
}) => Navigator.of(context, rootNavigator: useRootNavigator).push<T>(
  _getRoute<T>(
    appType: routeType,
    builder:
        (BuildContext context) => MySingleSelectionPage<T>(
          header: header,
          footer: footer,
          headerType: headerType,
          footerType: footerType,
          title: title,
          children: children,
          initial: initial,
          selectedTrailingIcon: selectedTrailingIcon,
          onChanged: onChanged,
        ),
  ),
);
PageRoute<T> _getRoute<T>({
  required AppType appType,
  required WidgetBuilder builder,
}) {
  switch (appType) {
    case AppType.material:
      return MaterialPageRoute(builder: builder);
    case AppType.cupertino:
      return CupertinoPageRoute(builder: builder);
  }
}
