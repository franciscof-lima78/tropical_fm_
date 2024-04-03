import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(190, 21, 64, 78),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Color.fromARGB(190, 21, 64, 78),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/logo_menu_v5.png'))),
            child: Text(
              '',
              style: TextStyle(
                  color: Color.fromARGB(190, 21, 64, 78), fontSize: 25),
            ),
          ),
          ListTile(
            leading:
                const Icon(Icons.camera, color: Color.fromARGB(232, 21, 228, 31)),
            title: const Text(
              'Instagram',
              style: TextStyle(
                  color: Color.fromARGB(232, 21, 228, 31), fontSize: 18),
            ),
            onTap: () => _launchURL('https://www.instagram.com/tropicalfm.pt'),
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: Color.fromARGB(232, 21, 228, 31)),
            title: const Text(
              'Envie sua mensagem ou peça uma música',
              style: TextStyle(
                  color: Color.fromARGB(232, 21, 228, 31), fontSize: 18),
            ),
            onTap: () => _launchURL('https://wa.me/351216019492'),
          ),
          ListTile(
            leading: const Icon(Icons.web, color: Color.fromARGB(232, 21, 228, 31)),
            title: const Text(
              'Site',
              style: TextStyle(
                  color: Color.fromARGB(232, 21, 228, 31), fontSize: 18),
            ),
            onTap: () => _launchURL('http://tropicalfm.pt'),
          ),
          /*ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),*/
        ],
      ),
    );
  }

  _launchURL(String wUrl) async {
    const url = 'https://flutter.io';
    if (await canLaunchUrlString(wUrl)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $wUrl';
    }
  }
}
