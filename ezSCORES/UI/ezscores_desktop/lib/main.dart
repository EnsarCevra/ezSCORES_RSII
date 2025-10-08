import 'package:ezscores_desktop/providers/ApplicationsProvider.dart';
import 'package:ezscores_desktop/providers/CitiesProvider.dart';
import 'package:ezscores_desktop/providers/CompetitionRefereeProvider.dart';
import 'package:ezscores_desktop/providers/CompetitionSponsorsProvider.dart';
import 'package:ezscores_desktop/providers/CompetitionTeamPlayerProvider.dart';
import 'package:ezscores_desktop/providers/CompetitionTeamsProvider.dart';
import 'package:ezscores_desktop/providers/CompetitionsProvider.dart';
import 'package:ezscores_desktop/providers/CompetitionsRefereesMatchesProvider.dart';
import 'package:ezscores_desktop/providers/FixturesProvider.dart';
import 'package:ezscores_desktop/providers/GoalProvider.dart';
import 'package:ezscores_desktop/providers/MatchesProvider.dart';
import 'package:ezscores_desktop/providers/PlayersProvider.dart';
import 'package:ezscores_desktop/providers/RefereesProvider.dart';
import 'package:ezscores_desktop/providers/RewardsProvider.dart';
import 'package:ezscores_desktop/providers/RolesProvider.dart';
import 'package:ezscores_desktop/providers/SelectionProvider.dart';
import 'package:ezscores_desktop/providers/SponsorsProvider.dart';
import 'package:ezscores_desktop/providers/StadiumsProvider.dart';
import 'package:ezscores_desktop/providers/TeamProvider.dart';
import 'package:ezscores_desktop/providers/GroupsProvider.dart';
import 'package:ezscores_desktop/providers/UserProvider.dart';
import 'package:ezscores_desktop/providers/auth_provider.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:ezscores_desktop/screens/admin_dashboard_screen.dart';
import 'package:ezscores_desktop/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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







  ], child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white
          )),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 38, 208, 47)),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget{
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>
{
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController  = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    setState(() {
      _isLoading = true;
    });

    AuthProvider.username = _usernameController.text;
    AuthProvider.password = _passwordController.text;

    try {
      var userProvider = UserProvider();
      var user = await userProvider.login(
        AuthProvider.username,
        AuthProvider.password,
      );

      if (user.role!.id != 1 && user.role!.id != 3) {
        setState(() => _isLoading = false);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Obavijest"),
            content: const Text("Ovaj tip korisnika nije podržan na desktop aplikaciji"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Uredu'))
            ],
          ),
        );
        return;
      }
      AuthProvider.id = user.id;
      AuthProvider.firstName = user.firstName;
      AuthProvider.lastName = user.lastName;
      AuthProvider.userName = user.userName;
      AuthProvider.picture = user.picture;
      AuthProvider.email = user.email;
      AuthProvider.phoneNumber = user.phoneNumber;
      AuthProvider.organization = user.organization;
      AuthProvider.roleID = user.role?.id;
      AuthProvider.roleName = user.role?.name;
      AuthProvider.roleDecription = user.role?.description;

      setState(() => _isLoading = false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AdminDashboardScreen(selectedIndex: 0),
        ),
      );
    } on UserException catch (exception) {
      setState(() => _isLoading = false);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Greška prilikom prijave"),
          content: Text(exception.exMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
   @override
  Widget build(BuildContext context){
    return Stack(
      children: [Scaffold(
        appBar: AppBar(title: const Text("ezSCORES"), backgroundColor: Colors.green,),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 400, maxWidth: 300),
            child: Card(
              child: Padding(padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Image.asset("assets/images/ezlogo5.png", height: 100, width: 100,),
                  const SizedBox(height: 50,),
                  SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: "Korisničko ime",
                            prefixIcon: Icon(Icons.supervised_user_circle)
                          ),
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: "Lozinka",
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: _obscurePassword ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined)),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => RegisterScreen(enableRoles: false,)),
                              );
                            },
                            child: const Text(
                              "Nemate račun? Kreirajte ga ovdje!",
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                          ),
                        onPressed: _handleLogin,
                         child: const Text("Prijavi se"))
                      ],
                    )
                  )
                ],
              ),
              )
            ),
          ),
        )
      ),
      if(_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}