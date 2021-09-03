// @dart=2.9
import 'dart:io';

/*
  ! Masih terdapat kekurangan jika gagal dalam mentranfer seperti rekening yang salah

  * User Guide:
  * Silahkan Login bebas mengunakan account pertama atau kedua sesuai dengan List Map
  * Terdapat menu untuk mengecek saldo, transfer, tarik tunai, dan setor tunai
  * Mohon maaf jika masih ada kekuraangan atau bug-bug tertentu dikarenakan masih awan dengan bahasa pemograman ini.
 */

main(){
  //Input user pengguna bank
  var userLists = <Map>[];
  userLists.add({ 'no_rek' : 123456, 'username' : 'Renaldo', 'pin' : 181245, 'saldo' : 12000000 });
  userLists.add({ 'no_rek' : 456789, 'username' : 'Septhia', 'pin' : 321200, 'saldo' : 5000000 });

  //Starting point pengunaan bank
  while(true){
    stdout.write("Welcome to Bank Gits.id\n");
    stdout.write("========================\n");
    stdout.write("Input your Username: \n");
    var active_user = stdin.readLineSync();
    stdout.write("========================\n");
    stdout.write("Input your PIN: \n");
    var active_pin = int.tryParse(stdin.readLineSync() ?? "");
    if (active_pin == ""){
      print("Please input correct PIN!");
    } else {
      for (var index in userLists){
        if(index['username'] == active_user){
          if(index['pin'] == active_pin){
            print("Succesfully Login!\n");
            //Menu 
            innerloop: 
            while(true){  
              print("========================");
              print("===== Pilihan Menu =====");
              print("[1] Cek Saldo");
              print("[2] Transfer");
              print("[3] Tarik Tunai");
              print("[4] Setor Tunai");
              print("[0] Exit");
              print("========================");
              stdout.write("Pilih menu: ");
              var choice = (stdin.readLineSync());
              switch (choice){
                case '1':
                  print(index['saldo']);
                  break;
                case '2':
                  stdout.write("No rekening yang dituju: ");
                  int rek = int.parse(stdin.readLineSync());
                  stdout.write("Jumlah nominal: ");
                  int total = int.parse(stdin.readLineSync());
                  for (var index in userLists){
                    if(index['no_rek'] == rek){
                      String nama_tujuan = index['username']; 
                      int result = index['saldo'] + total;
                      index.update('saldo', (value) => result);
                      print("Sucessfully");
                    }
                  }
                  int result = index['saldo'] - total;
                  index.update('saldo', (value) => result);
                  break;
                case '3':
                  stdout.write("Total yang ingin ditarik: ");
                  int total = int.parse(stdin.readLineSync());
                  int result = index['saldo'] - total;
                  index.update('saldo', (value) => result);
                  print("Total Saldo saat ini:");
                  print(index['saldo']);
                  break;
                case '4':
                  stdout.write("Total yang ingin disetorkan: ");
                  int total = int.parse(stdin.readLineSync());
                  int result = index['saldo'] + total;
                  index.update('saldo', (value) => result);
                  print("Total Saldo saat ini:");
                  print(index['saldo']);
                  break;
                case '0':
                  break innerloop;
                default:
                  print("Please input correct number!");
              }
              
            }
            
          } else {
            print("PIN Incorrect!\n");
            break;
          }
        }
      }
    }
    print("---Terminated---");
  }
  
}