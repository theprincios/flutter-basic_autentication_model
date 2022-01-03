import 'package:flutter/material.dart';
import 'package:project_model/core/routing/provider/navigation_provider.dart';
import 'package:project_model/ui/pages/pages.dart';
import 'package:provider/provider.dart';

class MyNavigator {
  static void navigateTo(BuildContext context, Pages page,
          {Object data = ''}) =>
      Provider.of<NavigatorProvider>(context, listen: false)
          .setPage(page, data: data);

  static void pop(BuildContext context, {bool? pop}) =>
      Navigator.pop(context, pop ?? true);
}
