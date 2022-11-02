class FileSpinResponse {
  List<Files>? files;
  bool success=false;
  String? provider;

  FileSpinResponse({this.files, this.success=false, this.provider});

  FileSpinResponse.fromJson(Map<String, dynamic> json) {
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    success = json['success'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['provider'] = this.provider;
    return data;
  }
}

class Files {
  String? name;
  int? size;
  String? id;
  String? checksum;
  String? contentType;
  String? thumbnail;

  Files(
      {this.name,
        this.size,
        this.id,
        this.checksum,
        this.contentType,
        this.thumbnail});

  Files.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    size = json['size'];
    id = json['id'];
    checksum = json['checksum'];
    contentType = json['content_type'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['size'] = this.size;
    data['id'] = this.id;
    data['checksum'] = this.checksum;
    data['content_type'] = this.contentType;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
