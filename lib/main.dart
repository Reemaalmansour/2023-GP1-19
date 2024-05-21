import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../presentation/home%20screen/cubit/cubit.dart';
import '../presentation/login/cubit/cubit.dart';
import '../presentation/profile/cubit/profile_cubit.dart';
import '../shared/component/bloc_observer.dart';
import '../shared/network/cache_helper.dart';
// Import the generated file
import 'app/app.dart';
import 'blocs/places/places_bloc.dart';
import 'firebase_options.dart';
import 'presentation/blog/cubit/blog_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  await CacheHelper.initHive();

  runApp(
    Phoenix(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => AuthCubit()),
          BlocProvider(create: (BuildContext context) => HomeCubit()),
          BlocProvider(create: (BuildContext context) => ProfileCubit()),
          BlocProvider(
            create: (BuildContext context) => PlacesBloc()..add(LoadPlaces()),
          ),
          // add BlogCubit
          BlocProvider(
            create: (BuildContext context) => BlogCubit.instance,
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}
