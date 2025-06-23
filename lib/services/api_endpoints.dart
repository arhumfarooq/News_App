class ApiEndpoints {

static const String baseUrl= "https://newsapi.org/v2";
static const String apiKey = "0fe44c016da44d21b73a3b0611bef81b";

static String headlinesBySource(String channel) => "$baseUrl/top-headlines?sources=$channel&apikey=$apiKey";
static String headlinesByCategory(String category)=>"$baseUrl/everything?q=$category&apikey=$apiKey";

}