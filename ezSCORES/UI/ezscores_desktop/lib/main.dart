import 'package:ezscores_desktop/providers/SelectionProvider.dart';
import 'package:ezscores_desktop/providers/TeamProvider.dart';
import 'package:ezscores_desktop/providers/UserProvider.dart';
import 'package:ezscores_desktop/providers/auth_provider.dart';
import 'package:ezscores_desktop/screens/teams_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => TeamProvider()),
    ChangeNotifierProvider(create: (_) => SelectionProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),

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
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 38, 208, 47)),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
class LoginPage extends StatelessWidget
{
  LoginPage({super.key});
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController  = TextEditingController();
   @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("ezSCORES"), backgroundColor: Colors.green,),
      body: Center(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxHeight: 400, maxWidth: 300),
            child: Card(
              child: Padding(padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Image.asset("assets/images/ezlogo5.png", height: 100, width: 100,),
                  SizedBox(height: 50,),
                  Container(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: "Korisničko ime",
                            prefixIcon: Icon(Icons.email)
                          ),
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: "Lozinka",
                            prefixIcon: Icon(Icons.password)
                          ),
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                          ),
                        onPressed: () async {
                          AuthProvider.username = _usernameController.text;
                          AuthProvider.password = _passwordController.text;
                          try{
                            var userProvider = UserProvider();
                            var user = await userProvider.login(AuthProvider.username, AuthProvider.password);
                            AuthProvider.id = user.id;
                            AuthProvider.firstName = user.firstName;
                            AuthProvider.lastName = user.lastName;
                            AuthProvider.userName = user.userName;
                            AuthProvider.picture = user.picture;
                            AuthProvider.email = user.email;
                            AuthProvider.phoneNumber = user.phoneNumber;
                            AuthProvider.orzanization = user.orzanization;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeamsListScreen()));
                          }on Exception catch(exception)
                          {
                            showDialog(
                              context: context, 
                              builder: (context) => AlertDialog(
                                title: Text("Greška prilikom prijave"), 
                                actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok"))], 
                                content: Text(exception.toString()),));
                          }
                        },
                         child: Text("Prijavi se"))
                      ],
                    )
                  )
                ],
              ),
              )
            ),
          ),
        ),)
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
