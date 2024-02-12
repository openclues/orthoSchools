
import 'package:azsoon/features/home_screen/presentation/widgets/navigation_indicator.dart';
import 'package:flutter/widgets.dart';

class BottomNavigationItem extends StatefulWidget {
  final bool? isSelected;
  final Widget? activeWidget;
  final Widget? inactiveWidget;
  const BottomNavigationItem({
    super.key,
    required this.activeWidget,
    required this.isSelected,
    required this.inactiveWidget,
  });

  @override
  State<BottomNavigationItem> createState() => _BottomNavigationItemState();
}

class _BottomNavigationItemState extends State<BottomNavigationItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: Stack(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: widget.isSelected == false
                ? Alignment.center
                : Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment:
              //     MainAxisAlignment.center,
              children: [
                Center(
                    child: widget.isSelected == true
                        ? widget.activeWidget
                        : widget.inactiveWidget),
              ],
            ),
          ),
          Visibility(
            visible: widget.isSelected == true,
            child: const NavigationIndicatorWidget(),
          )
        ],
      ),
    );
  }
}
