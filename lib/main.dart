import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hayaah_karimuh/bloc/AuthHandel/auth_handel_bloc.dart';
import 'package:hayaah_karimuh/bloc/benifetsType/benifets_bloc.dart';
import 'package:hayaah_karimuh/bloc/cities/cities_bloc.dart';
import 'package:hayaah_karimuh/bloc/governments/governments_bloc.dart';
import 'package:hayaah_karimuh/bloc/login/login_bloc.dart';
import 'package:hayaah_karimuh/bloc/register/register_bloc.dart';
import 'package:hayaah_karimuh/bloc/step_pageview/pageview_bloc.dart';
import 'package:hayaah_karimuh/data/data_source/api/services.dart';
import 'package:hayaah_karimuh/data/data_source/local/local.dart';
import 'package:hayaah_karimuh/data/model/model_cache/model_cache.dart';
import 'package:hayaah_karimuh/data/repository/repository.dart';
import 'package:hayaah_karimuh/empolyer/helpers/firebase_helper.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/providers/add_group_members_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/attach_preview_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/auth_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/beneficiaries_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/chat_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/create_group_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/edit_profile_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/filter_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/group_files_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/group_members_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/inspections_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/main_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/messages_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/notifications_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/one_to_one_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/profile_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/projects_provider.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/echo.dart';
import 'package:hayaah_karimuh/empolyer/utils/notification_service.dart';
import 'package:hayaah_karimuh/firebase_options.dart';
import 'package:hayaah_karimuh/generated/codegen_loader.g.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:hayaah_karimuh/router/app_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'bloc/change_Image/changeImage_bloc.dart';
import 'bloc/langouage/langouage_cubit.dart';
import 'bloc/profile/profile_bloc.dart';
import 'empolyer/providers/splash_provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform );

  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await PreferencesManager.init();
  await FirebaseHelper.init();
  await NotificationService().init();
  await FlutterDownloader.initialize(debug: true);
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );

  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  
  
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotificationService().showNotifications(message.data.hashCode, message.notification!.title!, message.notification!.body!, message.data.toString());
  });



  // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {});
  // FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //   if (message.data['type'] == 'private') {
  //     kEcho("private456u45");
  //     navigatorKey.currentState!.push(MaterialPageRoute(
  //         builder: (_) => const ChatScreen(),
  //         settings: RouteSettings(arguments: {
  //           'group_id': message.data['group_id'],
  //           'type': 0,
  //           'is_notification': true,
  //           'new_chat': false,
  //         })));
  //   } else {
  //     kEcho("private1231241");
  //     navigatorKey.currentState!.push(MaterialPageRoute(
  //         builder: (_) => const ChatScreen(),
  //         settings: RouteSettings(arguments: {
  //           'group_id': message.data['group_id'],
  //           'type': 1,
  //           'is_notification': true,
  //           'new_chat': false,
  //         })));
  //   }
  // });

  Hive.registerAdapter<Model_Cache_Setting>(ModelCacheSettingAdapter());
  await Hive.openBox<Model_Cache_Setting>('Model_Cache_Setting');

  runApp(EasyLocalization(
    supportedLocales: const [Locale('ar'), Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('ar'),
    assetLoader: const CodegenLoader(),
    useOnlyLangCode: true,
    saveLocale: true,
    child: MyApp(appRouter: AppRouter()),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Repository repository = Repository(Services(), Data_Local());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => CreateGroupProvider()),
        ChangeNotifierProvider(create: (context) => MessagesProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (context) => AttachPreviewProvider()),
        ChangeNotifierProvider(create: (context) => ProjectsProvider()),
        ChangeNotifierProvider(create: (context) => BeneficiariesProvider()),
        ChangeNotifierProvider(create: (context) => EditProfileProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => GroupFilesProvider()),
        ChangeNotifierProvider(create: (context) => GroupMembersProvider()),
        ChangeNotifierProvider(create: (context) => OneToOneProvider()),
        ChangeNotifierProvider(create: (context) => InspectionsProvider()),
        ChangeNotifierProvider(create: (context) => NotificationsProvider()),
        ChangeNotifierProvider(create: (context) => FilterProvider()),
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => AddGroupMembersProvider()),
      ],
      child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<Repository>(create: (context) => repository),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<PageviewBloc>(create: (BuildContext context) => PageviewBloc()),
              BlocProvider<LangouageCubit>(create: (BuildContext context) => LangouageCubit()),
              BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc(repository)),
              BlocProvider<AuthHandelBloc>(create: (BuildContext context) => AuthHandelBloc(repository)),
              BlocProvider<GovernmentsBloc>(create: (BuildContext context) => GovernmentsBloc(repository)),
              BlocProvider<CitiesBloc>(create: (BuildContext context) => CitiesBloc(repository)),
              BlocProvider<BenfetsBloc>(create: (BuildContext context) => BenfetsBloc(repository)),
              BlocProvider<RegisterBloc>(create: (BuildContext context) => RegisterBloc(repository)),
              BlocProvider<ProfileBloc>(create: (BuildContext context) => ProfileBloc(repository)),
              BlocProvider<ChangeImageBloc>(create: (BuildContext context) => ChangeImageBloc(repository)),
            ],
            child: BlocBuilder<LangouageCubit, Locale>(builder: (context, lang) {
              context.setLocale(Locale("$lang"));
              if (ModalRoute.of(context) != null) {
                String currentRoute = ModalRoute.of(context)!.settings.name.toString();
                kEcho("currentRoute$currentRoute");
              } else {
                kEcho("currentRoute null");
              }
              Intl.defaultLocale = "$lang";
              //current route
              return ScreenUtilInit(
                designSize: const Size(360, 690),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (c, b) {
                  return MaterialApp(
                    builder: ((context, child) {
                      return FlutterEasyLoading(
                        child: ResponsiveWrapper.builder(
                          BouncingScrollWrapper.builder(context, child ?? Container()),
                          maxWidth: 1200,
                          minWidth: 450,
                          defaultScale: true,
                          breakpoints: [
                            const ResponsiveBreakpoint.resize(50, name: MOBILE),
                            const ResponsiveBreakpoint.resize(450, name: MOBILE),
                            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                          ],
                          background: Container(color: const Color(0xff09AB9C)),
                        ),
                      );
                    }),
                    navigatorKey: navigatorKey,
                    debugShowCheckedModeBanner: false,
                    title: "Haya Karima",
                    onGenerateRoute: appRouter.generateRoute,
                    theme: ThemeData(
                      useMaterial3: false,
                      primaryColor: AppColors.primaryColor,
                      backgroundColor: AppColors.mainBackground,
                      scaffoldBackgroundColor: AppColors.mainBackground,
                      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.appOrange, primary: AppColors.primaryColor),
                      textTheme: Theme.of(context).textTheme.apply(fontSizeFactor: 1),
                    ),
                    home: SplashScreen(),
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: lang,
                    //todo change
                  );
                },
              );
            }),
          )),
    );
  }
}
