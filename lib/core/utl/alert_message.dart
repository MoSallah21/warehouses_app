import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';

class AlertMessage{
  Widget alertDia(String text,BuildContext context,void Function()? done())=> AlertDialog(
  title: Text(S.of(context).confirmDelete),
  content: Text(S.of(context).deleteAlert+' '+text),
  actions: [
  TextButton(
  child: Text(S.of(context).no),
  onPressed: () {
  Navigator.of(context).pop();
  },
  ),
  TextButton(
  child: Text(S.of(context).yes),
  onPressed: () {
    done();  },
  ),
  ],
  );

}