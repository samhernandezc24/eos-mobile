import 'dart:collection';
import 'dart:io';

class ImageUploadQueue {
  final Queue<File> _queue = Queue<File>();

  void enqueue(File file) {
    _queue.addLast(file);
  }

  File? dequeue() {
    if (_queue.isNotEmpty) {
      return _queue.removeFirst();
    }
    return null;
  }

  bool get isEmpty => _queue.isEmpty;
}
