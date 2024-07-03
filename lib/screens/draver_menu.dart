import 'package:dte_app/route/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RouteProvider>(context);
    final menuItems = routeProvider.getMenuItems();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ...menuItems.map((item) {
            final subRoutes = item['subRoutes'] ?? [];
            if (subRoutes.isNotEmpty) {
              return ExpansionTile(
                title: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, item['path']);
                  },
                  child: Text(item['pageName'] ?? 'No Name'),
                ),
                children: subRoutes.map<Widget>((subItem) {
                  return Container(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: ListTile(
                      title: Text(subItem['pageName'] ?? 'No Name',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          )),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, subItem['path']);
                      },
                    ),
                  );
                }).toList(),
              );
            } else {
              return ListTile(
                title: Text(item['pageName'] ?? 'No Name'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, item['path']);
                },
              );
            }
          }).toList(),
        ],
      ),
    );
  }
}
