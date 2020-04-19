import 'package:flutter/cupertino.dart';
import 'package:Reminder/Components/customToggleButtons.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';

class PersistentPage extends StatefulWidget{

  final Widget child;

  const PersistentPage ({ Key key, this.child}): super(key: key);

  @override
  PersistentPageState createState() {
    return PersistentPageState();
  }
}

class PersistentPageState extends State<PersistentPage> with AutomaticKeepAliveClientMixin<PersistentPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

