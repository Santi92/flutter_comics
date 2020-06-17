
import 'package:comicbook/src/feature_comic_datail/comic_components.dart';
import 'package:comicbook/src/feature_comic_datail/comic_detail_bloc.dart';
import 'package:comicbook/src/models/comic_response.dart';
import 'package:comicbook/src/provider.dart';
import 'package:flutter/material.dart';

class ComicDetailPage extends StatelessWidget {

  ComicDetailBloc comicBlocGlobal;

  @override
  Widget build(BuildContext context) {

    final Result result = ModalRoute.of(context).settings.arguments;
    final comicBloc = Provider.gtComicBloc(context);
    comicBlocGlobal = comicBloc;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            _comicApp(result),
            SliverList(
              delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 10),
                    _posterComic(context,result),
                    _components(result.id, comicBloc),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _comicApp(Result result){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.green,
      expandedHeight: 200.0,
      floating: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          result.name,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.0
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(result.image.screenLargeUrl),
          placeholder: AssetImage('assets/images/loading.gif'),
          fadeInDuration: Duration(milliseconds: 250),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _posterComic(BuildContext context ,Result result){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: result.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(result.image.originalUrl),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text(result.name,
                    style: Theme.of(context).textTheme.subtitle1,
                    ),

                Text(result.dateFormat() == null ? "" : result.dateFormat(),
                    style: Theme.of(context).textTheme.subtitle2,
                    ),

              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _components(int id, ComicDetailBloc comicDetailBloc){
    comicDetailBloc.loadComic(id);
    return StreamBuilder(
      stream: comicDetailBloc.comicsStream,
      builder: (context, snapshot) {
        if ( snapshot.hasData ) {

          final components = snapshot.data;

          return Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
                children: _listTitle(components)
            ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }

  List<Widget> _listTitle(List<ComicComponents> components){
    List<Widget> widgets = [];
    components.forEach((element) {
      widgets.add(_buildComic(element));
    });

    return widgets;
  }


  Widget _buildComic(ComicComponents comicComponents){
    return Container(
      child: Column(
        children: <Widget>[

          Container(
            width: double.infinity,
            child: Text(
              comicComponents.title,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 22
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Divider(),
          
          _grid(comicComponents.components),
        ],
      ),
    );
  }

  Widget _grid(List<Component> components){

    if(components.isEmpty){
      return Container(height: 20,);
    }

    return GridView.count(
      physics: new NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: true,
      padding: const EdgeInsets.all(15.0),
      crossAxisSpacing: 2.0,
      crossAxisCount: 2,
      children: _listComponents(components),
    );
  }
  
  List<Widget> _listComponents(List<Component> components){
    List<Widget> items = [];

    components.forEach((element) {
      items.add(_buildItem(element));
    });

    return items;
  }

  Widget _buildItem(Component component){
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child:_buildImageItem(component.apiUrl),
          ),
          Expanded(
            child:  Container(
              padding: EdgeInsets.only(
                  left: 5,
                  right: 5
              ),
              child: Text(
                component.name,
                style: TextStyle(
                    color: Colors.lightGreen
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget _buildImageItem(String url){

    final comicBlocTemp = ComicDetailBloc();
    comicBlocTemp.getPictureUrl(url);

    return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: StreamBuilder(
          stream: comicBlocTemp?.urlStream,
          builder: (context, snapshot) {

            if ( snapshot.hasData ) {

              final String url = snapshot.data;

              return FadeInImage(
                image: NetworkImage(url),
                placeholder: AssetImage('assets/images/giphy.gif'),
                height: 80.0,
                width: 50.0,
                fit: BoxFit.fill,
              );

            } else {
              return Image(image: AssetImage('assets/images/giphy.gif'));
            }

          },
        ));
  }

}
