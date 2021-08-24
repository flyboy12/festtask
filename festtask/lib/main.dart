import 'package:festtask/app_constant.dart';
import 'package:festtask/models/event.dart';
import 'package:festtask/models/routine.dart';
import 'package:festtask/models/task.dart';
import 'package:festtask/provider/app_provider.dart';
import 'package:festtask/provider/main_provider.dart';
import 'package:festtask/provider/notification.dart';
import 'package:festtask/routes/routes.dart';
import 'package:festtask/screens/event_screen.dart';
import 'package:festtask/screens/routine_screen.dart';
import 'package:festtask/screens/task_screen.dart';
import 'package:festtask/widgets/Event/calendar.dart';
import 'package:festtask/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationApi().init();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(EventModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(RoutineModelAdapter());
  await Hive.openBox<EventModel>("eventBox");
  await Hive.openBox<TaskModel>("taskBox");
  await Hive.openBox<RoutineModel>("routineBox");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(),
        ),
        ChangeNotifierProvider(create: (_) => MainProvider()..initData()),
      ],
      child: MaterialApp(
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [const Locale('tr')],
        debugShowCheckedModeBanner: false,
        theme: AppThemeConstant.theme,
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (_) => Home(),
          AppRoutes.calendar: (_) => Calendar(),
          AppRoutes.event: (_) => EventScreen(),
          AppRoutes.task: (_) => TaskScreen(),
          AppRoutes.routine: (_) => RoutineScreen(),
        },
      ),
    );
  }
}
