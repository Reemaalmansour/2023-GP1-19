import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:novoy/blocs/trip/trip_bloc.dart';
import 'package:novoy/presentation/home%20screen/cubit/cubit.dart';
import 'package:novoy/presentation/login/cubit/cubit.dart';
import 'package:novoy/presentation/profile/cubit/profile_cubit.dart';
import 'package:novoy/shared/component/bloc_observer.dart';
import 'package:novoy/shared/network/cache_helper.dart';

// Import the generated file
import 'app/app.dart';
import 'blocs/places/places_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  runApp(
    Phoenix(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => AuthCubit()),
          BlocProvider(create: (BuildContext context) => HomeCubit()),
          BlocProvider(create: (BuildContext context) => ProfileCubit()),
          BlocProvider(create: (BuildContext context) => TripBloc()),
          BlocProvider(
            create: (BuildContext context) => PlacesBloc()..add(LoadPlaces()),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}
