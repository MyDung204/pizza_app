class MyUserEntity {
  String userId;
  String email;
  // Đã xóa biến password ở đây
  String name;
  bool hasActiveCart;

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
  });

  // Đã sửa 'toDocumnet' thành 'toDocument'
  Map<String, Object?> toDocument(){
    return {
      'userId': userId,
      'email': email,
      'name' : name,
      'hasActiveCart': hasActiveCart,
    };
  }

  // Đã xóa dấu cách, sửa thành 'fromDocument'
  static MyUserEntity fromDocument(Map<String, dynamic> doc){
    return MyUserEntity(
      userId: doc['userId'],
      email: doc['email'],
      name: doc['name'],
      hasActiveCart: doc['hasActiveCart'],
    );
  }
}