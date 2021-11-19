import 'package:flutter/material.dart';
import 'package:nexuswellness/assets/constants.dart';

Widget mainDrawer(name, email, thumbanil, context) {
  return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
      child: Drawer(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1594616838951-c155f8d978a0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              flex: 3,
              child: ListView(children: [
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.black,
                    ),
                  ),
                  title: Text('Account'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/new/feeds');
                  },
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.article_rounded,
                      color: Colors.black,
                    ),
                  ),
                  title: Text('Nexus Findings'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/events');
                  },
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.article_rounded,
                      color: Colors.black,
                    ),
                  ),
                  title: Text('Events'),
                ),

                // ListTile(
                //   leading: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Icon(
                //       Icons.supervised_user_circle_outlined,
                //       color: Colors.black,
                //     ),
                //   ),
                //   title: Text('Share With Friends'),
                // ),
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.info,
                      color: Colors.black,
                    ),
                  ),
                  title: Text('Info'),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(kgreenColor), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/plans');
                    },
                    child: Text('Upgrade Plan'),
                  ),
                ),
              ]),
            )
          ],
        ),
      ));
}
