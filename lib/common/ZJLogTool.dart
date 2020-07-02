/*
* ZJLogTool created by zj 
* on 2020/5/15 2:19 PM
* copyright on zhangjiang
*/

//是否是release
bool get isRelease => bool.fromEnvironment('dart.vm.product');

void zjPrint(Object message, StackTrace current) {
  ///release 模式下不打印
  if(!isRelease){
    ZJCustomTrace programInfo = ZJCustomTrace(current);
    print("所在文件: ${programInfo.fileName}, 所在行: ${programInfo.lineNumber}, 打印信息: $message");
  }
}

class ZJCustomTrace {
  final StackTrace _trace;

  String fileName;
  int lineNumber;
  int columnNumber;

  ZJCustomTrace(this._trace) {
    _parseTrace();
  }

  void _parseTrace() {
    var traceString = this._trace.toString().split("\n")[0];
    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    var listOfInfos = fileInfo.split(":");
    this.fileName = listOfInfos[0];
    this.lineNumber = int.parse(listOfInfos[1]);
    var columnStr = listOfInfos[2];
    columnStr = columnStr.replaceFirst(")", "");
    this.columnNumber = int.parse(columnStr);
  }
}