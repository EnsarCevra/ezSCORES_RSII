import 'dart:io';

import 'package:ezscores_mobile/providers/ApplicationsProvider.dart';
import 'package:ezscores_mobile/providers/CitiesProvider.dart';
import 'package:ezscores_mobile/providers/CompetitionRefereeProvider.dart';
import 'package:ezscores_mobile/providers/CompetitionSponsorsProvider.dart';
import 'package:ezscores_mobile/providers/CompetitionTeamPlayerProvider.dart';
import 'package:ezscores_mobile/providers/CompetitionTeamsProvider.dart';
import 'package:ezscores_mobile/providers/CompetitionsProvider.dart';
import 'package:ezscores_mobile/providers/CompetitionsRefereesMatchesProvider.dart';
import 'package:ezscores_mobile/providers/FavoriteCompetitionsProvider.dart';
import 'package:ezscores_mobile/providers/FixturesProvider.dart';
import 'package:ezscores_mobile/providers/GoalProvider.dart';
import 'package:ezscores_mobile/providers/MatchesProvider.dart';
import 'package:ezscores_mobile/providers/PlayersProvider.dart';
import 'package:ezscores_mobile/providers/RefereesProvider.dart';
import 'package:ezscores_mobile/providers/ReviewsProvider.dart';
import 'package:ezscores_mobile/providers/RewardsProvider.dart';
import 'package:ezscores_mobile/providers/RolesProvider.dart';
import 'package:ezscores_mobile/providers/SelectionProvider.dart';
import 'package:ezscores_mobile/providers/SponsorsProvider.dart';
import 'package:ezscores_mobile/providers/StadiumsProvider.dart';
import 'package:ezscores_mobile/providers/TeamProvider.dart';
import 'package:ezscores_mobile/providers/GroupsProvider.dart';
import 'package:ezscores_mobile/providers/UserProvider.dart';
import 'package:ezscores_mobile/screens/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    setWindowTitle('Mobile Simulation');
    setWindowMinSize(const Size(450, 844));
    setWindowMaxSize(const Size(450, 844));
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CompetitionProvider()),
    ChangeNotifierProvider(create: (_) => TeamProvider()),
    ChangeNotifierProvider(create: (_) => SelectionProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => PlayerProvider()),
    ChangeNotifierProvider(create: (_) => RolesProvider()),
    ChangeNotifierProvider(create: (_) => CityProvider()),
    ChangeNotifierProvider(create: (_) => StadiumProvider()),
    ChangeNotifierProvider(create: (_) => SponsorProvider()),
    ChangeNotifierProvider(create: (_) => ApplicationProvider()),
    ChangeNotifierProvider(create: (_) => CompetitionTeamsProvider()),
    ChangeNotifierProvider(create: (_) => GroupProvider()),
    ChangeNotifierProvider(create: (_) => RefereeProvider()),
    ChangeNotifierProvider(create: (_) => CompetitionsRefereesProvider()),
    ChangeNotifierProvider(create: (_) => CompetitionsSponsorsProvider()),
    ChangeNotifierProvider(create: (_) => RewardProvider()),
    ChangeNotifierProvider(create: (_) => FixtureProvider()),
    ChangeNotifierProvider(create: (_) => MatchesProvider()),
    ChangeNotifierProvider(create: (_) => CompeititionRefereeMatchProvider()),
    ChangeNotifierProvider(create: (_) => GoalProvider()),
    ChangeNotifierProvider(create: (_) => CompetitionsTeamsPlayersProvider()),
    ChangeNotifierProvider(create: (_) => FavoriteCompetitionsProvider()),
    ChangeNotifierProvider(create: (_) => ReviewsProvider()),







  ], child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ezSCORES mobile',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white
          )),
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 38, 208, 47)),
        useMaterial3: true,
      ),
      home: MainNavigationScreen(),
    );
  }
}
