import 'package:equatable/equatable.dart';

class FileObject extends Equatable {
  final String filename;
  final String id;
  final String? md5;
  final int? size;
  final String? uploadDate;
  final String url;

  const FileObject({
    this.filename = '',
    this.id = '',
    this.md5,
    this.size,
    this.uploadDate,
    this.url = '',
  });

  const FileObject.initial(
    this.filename,
    String fileId,
    this.url,
  )   : id = fileId,
        md5 = null,
        size = null,
        uploadDate = null;

  FileObject.fromJson(Map<String, dynamic> json)
      : filename = json['filename'],
        id = json['id'],
        md5 = json['md5'],
        size = json['size'],
        uploadDate = json['uploadDate'],
        url = json['url'];

  Map<String, dynamic> toJson() => {
        'filename': filename,
        'id': id,
        'md5': md5,
        'size': size,
        'uploadDate': uploadDate,
        'url': url,
      };

  @override
  List<Object> get props => [
        filename,
        id,
        url,
      ];
}
