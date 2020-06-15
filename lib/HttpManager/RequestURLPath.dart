/*
* RequestURLPath created by zj 
* on 2020/5/21 4:52 PM
* copyright on zhangjiang
*/


//注册自己的OAuth Application，得到clientId和clientSecret，进行替换
//注册地址： https://github.com/settings/applications/new


class RequestURL {

  static String GithubClientId = 'b6bffcdce925652cd1ea';
  static String GithubClientSecret ='1e27a5c41f59e466b566305a1d197d31fbed2661';

  static String GithubHomeURL = "https://api.github.com/";
  ///获取认证信息,不支持邮箱登录
  static String githubAuthirizations = GithubHomeURL + "authorizations";
  ///github 根据语言选择搜索仓库
  static String getGitHubPub = GithubHomeURL + "search/repositories";

  //登录获取用户信息
  static getUser(String userName){
    return GithubHomeURL + "users/$userName";
  }

  //获取用户项目列表
  static getRepos(String userName) {
    return GithubHomeURL + "users/$userName/repos";
  }


  ///新闻类请求地址
  static String getNewsData = 'http://v.juhe.cn/toutiao/index?key=c7655cd96dd673d8de4b3f043d23f3ef';
  ///星座请求地址
  static String getConstellationData = 'http://web.juhe.cn:8080/constellation/getAll?key=65619a9c277b25e33e2dce08e6a5b4ea';
  ///今日油价请求地址
  static String getTodayOilData = 'http://apis.juhe.cn/gnyj/query?key=bca222a56dd58bc7853cc3ae5d3a8d25';
  ///成语词典请求地址
  static String getIdiomsData = 'http://v.juhe.cn/chengyu/query?key=5571117ab0ceeeb6aca940a46a872c2b';
  ///笑话大全请求地址
  static String getJokesData = 'http://v.juhe.cn/joke/content/list.php?key=8539283666d6e398a000003f09cddf53';
  ///历史上的今天请求地址
  static String getTodayHistoryData = 'http://v.juhe.cn/todayOnhistory/queryEvent.php?key=aee9c3caa1c8efce1bc979ba78d71c1c';
  ///驾照试题请求地址
  static String getCarTestData = 'http://v.juhe.cn/jztk/query?key=44ef9cde00a5b074c86bb72c9d8a824f';
  ///天气请求地址
  static String getWeatherData = 'http://apis.juhe.cn/simpleWeather/query?key=b8670b40bf27e1e05a8a1344da011437';
}

