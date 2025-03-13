import 'package:flutter/material.dart';

class SnackBarMessage{
  void  showSuccessMessage(BuildContext context,String message){
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.green,)
    );
  }

  void  showErrorMessage(BuildContext context,String message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red,)
    );
  }

}