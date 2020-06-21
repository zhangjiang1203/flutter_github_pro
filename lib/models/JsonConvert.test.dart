  
import '../models/index.dart';
Type typeOf<T>() => T;
class JsonConvert {
  static fromJson<T>(Map<String, dynamic> json) {
    return _getFromJson<T>(typeOf<T>(),T, json);
  }

  static Map<String, dynamic> toJson<T>() {
    return _getToJson<T>(typeOf<T>(), T);
  }

  static _getFromJson<T>(Type type, data, json) {
    var typeStr = type.toString();
    var instance = typeStr.split('<');
    if(instance.length > 1){
       typeStr = instance.first;
    }
    switch (typeStr) {
         case 'Playloadmodel':
       return Playloadmodel.fromJson(json) as T;
     case 'Eventcommits':
       return Eventcommits.fromJson(json) as T;
     case 'JokesData':
       return JokesData.fromJson(json) as T;
     case 'Newstopmodel':
       return Newstopmodel.fromJson(json) as T;
     case 'TodayInHistory':
       return TodayInHistory.fromJson(json) as T;
     case 'Repoitems':
       return Repoitems.fromJson(json) as T;
     case 'Eventactor':
       return Eventactor.fromJson(json) as T;
     case 'Repo':
       return Repo.fromJson(json) as T;
     case 'Trendrepolist':
       return Trendrepolist.fromJson(json) as T;
     case 'Trenddeveloperlist':
       return Trenddeveloperlist.fromJson(json) as T;
     case 'Pubevents':
       return Pubevents.fromJson(json) as T;
     case 'CacheConfig':
       return CacheConfig.fromJson(json) as T;
     case 'User':
       return User.fromJson(json) as T;
     case 'Alluserlist':
       return Alluserlist.fromJson(json) as T;
     case 'TodayOilPrice':
       return TodayOilPrice.fromJson(json) as T;
     case 'Organization':
       return Organization.fromJson(json) as T;
     case 'Buildercontribute':
       return Buildercontribute.fromJson(json) as T;
     case 'Profile':
       return Profile.fromJson(json) as T;
     case 'Allrepolist':
       return Allrepolist.fromJson(json) as T;
       case 'CommonUseModel':
        return CommonUseModel.fromJson(json) as T;

  }
    return data as T;
  }

  static _getToJson<T>(Type type,data) {
    switch (type) {
          case Playloadmodel:
       return (data as Playloadmodel).toJson();
     case Eventcommits:
       return (data as Eventcommits).toJson();
     case JokesData:
       return (data as JokesData).toJson();
     case Newstopmodel:
       return (data as Newstopmodel).toJson();
     case TodayInHistory:
       return (data as TodayInHistory).toJson();
     case Repoitems:
       return (data as Repoitems).toJson();
     case Eventactor:
       return (data as Eventactor).toJson();
     case Repo:
       return (data as Repo).toJson();
     case Trendrepolist:
       return (data as Trendrepolist).toJson();
     case Trenddeveloperlist:
       return (data as Trenddeveloperlist).toJson();
     case Pubevents:
       return (data as Pubevents).toJson();
     case CacheConfig:
       return (data as CacheConfig).toJson();
     case User:
       return (data as User).toJson();
     case Alluserlist:
       return (data as Alluserlist).toJson();
     case TodayOilPrice:
       return (data as TodayOilPrice).toJson();
     case Organization:
       return (data as Organization).toJson();
     case Buildercontribute:
       return (data as Buildercontribute).toJson();
     case Profile:
       return (data as Profile).toJson();
     case Allrepolist:
       return (data as Allrepolist).toJson();
      case CommonUseModel:
        return (data as CommonUseModel).toJson();

    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {
           case 'Playloadmodel':
       return Playloadmodel.fromJson(json);
     case 'Eventcommits':
       return Eventcommits.fromJson(json);
     case 'JokesData':
       return JokesData.fromJson(json);
     case 'Newstopmodel':
       return Newstopmodel.fromJson(json);
     case 'TodayInHistory':
       return TodayInHistory.fromJson(json);
     case 'Repoitems':
       return Repoitems.fromJson(json);
     case 'Eventactor':
       return Eventactor.fromJson(json);
     case 'Repo':
       return Repo.fromJson(json);
     case 'Trendrepolist':
       return Trendrepolist.fromJson(json);
     case 'Trenddeveloperlist':
       return Trenddeveloperlist.fromJson(json);
     case 'Pubevents':
       return Pubevents.fromJson(json);
     case 'CacheConfig':
       return CacheConfig.fromJson(json);
     case 'User':
       return User.fromJson(json);
     case 'Alluserlist':
       return Alluserlist.fromJson(json);
     case 'TodayOilPrice':
       return TodayOilPrice.fromJson(json);
     case 'Organization':
       return Organization.fromJson(json);
     case 'Buildercontribute':
       return Buildercontribute.fromJson(json);
     case 'Profile':
       return Profile.fromJson(json);
     case 'Allrepolist':
       return Allrepolist.fromJson(json);

    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {
           case 'Playloadmodel':
       return List<Playloadmodel>();
     case 'Eventcommits':
       return List<Eventcommits>();
     case 'JokesData':
       return List<JokesData>();
     case 'Newstopmodel':
       return List<Newstopmodel>();
     case 'TodayInHistory':
       return List<TodayInHistory>();
     case 'Repoitems':
       return List<Repoitems>();
     case 'Eventactor':
       return List<Eventactor>();
     case 'Repo':
       return List<Repo>();
     case 'Trendrepolist':
       return List<Trendrepolist>();
     case 'Trenddeveloperlist':
       return List<Trenddeveloperlist>();
     case 'Pubevents':
       return List<Pubevents>();
     case 'CacheConfig':
       return List<CacheConfig>();
     case 'User':
       return List<User>();
     case 'Alluserlist':
       return List<Alluserlist>();
     case 'TodayOilPrice':
       return List<TodayOilPrice>();
     case 'Organization':
       return List<Organization>();
     case 'Buildercontribute':
       return List<Buildercontribute>();
     case 'Profile':
       return List<Profile>();
     case 'Allrepolist':
       return List<Allrepolist>();

    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}
  