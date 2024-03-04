// ignore_for_file: dead_code

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:hayaah_karimuh/generated/codegen_loader.g.dart';
import 'package:hayaah_karimuh/router/app_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'bloc/change_Image/changeImage_bloc.dart';
import 'bloc/langouage/langouage_cubit.dart';
import 'bloc/profile/profile_bloc.dart';
import 'constants/my_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter<Model_Cache_Setting>(ModelCacheSettingAdapter());
  await Hive.openBox<Model_Cache_Setting>('Model_Cache_Setting');

  runApp(EasyLocalization(
    supportedLocales: const [Locale('ar'), Locale('en')],
    path: 'assets/translations', // <-- change patch to your
    fallbackLocale: const Locale('ar'),
    assetLoader: const CodegenLoader(),
    saveLocale: true,
    child: MyApp(
      appRouter: AppRouter(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.

  Widget ResponsiveSizer_(Locale locale, BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (c, b) => MaterialApp(
            builder: (context, widget) => ResponsiveWrapper.builder(BouncingScrollWrapper.builder(context, widget!),
                maxWidth: 1200,
                minWidth: 450,
                defaultScale: true,
                breakpoints: [
                  const ResponsiveBreakpoint.resize(450, name: MOBILE),
                  const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
                background: Container(color: HexColor(MyColors.green))),
            // localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            color: HexColor(MyColors.white),
            locale: locale,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
            title: '',
            theme: ThemeData(
              cardColor: HexColor(MyColors.green),
              fontFamily: "dInnext",
            ).copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: <TargetPlatform, PageTransitionsBuilder>{
                  TargetPlatform.android: ZoomPageTransitionsBuilder(),
                },
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    Repository repository = Repository(Services(), Data_Local());

    return MultiRepositoryProvider(
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
            print("----->langouage :::: $lang");
            Intl.defaultLocale = "$lang";
            return ResponsiveSizer_(Locale("$lang"), context);
          }),
        ));

    BlocProvider(
        create: (context) => LangouageCubit(),
        child: BlocBuilder<LangouageCubit, Locale>(builder: (context, lang) {
          context.setLocale(Locale("$lang"));
          // ignore: avoid_print
          print("----->langouage :::: $lang");
          Intl.defaultLocale = "$lang";
          return ResponsiveSizer_(Locale("$lang"), context);
        }));
  }
}
