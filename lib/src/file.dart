part of body_parser;

/// Represents a file uploaded to the server.
class File {
  /// The MIME type of the uploaded file.
  String _mimeType;

  /// The name of the file field from the request.
  String _name;

  /// The filename of the file.
  String _filename;

  /// The bytes that make up this file.
  List<int> _data;

  File(
      {String mimeType,
        String name,
        String filename,
        List<int> data = const []})
      : _mimeType = mimeType,
        _name = name,
        _filename = filename,
        _data = data;

  @override
  String toString() =>
      'filename:${this._filename} name:${this._name} mimeType:${this._mimeType} size:${this._data.length}';
}