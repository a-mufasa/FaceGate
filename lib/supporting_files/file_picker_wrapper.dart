class FilePickerWrapperResult {
  late int code; // 1 means success result, 0 means failed or error result
}

class FilePickerWrapperSuccessResult extends FilePickerWrapperResult {
  FilePickerWrapperSuccessResult(
      {this.filePath, this.fileName, required int code}) {
    this.code = code;
  }
  String? filePath;
  String? fileName;
}

class FilePickerWrapperFailedResult extends FilePickerWrapperResult {
  FilePickerWrapperFailedResult(
      {required this.errorMessage, required int code}) {
    this.code = code;
  }
  String errorMessage;
}
