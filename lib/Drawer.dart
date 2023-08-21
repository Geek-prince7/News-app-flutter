import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PersistDrawer extends StatefulWidget {
  const PersistDrawer({Key? key}) : super(key: key);

  @override
  State<PersistDrawer> createState() => _PersistDrawerState();
}

class _PersistDrawerState extends State<PersistDrawer> {
  String name = "";
  String userId = "";
  bool login=false;
  var mResponse;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> isLoggedIn() async{
    final prefs=await SharedPreferences.getInstance();
    String? email=prefs.getString("email");
    if(email!=null){
      setState(() {
        login=true;
      });

    }

  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name')!;
      userId = prefs.getString('userId')!;
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('id');
    await prefs.remove('email');
    await prefs.remove('jwt');
    // await prefs.remove('admin');
    // await prefs.remove('metadata');
    Navigator.pushNamedAndRemoveUntil<dynamic>(
        context, 'home', (route) => false);
  }





  @override
  Widget build(BuildContext context) {
    final isDarkTheme = true;

    return Drawer(
      // backgroundColor: isDarkTheme ? Colors.black87 : Colors.grey.shade800,
      child: Column(
        children: [
          login?UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: isDarkTheme ? Colors.black : Colors.grey.shade200),
            currentAccountPicture: const CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage('graphics/profile.png'),
              backgroundColor: Colors.transparent,
            ),

            accountName: Text(
              name,
              style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            ),
            accountEmail: Text(
              userId,
              style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            ),
          ):Container(),
          login?Container():SizedBox(height: 25,),
          const SizedBox(height: 25),
          ListTile(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'home', (route) => false);
            },
            leading: Icon(Icons.dashboard, color: Colors.blue),
            trailing: Icon(Icons.arrow_circle_right_outlined),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Divider(color: Colors.black),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'home');
            },
            leading: Icon(Icons.person, color: Colors.blue),
            trailing: Icon(Icons.arrow_circle_right_outlined),
            title: Text(
              'My Profile',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Divider(color: Colors.black),
          login?ListTile(
            onTap: () {
              logout();
            },
            leading: Icon(Icons.power_settings_new, color: Colors.blue),
            trailing: Icon(Icons.arrow_circle_right_outlined),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
          ):
          ListTile(
            onTap: () {
              //login page
              Navigator.of(context).pushNamed("login");
            },
            leading: Icon(Icons.power_settings_new, color: Colors.blue),
            trailing: Icon(Icons.arrow_circle_right_outlined),
            title: Text(
              'Login',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Divider(color: Colors.black),
        ],
      ),
    );
  }
}
