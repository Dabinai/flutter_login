class Repo {
  int id;
  String name;
  String fullName;
  String owner;
  String parent;
  bool private;
  String description;
  bool fork;
  String language;
  int forksCount;
  int stargazersCount;
  int size;
  String defaultBranch;
  int openIssuesCount;
  String pushedAt;
  String createdAt;
  String updatedAt;
  int subscribersCount;
  License license;

  Repo(
      {this.id,
        this.name,
        this.fullName,
        this.owner,
        this.parent,
        this.private,
        this.description,
        this.fork,
        this.language,
        this.forksCount,
        this.stargazersCount,
        this.size,
        this.defaultBranch,
        this.openIssuesCount,
        this.pushedAt,
        this.createdAt,
        this.updatedAt,
        this.subscribersCount,
        this.license});

  Repo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fullName = json['full_name'];
    owner = json['owner'];
    parent = json['parent'];
    private = json['private'];
    description = json['description'];
    fork = json['fork'];
    language = json['language'];
    forksCount = json['forks_count'];
    stargazersCount = json['stargazers_count'];
    size = json['size'];
    defaultBranch = json['default_branch'];
    openIssuesCount = json['open_issues_count'];
    pushedAt = json['pushed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subscribersCount = json['subscribers_count'];
    license =
    json['license'] != null ? new License.fromJson(json['license']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['full_name'] = this.fullName;
    data['owner'] = this.owner;
    data['parent'] = this.parent;
    data['private'] = this.private;
    data['description'] = this.description;
    data['fork'] = this.fork;
    data['language'] = this.language;
    data['forks_count'] = this.forksCount;
    data['stargazers_count'] = this.stargazersCount;
    data['size'] = this.size;
    data['default_branch'] = this.defaultBranch;
    data['open_issues_count'] = this.openIssuesCount;
    data['pushed_at'] = this.pushedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['subscribers_count'] = this.subscribersCount;
    if (this.license != null) {
      data['license'] = this.license.toJson();
    }
    return data;
  }
}

class License {
  String key;
  String name;
  String spdxId;
  String url;
  String nodeId;

  License({this.key, this.name, this.spdxId, this.url, this.nodeId});

  License.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    spdxId = json['spdx_id'];
    url = json['url'];
    nodeId = json['node_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['spdx_id'] = this.spdxId;
    data['url'] = this.url;
    data['node_id'] = this.nodeId;
    return data;
  }
}
