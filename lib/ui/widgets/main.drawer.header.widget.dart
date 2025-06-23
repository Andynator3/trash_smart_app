import 'package:flutter/material.dart';

class MainDrawerHeader extends StatelessWidget {
  const MainDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    DrawerHeader(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Theme.of(context).primaryColor]
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("images/profile.jpg"),
          ),
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.settings)
          )
        ],
      ),
    );
  }
}
