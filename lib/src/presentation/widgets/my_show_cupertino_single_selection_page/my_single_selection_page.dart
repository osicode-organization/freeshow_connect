import 'package:cupertino_lists_enhanced/app_type.dart';
import 'package:cupertino_lists_enhanced/list_section.dart';
import 'package:cupertino_lists_enhanced/selection_item.dart';
import 'package:cupertino_lists_enhanced/widget_location.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:freeshow_connect/src/presentation/widgets/my_show_cupertino_single_selection_page/my_cupertino_selection_tile.dart';

class MySingleSelectionPage<T> extends StatefulWidget {
  /// Widget to be displayed on the [AppBar]/[CupertinoNavigationBar] of the scaffold.
  final Widget title;

  /// Displayed above the options. Usually a [Text] widget.
  final Widget? header;

  /// Displayed below the options. Usually a [Text] widget.
  final Widget? footer;

  /// The type of the header. If "insetGrouped", the header will be displayed
  /// large and bold like the iOS notes app. If "base", the header will be displayed
  /// smaller, like the iOS settings app.
  final CupertinoListSectionType? headerType;

  /// The type of the footer. If "insetGrouped", no styling will be applied.
  /// If "base", the footer will be displayed in the style of the iOS settings app.
  final CupertinoListSectionType? footerType;

  /// Options from which the user can choose.
  final List<SelectionItem<T>> children;

  /// Initial value to be selected upon opening the page.
  final T? initial;

  /// Determines whether the check mark will be located on the leading (left) or trailing (right) side of the tile.
  final WidgetSelectionLocation checkMarkLocation;

  /// Optional checkMark color
  final Color? checkMarkColor;

  /// Called when a user presses any of the options.
  final ValueChanged<T?>? onChanged;

  /// Optional background color
  final Color? backgroundColor;

  /// Optional separator color
  final Color? separatorColor;

  final IconData? selectedTrailingIcon;

  /// If [scaffoldType] is material, a material scaffold is used. If [scaffoldType] is cupertino, a cupertino scaffold is used.
  final AppType scaffoldType;
  const MySingleSelectionPage({
    required this.title,
    required this.children,
    this.initial,
    this.onChanged,
    this.scaffoldType = AppType.cupertino,
    this.header,
    this.footer,
    this.headerType,
    this.footerType,
    this.backgroundColor,
    this.separatorColor,
    this.checkMarkLocation = WidgetSelectionLocation.trailing,
    this.checkMarkColor,
    this.selectedTrailingIcon,
    super.key,
  });

  @override
  State<MySingleSelectionPage<T>> createState() =>
      _MySingleSelectionPageState<T>();
}

class _MySingleSelectionPageState<T> extends State<MySingleSelectionPage<T>> {
  T? _selected;

  @override
  void initState() {
    _selected = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: widget.title,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: EnhancedCupertinoListSection.insetGrouped(
            header: widget.header,
            footer: widget.footer,
            hasLeading: false,
            headerType: widget.headerType ?? CupertinoListSectionType.base,
            footerType: widget.footerType ?? CupertinoListSectionType.base,
            backgroundColor:
                widget.backgroundColor ??
                CupertinoColors.systemGroupedBackground,
            separatorColor: widget.separatorColor,
            children:
                widget.children
                    .map(
                      (item) => MyCupertinoSelectionTile<T>(
                        title: item.title,
                        subtitle: item.subtitle,
                        value: item.value,
                        isSelected: item.value == _selected,
                        checkMarkLocation: widget.checkMarkLocation,
                        checkMarkColor: widget.checkMarkColor,
                        enabled: item.enabled,
                        selectedTrailingIcon: widget.selectedTrailingIcon,
                        onTapp: (item) {
                          // if (onChanged2 != null) {
                          //   onChanged2!(item);
                          // }

                          setState(() {
                            _selected = item;
                          });
                          if (widget.onChanged != null) {
                            widget.onChanged!(_selected);
                          }
                        },
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }

  ValueChanged<T?>? onChanged2(newValue) {
    setState(() {
      _selected = newValue;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_selected);
    }
  }
}
