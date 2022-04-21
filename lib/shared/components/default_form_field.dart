import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

class DefaultFormField extends StatelessWidget {
  String? label;
  TextEditingController? controller;
  TextInputType? type;
  void Function(String)? onSubmit;
  void Function(String)? onChange;
  void Function()? onTap;
  bool isPassword = false;
  String? Function(String?)? validate;
  IconData? prefix;
  IconData? suffix;
  Text? hintText;
  void Function()? suffixPressed;
  bool isClickable = true;
  bool isSuffix = false;

  DefaultFormField({
    required this.controller,
    this.isClickable = true,
    this.isPassword = false,
    this.isSuffix = false,
    required this.label,
    this.onChange,
    this.onSubmit,
    this.onTap,
    this.prefix,
    this.suffix,
    this.suffixPressed,
    this.type,
    this.validate,
    this.hintText,
  });
  @override
  Widget build(BuildContext context) {
    // change Language variable
    var lan = AppCubit.get(context);
    

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: TextFormField(
        
        controller: controller,
        style: Theme.of(context).textTheme.headline4,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan.shade700, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          filled: true,
          /* fillColor: Colors.white10, */
         /*  hintText: lan.getTexts('tasks').toString(), */
         /*  hintStyle: TextStyle(color: Colors.grey), */
          contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
          /* enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white10, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ), */
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan.shade700, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          labelText: label,
        /*   labelStyle: TextStyle(color: Colors.deepOrange), */
          prefixIcon: Padding(
            //Padding acc to Language
            padding: lan.isEn
                ? EdgeInsets.all(8.0)
                : const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 10.0, 0.0),
            ////////

            child: Icon(
              prefix,
              color: Colors.grey,
            ),
          ),
          suffixIcon: isSuffix
              ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
              : null,
        ),
      ),
    );
  }
}
