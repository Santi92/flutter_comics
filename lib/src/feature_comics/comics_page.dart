import 'package:comicbook/src/feature_comics/comics_bloc.dart';
import 'package:comicbook/src/models/comic_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ComicsPage extends StatefulWidget {
  @override
  _ComicsPageState createState() => _ComicsPageState();
}

class _ComicsPageState extends State<ComicsPage> {
  ComicsBloc comicsBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    comicsBloc = Provider.of<ComicsBloc>(context);
    comicsBloc.loadComics();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage('assets/images/logo_title.png'),
          height: 80,
          width: 100,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.list ),
            onPressed: ()=> comicsBloc.activateGrid(false),
          ),
          IconButton(
            icon: Icon( Icons.grid_on ),
            onPressed: ()=> comicsBloc.activateGrid(true),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(228, 228, 229, 1),
          child: _comicsList(comicsBloc),
        ),
      ),
    );
  }

  Widget _comicsList(ComicsBloc comicBloc){

    return StreamBuilder(
      stream: comicBloc.comicsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Result>> snapshot){

        if ( snapshot.hasData ) {

          final comics = snapshot.data;

          return comicBloc.isGridViewActivated ? _gridComic(comics):_listComic(comics);

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _listComic(List<Result> comics){
    return ListView.builder(

      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      itemCount: comics.length,
      itemBuilder: (context, i) => _buildComic(comics[i], false),
    );
  }

  Widget _gridComic(List<Result> comics){

    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return GridView.builder(

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 2
      ),

      itemBuilder: (context, index) {
        return _buildComic(comics[index], true);
      },
    );

  }

  Widget _buildComic(Result result,bool isRow){


    return GestureDetector(
      child: Card(
        child: Container(
          height: 300,
          padding: EdgeInsets.all(10),
          child: (isRow) ? Column(
            children: buildInfo(result),
          ) : Row(
            children: buildInfo(result),
          )
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'comic_detail', arguments: result);
      },
    );
  }

  List<Widget> buildInfo(Result result){
    return  <Widget> [
      Expanded(
        flex: 2,
        child: _loadImage(result),
      ),
      Expanded(
        child: _textDescription(result),
      ),
    ];
  }

  Widget _textDescription(Result result){
    return ListTile(
      title: Text(
        '${ result.name } # ${ result.issueNumber }',
        textAlign: TextAlign.center,
      ),
      subtitle: Text(
          result.dateFormat(),
          textAlign: TextAlign.center
      ),
      onTap: () => print(result.name),
    );
  }

  Widget _loadImage(Result result){

    if(result.image.screenUrl == null){
      return Image(image: AssetImage('assets/no-image.png'));
    }else{
      return Hero(
        tag: result.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            image: NetworkImage( result.image.originalUrl),
            placeholder: AssetImage('assets/images/giphy.gif'),
            height: 250.0,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }


}
