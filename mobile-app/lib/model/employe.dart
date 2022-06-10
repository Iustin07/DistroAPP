class Employee{
  final int userId;
  final String username;
  final String phoneNumber;
  final String address;
  final String userRole;
  final double salary;
  final String createdOn;
  final String driverLicense;
  Employee({
  required this.userId,
  required this.username,
  required this.phoneNumber,
  required this.address,
  required this.userRole,
  required this.salary,
  required this.createdOn,
  required this.driverLicense
  });
  static Employee mapJsonToEmployee(Map json){
    return Employee(
      userId: json["userId"],
       username: json["username"],
        phoneNumber:json["phoneNumber"],
         address: json["address"],
          userRole: json["userRole"],
           salary: json["salary"],
            createdOn: json["createdOn"],
             driverLicense: json["driverLicense"]);
  }
  String get getDriverLicense{
    return driverLicense;
  }
  static Map<String,dynamic> employeToJson(Employee employee){
    return {
    "userId":employee.userId,
    "username":employee.username,
    "phoneNumber":employee.phoneNumber,
    "address":employee.address,
    "userRole":employee.userRole,
    "salary":employee.salary,
    "createdOn":employee.createdOn,
    "driverLicense":employee.driverLicense
    };
  }
}
