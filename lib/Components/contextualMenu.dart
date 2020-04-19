import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Reminder/utils/constants.dart';

class ContextualMenu extends StatefulWidget {
  @required final Widget child;
  @required final Widget menu;

  const ContextualMenu({Key key, this.child, this.menu}) : super(key: key);

  @override
  ContextualMenuState createState() => ContextualMenuState();
}

class ContextualMenuState extends State<ContextualMenu> {

  OverlayEntry overlayEntry;

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: <Widget>[
          GestureDetector(
            onPanDown: (d) {
              this.overlayEntry?.remove();
            },
          ),
          Positioned(
            bottom: SizeConfig.screenHeight - offset.dy,
//            width: size.width * 1.5,
            left: SizeConfig.screenWidth/2 - SizeConfig.horizontalBlockSize * 35,
            child: Material(color: Colors.transparent,child: widget.menu)
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this.overlayEntry);
      },
      child: widget.child,
    );
  }
}
