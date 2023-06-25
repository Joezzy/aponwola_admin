import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/common/app_theme.dart';
import 'package:aponwola_admin/util/utils.dart';


class MyText extends StatelessWidget {
  final Function(String value)? onChanged;
  String? Function(String? value)? validator;
  bool isPasswordField;
  bool isEnabled;
  bool readOnly;
  String hintText;
  String initialValue;
  double width;
  double borderRadius;
  double height;
  int maxLength;
  int maxLine;
  TextStyle? textStyle;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextEditingController? controller;
  TextInputType? keyboardType;
  void Function()? onSuffixItemTapped;
  void Function()? onPrefixItemTapped;
  EdgeInsetsGeometry? contentPadding;
  bool isNaira;
  bool alignCenter;

  MyText({
    this.validator,
    this.isPasswordField = false,
    this.isEnabled = true,
    this.hintText = "",
    this.initialValue = '',
    this.width = double.infinity,
    this.borderRadius = 10,
    this.height = 20,
    this.textStyle,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.maxLength = 80,
    this.maxLine = 1,
    this.onSuffixItemTapped,
    this.onPrefixItemTapped,
    this.keyboardType,
    this.controller,
    this.contentPadding,
     this.onChanged,
    this.isNaira = false,
    this.alignCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    bool usesSuffixIcon = (suffixIcon != null);
    bool usesPrefixIcon = (prefixIcon != null);
    Screen screen = getScreen();
    return Container(
      width: (screen == Screen.tab) ? width / 1.4 : width,
      child: TextFormField(
        enabled: isEnabled,
        onChanged: onChanged,
        controller: controller,
        obscureText: isPasswordField,
        maxLines: maxLine,
        readOnly: readOnly,
        maxLength: maxLength,
        validator: validator,
        keyboardType: isNaira && keyboardType == null
            ? TextInputType.number
            : keyboardType,
        inputFormatters: (keyboardType == TextInputType.number)
            ? [
          new FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
        ]
            : null,
        textAlign: alignCenter?TextAlign.center:TextAlign.left,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppTheme.placeHolder,fontWeight: FontWeight.w500),
          counterText: "",

         border: InputBorder.none,
          filled: true,
          fillColor: Color(0xFFF2F4F7),
          prefixIcon:  usesPrefixIcon
              ? InkWell(
            onTap: onPrefixItemTapped,
            enableFeedback: true,
            child: prefixIcon,
          ): null,

          suffixIcon: usesSuffixIcon
              ? InkWell(
            onTap: onSuffixItemTapped,
            enableFeedback: true,
            child: suffixIcon,
          )
              : null,
          contentPadding: (contentPadding == null)
              ? EdgeInsets.symmetric(vertical: 3, horizontal: 10)
              : contentPadding,
        ),
        style: textStyle,
      ),
    );
  }
}

class MyDropDown extends StatelessWidget {
  final Widget suffixIcon;
  final String hint;
  final String drop_value;
  final double width;
  final double fontSize;
  void Function(String? item)? onChanged;
  final List<DropdownMenuItem<String>> itemFunction;

  MyDropDown({
    this.drop_value = "",
    this.hint = "",
    this.fontSize=14,
    this.width = double.maxFinite,
    this.suffixIcon = const Text("show"),
    required this.itemFunction,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: (getScreen() == Screen.tab) ? width / 1.4 : width,
      child: DropdownButtonFormField<String>(
        value: drop_value,
        isDense: true,
        // itemHeight: null,
        icon: Visibility(visible: true, child: Icon(Icons.keyboard_arrow_down)),
        style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.1,
            fontSize: fontSize,
            fontWeight: FontWeight.w600),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppTheme.placeHolder,fontWeight: FontWeight.w500),
            counterText: "",
            border:InputBorder.none,
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Colors.grey.withOpacity(0.5),
            //     width: 0.5,
            //   ),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: AppTheme.primaryColor,
            //     width: 0.5,
            //   ),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            // border: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Color(0x00000000).withOpacity(0.1),
            //     width: 0.2,
            //   ),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            // disabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Color(0x00000000),
            //     width: 0.5,
            //   ),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            filled: true,
            fillColor: AppTheme.o3Grey,
            contentPadding: EdgeInsets.symmetric(vertical: -10, horizontal: 10)),
        isExpanded: true,
        onChanged: onChanged,
        items: itemFunction,
      ),
    );
  }
}

class SearchTxt extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? multiSwitch;
  final String hint;
  final TextInputType? inputType;
  final bool hashValue;
  final VoidCallback? searchFunction;
  final double borderRadius;
  final double width;
  void Function(String value)? onChanged;

  SearchTxt(
      {this.controller,
        this.borderRadius = 5,
        this.width = 400,
        required this.onChanged,
        this.hint = '',
        this.prefixIcon,
        this.suffixIcon,
        this.inputType,
        this.multiSwitch,
        this.searchFunction,
        this.hashValue = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: AppTheme.placeHolder,
              fontSize: MySize.size16,
              fontWeight: FontWeight.w500),
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.4),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.4),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),

          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.4),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.4),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          // filled: true,
          // fillColor: Color(0xFFC4C4C4).withOpacity(0.2),
          prefixIcon:prefixIcon ,
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          suffixIcon: suffixIcon,
        ),
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class SearchDate extends StatelessWidget {
  const SearchDate({
    Key? key,
    required this.expandCalender,
    required this.onTap,
    this.prefixIcon,
    this.text = "",
  }) : super(key: key);

  final bool expandCalender;
  final Widget? prefixIcon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        width: expandCalender ? MySize.screenWidth : MySize.size50,
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.all(MySize.size10),
        decoration: BoxDecoration(
          color: Color(0xFFC4C4C4).withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: MySize.size20),
                  child: prefixIcon!,
                ),
                Text(text),
              ],
            ),
            Icon(MdiIcons.magnify),
          ],
        ),
      ),
    );
  }
}
