import 'package:algov/app/app_root.dart';
import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/data_structure/hash/bloc/hash_bloc.dart';
import 'package:algov/data_structure/stack/bloc/stack_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppBloc()),
        BlocProvider(create: (_) => DataStructureBloc()),
        BlocProvider(create: (_) => HashBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const ModernDrawerLayout(),
      ),
    );
  }
}
