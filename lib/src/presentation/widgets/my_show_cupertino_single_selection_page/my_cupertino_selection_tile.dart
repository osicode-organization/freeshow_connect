import 'package:cupertino_lists_enhanced/list_tile.dart';
import 'package:cupertino_lists_enhanced/widget_location.dart';
import 'package:flutter/cupertino.dart';

/// [MyCupertinoSelectionTile] is used by [CupertinoMultiSelection] and
/// [CupertinoSingleSelection] to display an option.
class MyCupertinoSelectionTile<T> extends StatelessWidget {
  /// The most important content of this tile. Typically a [Text] widget.
  final Widget title;

  /// Optional, additional information. Typically a [Text] widget.
  final Widget? subtitle;

  /// The value provided through the onTap callback when this tile is tapped.
  final T? value;

  /// If true, a check mark will be provided next to this option.
  final bool isSelected;

  /// Determines if this option can be selected or deselected by the user.
  /// If false, the tile will be greyed out and not selectable by the user.
  final bool enabled;

  /// Called when a user taps this tile.
  final void Function(T? value)? onTap;

  /// Optional checkMark color
  final Color? checkMarkColor;

  /// Determines whether the check mark will be located on the leading (left) or trailing (right) side of the tile.
  final WidgetSelectionLocation checkMarkLocation;
  final IconData? selectedTrailingIcon;

  const MyCupertinoSelectionTile({
    required this.title,
    required this.isSelected,
    required this.checkMarkLocation,
    this.subtitle,
    this.value,
    this.onTap,
    this.checkMarkColor,
    required this.enabled,
    super.key,
    this.selectedTrailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return EnhancedCupertinoListTile(
      titleBuilder:
          (context) => _TitleTextStyle(enabled: enabled, child: title),
      subtitleBuilder:
          subtitle != null
              ? (context) => _TitleTextStyle(enabled: enabled, child: subtitle!)
              : null,
      trailing:
          checkMarkLocation == WidgetSelectionLocation.trailing ? _icon : null,
      leading:
          checkMarkLocation == WidgetSelectionLocation.leading ? _icon : null,
      onTap: () {
        if (onTap != null && enabled) {
          onTap!(value);
        }
      },
    );
  }

  Widget get _icon =>
      isSelected
          ? Icon(
            selectedTrailingIcon ?? CupertinoIcons.check_mark,
            color: checkMarkColor ?? CupertinoColors.systemBlue,
          )
          : const SizedBox.shrink();
}

class _TitleTextStyle extends StatelessWidget {
  final Widget child;
  final bool enabled;

  const _TitleTextStyle({
    required this.child,
    required this.enabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) => DefaultTextStyle(
    style: DefaultTextStyle.of(context).style.merge(
      TextStyle(color: !enabled ? CupertinoColors.inactiveGray : null),
    ),
    child: child,
  );
}
