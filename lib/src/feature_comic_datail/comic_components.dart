
class ComicComponents{

    String title;
    List<Component> components;

    ComicComponents(this.title, this.components);

}

class Component{

  String apiUrl;
  String imgUrl;
  String name;

  Component(this.apiUrl, this.name, this.imgUrl);


}