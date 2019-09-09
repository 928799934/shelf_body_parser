part of body_parser;

class Buffer {
  final List<int> _store;
  Buffer(List<int> store) : _store = store;
  String get UTF8 => utf8.decode(this._store);

  @override
  String toString() => this._store.toString();
}
