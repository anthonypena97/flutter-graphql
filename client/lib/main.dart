import 'package:flutter/material.dart';
import 'package:flutter_graphql/views/home_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  
   final HttpLink link = HttpLink(
    'https://graphql-flutter-hobbies.herokuapp.com/graphql',
  );
  
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
  
  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  const MyApp({super.key, required this.client});
  
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: theme,
            appBarTheme: AppBarTheme(
              iconTheme: const IconThemeData(color: Colors.black87),
              // ignore: deprecated_member_use
              textTheme: theme,
            )
          ),
          home: const HomeScreen()
        ),
      ),
    );
  }
}
