import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatefulWidget {
  final String? label;
  final TextEditingController? inputController;
  final bool? isDisable;
  final bool? isReadOnly;
  final bool? isPassword;
  final Color? textFieldColor;
  final Color? textColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final int? maxLines;
  final TextAlign? textAlign;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? errorText;
  final double? border;
  final void Function()? onTap;

  const CommonTextField({
    super.key,
    this.label,
    this.inputController,
    this.isDisable,
    this.textFieldColor,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.onEditingComplete,
    this.inputFormatters,
    this.onChanged,
    this.maxLength,
    this.maxLines,
    this.textAlign,
    this.hintText,
    this.hintStyle,
    this.errorText,
    this.textColor,
    this.border = 10,
    this.onTap,
    this.isReadOnly,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool? passwordVisible = true;
  @override
  void initState() {
    super.initState();
    passwordVisible = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            IgnorePointer(
              ignoring: widget.isDisable ?? false,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(
                      color: widget.textColor ?? Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    keyboardType: (widget.keyboardType != null && widget.keyboardType != '')
                        ? widget.keyboardType
                        : TextInputType.multiline,
                    textInputAction: widget.textInputAction ?? TextInputAction.newline,
                    onEditingComplete: widget.onEditingComplete ??
                        () {
                          FocusScope.of(context).nextFocus();
                        },
                    inputFormatters: widget.inputFormatters,
                    obscureText: passwordVisible!,
                    enableInteractiveSelection: widget.isDisable == true ? false : true,
                    readOnly: widget.isReadOnly ?? widget.isDisable ?? false,
                    controller: widget.inputController,
                    onChanged: widget.onChanged,
                    maxLength: widget.maxLength,
                    maxLines: widget.maxLines,
                    textAlign:
                        (widget.textAlign != null && widget.textAlign != "") ? widget.textAlign! : TextAlign.start,
                    onTap: widget.onTap,
                    decoration: InputDecoration(
                      labelText: widget.label,
                      labelStyle: TextStyle(
                        color: widget.errorText == null ? Color(0xFF337EEE) : Color(0xFFD60000),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xFFEBF2FD)),
                        borderRadius: BorderRadius.circular(widget.border!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFFEBF2FD)),
                        borderRadius: BorderRadius.circular(widget.border!),
                      ),
                      filled: true,
                      fillColor:
                          (widget.errorText != null && widget.errorText != "") ? Color(0xFFFFE7E7) : Colors.white,
                      hintText: (widget.hintText != null && widget.hintText != "") ? widget.hintText : '',
                      hintStyle: (widget.hintStyle != null && widget.hintStyle != "") ? widget.hintStyle : null,
                      suffixIcon: widget.isPassword!
                          ? IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordVisible! ? Icons.visibility : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                passwordVisible = !passwordVisible!;
                                setState(() {
                                  if (passwordVisible == true) {
                                  } else {}
                                });
                              },
                            )
                          : null,
                    ),
                  ),
                  (widget.errorText != null && widget.errorText != "")
                      ? Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5, top: 2),
                                child: Icon(
                                  Icons.warning,
                                  color: Color(0xFFD60000),
                                  size: 16,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget.errorText ?? "",
                                  style: TextStyle(color: Color(0xFFD60000), fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
