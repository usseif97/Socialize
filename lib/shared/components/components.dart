import 'package:flutter/material.dart';
import 'package:socialize/shared/styles/colors.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
      titleSpacing: 5.0,
      title: title != null
          ? Text(
              title,
            )
          : Text(''),
      actions: actions,
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 10.0,
          ),
        ],
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text.toUpperCase()),
    );

Widget defaultColoredButton({
  required String text,
  Function? onTap,
}) =>
    InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              defaultColor,
              Colors.green,
            ],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  double radius = 10.0,
  bool isClickable = true,
  bool showKeyboard = true,
  required BuildContext context,
}) =>
    TextFormField(
      style: Theme.of(context).textTheme.bodyText2,
      showCursor: !showKeyboard,
      readOnly: !showKeyboard,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s) {
        if (onSubmit != null) onSubmit(s);
      },
      onChanged: (s) {
        if (onChange != null) onChange(s);
      },
      onTap: () {
        if (onTap != null) onTap();
      },
      validator: (s) {
        return validate(s);
      },
      decoration: InputDecoration(
        labelStyle: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.normal),
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );

Widget defaultSeperator() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[400],
    ),
  );
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

enum snackBarStates { SUCCESS, ERROR, WARNING }
Color snackBarColor(snackBarStates state) {
  Color color;
  switch (state) {
    case snackBarStates.SUCCESS:
      color = Colors.green;
      break;
    case snackBarStates.ERROR:
      color = Colors.red;
      break;
    case snackBarStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void showSnackBar({
  required BuildContext context,
  required String? content,
  required String label,
  required snackBarStates state,
  Function? onpressed,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: snackBarColor(state),
        content: Text(content!),
        action: SnackBarAction(
          label: label,
          onPressed: () {
            if (onpressed != null) onpressed();
          },
          textColor: Colors.white,
        ),
      ),
    );
