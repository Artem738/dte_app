import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:dte_app/providers/route_provider.dart';

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
                    context.go(item['path']);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['pageName'] ?? 'No Name'),
                    ],
                  ),
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
                        context.go('${item['path']}/${subItem['path']}');
                        Navigator.pop(context);
                      },
                    ),
                  );
                }).toList(),
              );
            } else {
              return ListTile(
                title: Text(item['pageName'] ?? 'No Name'),
                onTap: () {
                  context.go(item['path']);
                  Navigator.pop(context);
                },
              );
            }
          }).toList(),
        ],
      ),
    );
  }
}
