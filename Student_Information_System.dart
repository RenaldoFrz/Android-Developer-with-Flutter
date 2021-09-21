import 'dart:io';

const int costOfCourse = 1250000;

void main() => home();

class Student{
  int studentID;
  String firstname;
  String lastname;
  String course;
  int batch; 
  int balance;
  int outstanding;

  Student({
    required this.studentID,
    required this.firstname,
    required this.lastname,
    required this.batch,
    required this.course,
    this.balance = 0,
    this.outstanding = 0,
  });
}

List <Student> students = <Student> [
  Student(studentID: 20190001, firstname: 'Mack n', lastname: 'Santos', batch: 2019, course: 'Math, Programming Concept', balance: 2000000, outstanding: 2500000),
];

void home(){
  print('Welcome to the Student Information System');
  print('(1) Login');
  print('(2) Register new student');
  print('(0) Logout');
  stdout.write('Choose your action: ');
  var n = int.tryParse(stdin.readLineSync() ?? '');
  switch(n){
    case 1:
      login();
      break;
    case 2:
      registerStudent();
      break;
    case 0:
      exit(0);
    default:
      home();
  }
}

Student? activeStudent;

void login(){
  stdout.write('Input your student id: ');
  var id = int.tryParse(stdin.readLineSync() ?? '');
  students.forEach((Student student) {
    if (student.studentID == id) activeStudent = student;
  });
  if (activeStudent != null) {
    menu();
  } else {
    print('------------- Login Failed ------------');
    home();
  }
}

void registerStudent(){
  stdout.write('input your first name: ');
  var fname = (stdin.readLineSync());
  stdout.write('input your last name: ');
  var lname = (stdin.readLineSync());
  stdout.write('input your batch: ');
  var year = int.tryParse(stdin.readLineSync() ?? '');
  var id;
  students.forEach((Student student) { 
    student.batch == year ? id = student.studentID + 1 : id = int.tryParse(year.toString()+'0001');
  });
  var courses;
  int outstanding = 0;
  while(true){
    stdout.write('Enter course to enroll (Q to quit): ');
    String? course = stdin.readLineSync();
    if (course != "Q"){
      courses == null ? courses = '$course' : courses = '$courses, $course';
      outstanding = outstanding + costOfCourse;
    } else { break; }
  }
  students.add(Student(studentID: id, firstname: fname?? "", lastname: lname?? "", batch: year?? 0, course: courses, outstanding: outstanding));
  print('------- Successfully Registered -------');
  print('---------------------------------------');
  print('Your ID: $id');
  print('---------------------------------------');
  print('*Keep your ID to login into the system');
  home();
}

void menu(){
  print('Welcome ${activeStudent?.firstname} ${activeStudent?.lastname}');
  print('(1) Student Information');
  print('(2) Payment Information');
  print('(3) Deposit Balance');
  print('(4) Tuition Payment');
  print('(0) Logout');
  stdout.write('Choose your action: ');
  var n = int.tryParse(stdin.readLineSync() ?? '');
  switch(n){
    case 1:
      studentInformation();
      break;
    case 2:
      paymentInformation();
      break;
    case 3:
      depositeBalance();
      break;
    case 4: 
      tuitionPayment();
      break;
    case 0:
      activeStudent = null;
      home();
      break;
    default:
      menu();
  }
  menu();
}

void studentInformation(){
  print('---------------------------------------');
  print('Name: ${activeStudent?.firstname} ${activeStudent?.lastname}');
  print('Student ID: ${activeStudent?.studentID}');
  print('Batch: ${activeStudent?.batch}');
  print('Course Enrolled: ${activeStudent?.course}');
  print('---------------------------------------');
}

void paymentInformation(){
  print('---------------------------------------');
  print('Student ID: ${activeStudent?.studentID}');
  print('Current Balance: Rp.${activeStudent?.balance}');
  print('Current Outstanding Payment: Rp.${activeStudent?.outstanding}');
  print('---------------------------------------');
  var diff = activeStudent!.balance - activeStudent!.outstanding;
  if(diff < 0){
    stdout.write('Do you want to deposit balance? (y/n): ');
    var c = stdin.readLineSync();
    (c == 'y' || c == 'Y') ? depositeBalance() : menu();
  } else {
    if (activeStudent!.outstanding > 0){
      stdout.write('Do you want to paying the outstanding balance? (y/n): ');
      var c = stdin.readLineSync();
      (c == 'y' || c == 'Y') ? tuitionPayment() : menu();
    }
  }
}

void depositeBalance(){
  print('---------------------------------------');
  stdout.write('Enter the nominal : Rp.');
  var amount = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
  students.forEach((Student student) {
    if (student.studentID == activeStudent?.studentID) {
      student.balance += amount;
    }
  });
  print('---------------------------------------');
}

void tuitionPayment(){
  var diff = activeStudent!.balance - activeStudent!.outstanding;
  if(diff < 0){
    stdout.write('Do you want to deposit balance? (y/n): ');
    var c = stdin.readLineSync();
    (c == 'y' || c == 'Y') ? depositeBalance() : menu();
  } else {
    stdout.write('Do you sure want to paying the outstanding balance? (y/n): ');
    var c = stdin.readLineSync();
    if(c == 'Y' || c == 'y'){
      students.forEach((Student student) {
        if (student.studentID == activeStudent?.studentID) {
          student.balance -= student.outstanding;
          student.outstanding = 0;
        }
      });
    }
    print('------- Successfully -------');
  }
}