import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'menu_item_modal.dart';

class MenuItems {
  static const List<MenuItem> itemList = [itemAboutUs, itemGithubLink];

  static const itemAboutUs =
      MenuItem(text: "About Us", icon: FontAwesomeIcons.infoCircle);

  static const itemGithubLink =
      MenuItem(text: "Github", icon: FontAwesomeIcons.github);
}
