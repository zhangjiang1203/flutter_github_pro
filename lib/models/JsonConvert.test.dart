  
import '../models/index.dart';
class ConvertTemplate<T> {
  T fromJson(Map<String, dynamic> json) {
    return _getFromJson<T>(runtimeType, this, json);
  }

  Map<String, dynamic> toJson() {
    return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
         case JokesData:
       return JokesData.fromJson(json) as T;
     case Newstopmodel:
       return Newstopmodel.fromJson(json) as T;
     case TodayInHistory:
       return TodayInHistory.fromJson(json) as T;
     case Repoitems:
       return Repoitems.fromJson(json) as T;
     case Repo:
       return Repo.fromJson(json) as T;
     case CacheConfig:
       return CacheConfig.fromJson(json) as T;
     case User:
       return User.fromJson(json) as T;
     case TodayOilPrice:
       return TodayOilPrice.fromJson(json) as T;
     case Profile:
       return Profile.fromJson(json) as T;
     case Allrepolist:
       return Allrepolist.fromJson(json) as T;

  }
    return data as T;
  }

  static _getToJson<T>(Type type,data) {
    switch (type) {
          case JokesData:
       return (data as JokesData).toJson();
     case Newstopmodel:
       return (data as Newstopmodel).toJson();
     case TodayInHistory:
       return (data as TodayInHistory).toJson();
     case Repoitems:
       return (data as Repoitems).toJson();
     case Repo:
       return (data as Repo).toJson();
     case CacheConfig:
       return (data as CacheConfig).toJson();
     case User:
       return (data as User).toJson();
     case TodayOilPrice:
       return (data as TodayOilPrice).toJson();
     case Profile:
       return (data as Profile).toJson();
     case Allrepolist:
       return (data as Allrepolist).toJson();

    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {
           case 'JokesData':
       return JokesData.fromJson(json);
     case 'Newstopmodel':
       return Newstopmodel.fromJson(json);
     case 'TodayInHistory':
       return TodayInHistory.fromJson(json);
     case 'Repoitems':
       return Repoitems.fromJson(json);
     case 'Repo':
       return Repo.fromJson(json);
     case 'CacheConfig':
       return CacheConfig.fromJson(json);
     case 'User':
       return User.fromJson(json);
     case 'TodayOilPrice':
       return TodayOilPrice.fromJson(json);
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
           case 'JokesData':
       return List<JokesData>();
     case 'Newstopmodel':
       return List<Newstopmodel>();
     case 'TodayInHistory':
       return List<TodayInHistory>();
     case 'Repoitems':
       return List<Repoitems>();
     case 'Repo':
       return List<Repo>();
     case 'CacheConfig':
       return List<CacheConfig>();
     case 'User':
       return List<User>();
     case 'TodayOilPrice':
       return List<TodayOilPrice>();
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
  