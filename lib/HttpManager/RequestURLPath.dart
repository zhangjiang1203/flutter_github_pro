/*
* RequestURLPath created by zj 
* on 2020/5/21 4:52 PM
* copyright on zhangjiang
*/


const String GithubHomeURL = "https://api.github.com/";
///获取认证信息,不支持邮箱登录
const String githubAuthirizations = GithubHomeURL + "authorizations";
///github 根据语言选择搜索仓库
const String getGitHubPub = GithubHomeURL + "search/repositories";






///新闻类请求地址
const String getNewsData = 'http://v.juhe.cn/toutiao/index?key=c7655cd96dd673d8de4b3f043d23f3ef';
///星座请求地址
const String getConstellationData = 'http://web.juhe.cn:8080/constellation/getAll?key=65619a9c277b25e33e2dce08e6a5b4ea';
///今日油价请求地址
const String getTodayOilData = 'http://apis.juhe.cn/gnyj/query?key=bca222a56dd58bc7853cc3ae5d3a8d25';
///成语词典请求地址
const String getIdiomsData = 'http://v.juhe.cn/chengyu/query?key=5571117ab0ceeeb6aca940a46a872c2b';
///笑话大全请求地址
const String getJokesData = 'http://v.juhe.cn/joke/content/list.php?key=8539283666d6e398a000003f09cddf53';
///历史上的今天请求地址
const String getTodayHistoryData = 'http://v.juhe.cn/todayOnhistory/queryEvent.php?key=aee9c3caa1c8efce1bc979ba78d71c1c';
///驾照试题请求地址
const String getCarTestData = 'http://v.juhe.cn/jztk/query?key=44ef9cde00a5b074c86bb72c9d8a824f';
///天气请求地址
const String getWeatherData = 'http://apis.juhe.cn/simpleWeather/query?key=b8670b40bf27e1e05a8a1344da011437';