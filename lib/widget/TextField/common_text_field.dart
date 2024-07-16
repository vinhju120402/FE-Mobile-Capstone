import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? inputController;
  final bool? isDisable;
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

  const CommonTextField({
    super.key,
    this.label,
    this.inputController,
    this.isDisable,
    this.textFieldColor,
    this.isPassword,
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            IgnorePointer(
              ignoring: isDisable ?? false,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(
                      color: textColor ?? Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    keyboardType: (keyboardType != null && keyboardType != '') ? keyboardType : TextInputType.multiline,
                    textInputAction: textInputAction ?? TextInputAction.newline,
                    onEditingComplete: onEditingComplete ??
                        () {
                          FocusScope.of(context).nextFocus();
                        },
                    inputFormatters: inputFormatters,
                    obscureText: isPassword ?? false,
                    enableInteractiveSelection: isDisable == true ? false : true,
                    readOnly: isDisable ?? false,
                    controller: inputController,
                    onChanged: onChanged,
                    maxLength: maxLength,
                    maxLines: maxLines,
                    textAlign: (textAlign != null && textAlign != "") ? textAlign! : TextAlign.start,
                    decoration: InputDecoration(
                      labelText: label,
                      labelStyle: TextStyle(
                        color: errorText == null ? Color(0xFF337EEE) : Color(0xFFD60000),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xFFEBF2FD)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFFEBF2FD)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: (errorText != null && errorText != "") ? Color(0xFFFFE7E7) : Colors.white,
                      hintText: (hintText != null && hintText != "") ? hintText : '',
                      hintStyle: (hintStyle != null && hintStyle != "") ? hintStyle : null,
                    ),
                  ),
                  (errorText != null && errorText != "")
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
                                  errorText ?? "",
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
