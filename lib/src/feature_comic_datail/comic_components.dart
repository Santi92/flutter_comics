
import 'package:comicbook/src/business/comic_state.dart';

class ComicComponents{

    String title;
    List<Component> components;

    ComicComponents(this.title, this.components);

}

class Component{

  String apiUrl;
  String name;

  Component(this.apiUrl, this.name);


}