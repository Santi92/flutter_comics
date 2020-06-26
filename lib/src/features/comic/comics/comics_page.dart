import 'package:async_redux/async_redux.dart';
import 'package:comicbook/src/features/comic/comic_detail/comic_detail_page.dart';
import 'package:comicbook/src/features/comic/comics/comics_view_model.dart';
import 'package:comicbook/src/models/comic_response.dart';
import 'package:comicbook/src/redux/app_state.dart';
import 'package:flutter/material.dart';

class ComicsPagePageConnector extends StatelessWidget {
  ComicsPagePageConnector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ComicsViewModel>(
      model: ComicsViewModel(),

      builder: (BuildContext context, ComicsViewModel vm) {
          print("ComicsViewModel ${vm.isLoading}");
        return ComicsPage(
            comics: vm.comics,
            isLoading: vm.isLoading,
            onGet: vm.onGetComics,
        );
      } ,
    );
  }
}

class ComicsPage extends StatefulWidget {

  final List<Result> comics;
  bool isLoading;
  VoidCallback onGet;

  ComicsPage({
    this.comics,
    this.isLoading,
    this.onGet
  });

  @override
  _ComicsPageState createState() => _ComicsPageState();
}

class _ComicsPageState extends State<ComicsPage> {

  bool _isGridViewStyle;


  @override
  void initState() {
    _isGridViewStyle = true;
     widget.onGet();
    super.initState();
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
            onPressed: () {
              setState(() {
                _isGridViewStyle = false;
              });
            },
          ),
          IconButton(
            icon: Icon( Icons.grid_on ),
            onPressed: (){
              setState(() {
                _isGridViewStyle = true;
              });
            } ,
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(228, 228, 229, 1),
          child: _comicsList(),
        ),
      ),
    );
  }

  Widget _comicsList(){
    return  widget.comics.isEmpty ?
    Center( child: CircularProgressIndicator()) : (
        _isGridViewStyle ? _gridComic(widget.comics):_listComic(widget.comics)
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ComicDetailPage(result);
          }),
        );

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
