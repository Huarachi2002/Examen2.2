import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subTitle,
      required this.link,
      required this.icon});
}

const appMenuConfig = <MenuItem>[
  MenuItem(
      title: 'Gestión de Vacunas',
      subTitle: '',
      link: '/gestion-vacuna',
      icon: Icons.alarm_add_outlined),
  MenuItem(
      title: 'Gestión de Usuario',
      subTitle: '',
      link: '/gestion-usuario',
      icon: Icons.supervised_user_circle_sharp),
];

const appMenuItems = <MenuItem>[
  // MenuItem(
  //   title: 'Alertas',
  //   subTitle: 'Sección Alertas y Notificaciones',
  //   link: '/alertas',
  //   icon: Icons.add_alert_sharp,
  // ),
];
