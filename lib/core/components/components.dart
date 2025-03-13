import 'package:eks/core/theme/app_pallete.dart';
import 'package:eks/core/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';




Widget myDivider(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  return Container(
    height: screenHeight * 0.09,
    width: screenWidth * 0.002,
    color: Color(0xFF707070),
  );
}

Future navigateAndFinish(context, screen)=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen),(Route<dynamic> route) =>false);

Future navigateTo(context,Widget screen)=> Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

Future navigateToWithOneReplace(context,Widget screen)=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));

Future navigateToWithTwoReplace(BuildContext context, Widget screen) async {
  Navigator.pop(context);
  Navigator.pop(context);
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}


void navigateToWithPush(context,screen)=> Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        );
      },
    ),
  );

void navigateToWithPushWithReplace(BuildContext context, Widget screen) {
  // Remove the last two screens from the stack
  Navigator.of(context)
    ..pop()
    ..pop();

  // Push the new screen with animation
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        );
      },
    ),
  );
}

void navigateToWithPushWithFinish(BuildContext context, Widget screen) {
  Navigator.of(context).pushAndRemoveUntil(
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        );
      },
    ),
        (Route<dynamic> route) => false, // هذا سيزيل جميع الشاشات السابقة من مكدس التنقل
  );
}


void navigateToWithSlide(context,screen)=> Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ),
  );

void navigateWithReplaceToWithSlide(context,screen){
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ),
  );

}

AppBar mainAppBar(BuildContext context) =>AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {Navigator.pop(context);},
    ),
    title: Padding(
      padding: const EdgeInsets.only(top: 30),
      child: TitleWidget(),
    ),
  );

Widget buildIconButton(BuildContext context, IconData icon, String label, Widget page, double screenWidth, double screenHeight) => InkWell(
    onTap: () {
      navigateTo(context, page);
    },
    child: Column(
      children: [
        CircleAvatar(
          radius: screenWidth * 0.08,
          backgroundColor: Pallat.iconsAndButtonColor,
          child: Icon(
            icon,
            color: Colors.black,
            size: screenWidth * 0.06,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
enum ToastState {SUCSSES,ERROR,WARNING}
Color? TColor;
Color? changeColors(ToastState state){
  switch(state){
    case ToastState.SUCSSES:
      TColor=Colors.green;
      break;
    case ToastState.ERROR:
      TColor=Colors.red;
      break;
    case ToastState.WARNING:
      TColor=Colors.deepOrangeAccent;
      break;}
  return TColor;
}
void showToast({required String text, required ToastState state,}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: changeColors(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}





