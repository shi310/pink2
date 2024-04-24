import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  const MyListView({
    Key? key,
    this.controller,
    this.children = const <Widget>[],
    this.padding,
  }) : super(key: key);

  final ScrollController? controller;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    var listView = ListView(
      controller: controller,
      children: children,
      padding: padding,
    );
    var body = MediaQuery.removePadding(
      context: context,
      child: listView,
      removeBottom: true,
      removeTop: true,
    );
    return body;
  }
}

class MyListViewSeparated extends StatelessWidget {
  const MyListViewSeparated({
    Key? key,
    this.controller,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.itemCount,
    this.scrollDirection = Axis.vertical,
    this.padding,
  }) : super(key: key);

  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int) separatorBuilder;
  final int itemCount;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    var listView = ListView.separated(
      controller: controller,
      scrollDirection: scrollDirection,
      itemBuilder: itemBuilder,
      separatorBuilder: separatorBuilder,
      itemCount: itemCount,
      padding: padding,
    );
    var body = MediaQuery.removePadding(
      context: context,
      child: listView,
      removeBottom: true,
      removeTop: true,
    );
    return body;
  }
}
