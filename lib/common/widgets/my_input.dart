import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/lang/translation_service.dart';
import 'package:pinker/common/style/library.dart';
import 'package:pinker/common/widgets/library.dart';

class MyInput extends StatefulWidget {
  const MyInput({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.maxLines = 1,
    this.onSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.contentPadding = const EdgeInsets.only(left: 12),
    this.prefixIcon,
    this.suffixIcon,
    this.hintText = Lang.defaultHintText,
    this.obscureText = false,
    this.width = double.infinity,
    this.height = 40,
    this.borderRadius = MyStyle.borderRadius,
    this.onTap,
    this.autofocus = false,
    this.enabled,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final String hintText;
  final bool obscureText;
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final void Function()? onTap;
  final bool autofocus;
  final bool? enabled;

  static Widget getInfo(
    String text,
    String hintText, {
    TextEditingController? controller,
    FocusNode? focusNode,
    bool obscureText = false,
  }) {
    var textBox = SizedBox(
      width: 80,
      child: MyText(text),
    );

    var inputBox = MyInput(
      obscureText: obscureText,
      controller: controller ?? TextEditingController(),
      focusNode: focusNode ?? FocusNode(),
      hintText: hintText,
    );

    var bodyChildren = [
      textBox,
      Expanded(child: inputBox),
    ];
    var body = Row(children: bodyChildren);
    return body;
  }

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  Widget? _suffixIcon;

  void clear() {
    setState(() => _suffixIcon = null);
    widget.controller.clear();
    widget.focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    var clearButton = SizedBox(
      width: 30,
      height: 30,
      child: MyButton.close(onTap: clear),
    );

    void _setState() {
      if (widget.suffixIcon == null || widget.suffixIcon == MyIcons.close()) {
        _suffixIcon = widget.controller.text.isEmpty ? null : clearButton;
      } else {
        _suffixIcon = widget.controller.text.isEmpty
            ? null
            : SizedBox(width: 30, height: 30, child: widget.suffixIcon);
      }
    }

    widget.controller.addListener(() => setState(_setState));

    const hintStyle = TextStyle(fontSize: 14, color: MyColors.secondText);
    var inputDecoration = InputDecoration(
      prefixIcon: widget.prefixIcon,
      suffixIcon: _suffixIcon,
      contentPadding: widget.contentPadding,
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      hintText: widget.hintText.tr,
      hintStyle: hintStyle,
    );
    const style = TextStyle(color: MyColors.text, fontSize: 14);
    var textField = TextField(
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      controller: widget.controller,
      onSubmitted: widget.onSubmitted,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      decoration: inputDecoration,
      obscureText: widget.obscureText,
      onTap: widget.onTap,
      cursorColor: MyColors.primary,
      style: style,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
    );
    var edge = Clip.hardEdge;
    var alias = Clip.antiAlias;
    var clipBehavior = widget.borderRadius == BorderRadius.zero ? edge : alias;

    var boxDecoration = BoxDecoration(
        borderRadius: widget.borderRadius,
        shape: BoxShape.rectangle,
        color: MyColors.input);
    return Container(
      child: textField,
      width: widget.width,
      height: widget.height,
      clipBehavior: clipBehavior,
      decoration: boxDecoration,
    );
  }
}
