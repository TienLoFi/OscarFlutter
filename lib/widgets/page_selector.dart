import 'package:flutter/material.dart';
import 'package:oscar_ballot/commons/utils.dart';

class PageSelector extends StatelessWidget {
  /// Creates a compact widget that indicates which tab has been selected.
  const PageSelector({
    Key? key,
    this.controller,
    this.indicatorSize = 12.0,
    this.color,
    this.borderColor,
    this.selectedColor,
  })  : assert(indicatorSize > 0.0),
        super(key: key);

  final TabController? controller;

  /// The indicator circle's diameter (the default value is 12.0).
  final double indicatorSize;
  final Color? color;
  final Color? borderColor;
  final Color? selectedColor;

  Widget _buildTabIndicator(
    int tabIndex,
    TabController tabController,
    ColorTween selectedColorTween,
    ColorTween previousColorTween,
  ) {
    Color? background;
    if (tabController.indexIsChanging) {
      // The selection's animation is animating from previousValue to value.
      final double t = 1.0 - indexChangeProgress(tabController);
      if (tabController.index == tabIndex) {
        background = selectedColorTween.lerp(t);
      } else if (tabController.previousIndex == tabIndex)
        // ignore: curly_braces_in_flow_control_structures
        background = previousColorTween.lerp(t);
      else
        // ignore: curly_braces_in_flow_control_structures
        background = selectedColorTween.begin;
    } else {
      // The selection's offset reflects how far the TabBarView has / been dragged
      // to the previous page (-1.0 to 0.0) or the next page (0.0 to 1.0).
      final double offset = tabController.offset;
      if (tabController.index == tabIndex) {
        background = selectedColorTween.lerp(1.0 - offset.abs());
      } else if (tabController.index == tabIndex - 1 && offset > 0.0) {
        background = selectedColorTween.lerp(offset);
      } else if (tabController.index == tabIndex + 1 && offset < 0.0) {
        background = selectedColorTween.lerp(-offset);
      } else {
        background = selectedColorTween.begin;
      }
    }
    return TabPageSelectorIndicator(
      backgroundColor: background!,
      borderColor: borderColor ?? Colors.transparent,
      size: indicatorSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color fixColor = color ?? Colors.transparent;
    final Color fixSelectedColor =
        selectedColor ?? Theme.of(context).colorScheme.secondary;
    final ColorTween selectedColorTween =
        ColorTween(begin: fixColor, end: fixSelectedColor);
    final ColorTween previousColorTween =
        ColorTween(begin: fixSelectedColor, end: fixColor);
    final TabController tabController =
        controller ?? DefaultTabController.of(context);
    assert(() {
      return true;
    }());
    final Animation<double> animation = CurvedAnimation(
      parent: tabController.animation!,
      curve: Curves.fastOutSlowIn,
    );
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Semantics(
          label: 'Page ${tabController.index + 1} of ${tabController.length}',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children:
                List<Widget>.generate(tabController.length, (int tabIndex) {
              return _buildTabIndicator(tabIndex, tabController,
                  selectedColorTween, previousColorTween);
            }).toList(),
          ),
        );
      },
    );
  }
}
