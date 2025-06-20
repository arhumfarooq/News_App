import 'package:news_app/model/categories_news_model.dart';
import 'package:news_app/model/news_channels_headlines_model.dart';
import 'package:news_app/repositry/news_repositry.dart';

class NewsViewModel {


final _rep= NewsRepositry();

Future<NewsChannelsHeadlinesModel> fetchNewsChaneelHeadlinesApi(String  channel)async{
  final response =  await _rep.fetchNewsChaneelHeadlinesApi(channel);
return response;
}
Future<CategoriesNewsModel> fetchcategoriesnewsapi(String  channel)async{
  final response =  await _rep.fetchcategoriesnewsapi(channel);
return response;
}


}