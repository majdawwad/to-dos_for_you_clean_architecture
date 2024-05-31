import 'package:flutter/material.dart';

import 'core/loaclization/intialize_localization.dart';
import 'core/route/go_router_provider.dart';
import 'dependency_injection.dart' as di;
import 'todos_main_widget_app.dart';

final GoRouterProvider goRouterProvider = GoRouterProvider();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  goRouterProvider.isLoggedIn();
  await di.init();
  await IntializeLocalization.initial();
  runApp(TodosMainWidgetApp());
}
