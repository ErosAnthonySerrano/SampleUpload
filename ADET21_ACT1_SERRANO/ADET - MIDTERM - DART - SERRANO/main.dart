
import 'dart:io';
import 'dart:convert';
void main(){
  do {
    print("-------------------------------");
    print("\t\tATM PROGRAM");
    print("-------------------------------");
    print("\n-------------------------------");
    print("\tWELCOME DEAR CLIENT!!!");
    print("-------------------------------");
    print("Please Enter your 8 Digit Pin:");
    String? pinNum = stdin.readLineSync();
    int? pinCount = pinNum?.length;

    if(isNumeric(pinNum!)==false || pinCount!=8){
      print("Invalid Input!!");
      print("Press [1] to try again, [0] to exit:");
      String? choice = stdin.readLineSync();


        while (choice != '0' && choice != '1') {
          print("Invalid Input!! Please Press [1] to try again, [0] to exit:");
          choice = stdin.readLineSync();
        }
        if (choice=='0'){
          break;
        }

    }
    else{
      File clientFile = File('ClientAccount.txt');
      bool r = false;
        String myFile = clientFile.readAsStringSync();
        var temp = LineSplitter.split(myFile).toList();
        for(int i=0; i<temp.length; i++){
          var arr = temp[i].split('|');
          if(pinNum == arr[0]){
            do {
              print("Account Found!!");
              Transaction.displayTransaction();
              String? ch = stdin.readLineSync();

              while (ch != '0' && ch != '1' && ch != '2') {
                print("Invalid Input!!");
                Transaction.displayTransaction();
                ch = stdin.readLineSync();
              }
              if (ch == '0') {
                print("Withdraw");
                Transaction.withdraw();
                String? amount = stdin.readLineSync();
                while (isNumeric(amount!) == false) {
                  print("Invalid Input!!");
                  Transaction.withdraw();
                  amount = stdin.readLineSync();
                }
                bool g = true;
                int num = int.parse(amount);
                int num2 = int.parse(arr[1]);
                String? tryagain;
                while (num > num2 && tryagain != '2') {
                  print("Sorry not enough balance to make this withdraw.");
                  g=false;
                  Transaction.tryAgain();
                  tryagain = stdin.readLineSync();
                  while (tryagain != '1' && tryagain != '2') {
                    print("Invalid Input!");
                    Transaction.tryAgain();
                    tryagain = stdin.readLineSync();
                  }
                  if (tryagain == '1') {
                    Transaction.withdraw();
                    amount = stdin.readLineSync();
                    while (isNumeric(amount!) == false) {
                      print("Invalid Input!!");
                      Transaction.withdraw();
                      amount = stdin.readLineSync();
                    }
                    num = int.parse(amount);
                    g=true;
                  }
                }

                if (tryagain == '1'|| g == true) {
                  Transaction.confirmation();
                  String? conf = stdin.readLineSync();
                  while (conf != '1' && conf != '2') {
                    print("Invalid Input!");
                    Transaction.confirmation();
                    conf = stdin.readLineSync();
                  }
                  if (conf == '1') {
                    Transaction.withdrawSuccessful();
                    String? ws = stdin.readLineSync();
                    while (ws != '1' && ws != '2') {
                      print("Invalid Input!");
                      Transaction.withdrawSuccessful();
                      ws = stdin.readLineSync();
                    }
                    if (ws == '1') {
                      Transaction.receipt(num, num2);
                    }
                  }
                }
              }

              else if (ch == '1') {
                int balance = int.parse(arr[1]);
                print("Check Balance");
                Transaction.checkBalance(balance);
              }

              else if (ch == '2') {
                print("Cancel Transaction");
                r=true;
                break;
              }

              Transaction.anotherTransaction();
              String? transac = stdin.readLineSync();
              while (transac != '1' && transac != '2') {
                print("Invalid Input!");
                Transaction.anotherTransaction();
                transac = stdin.readLineSync();
              }
              if(transac == '2'){
                r = true;
                break;
              }



            }while(true);

          }
        }


        if(r==false){
          print("Account Not Found");
          continue;
        }
        else {
          break;
        }


    }

  }while(true);
  print("!!!Program has been terminated!!!");
}
bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

class Transaction{
  static void displayTransaction(){
    print("-------------------------------");
    print("\t\tPress:");
    print("\t\t[0] Withdaw");
    print("\t\t[1] Check Balance");
    print("\t\t[2] Cancel Transaction");
    print("-------------------------------");

  }

  static void withdraw(){
    print("-------------------------------");
    print("Enter the amount to be withdraw:");
    print("-------------------------------");
  }

  static void confirmation(){
    print("-------------------------------");
    print("Confirm Withdrawal");
    print("[1] Yes | [2] No");
    print("-------------------------------");
  }

  static void withdrawSuccessful(){
    print("Withdrawal Successful!");
    print("-------------------------------");
    print("Print Receipt?");
    print("[1] Yes | [2] No");
    print("-------------------------------");
  }
  static void receipt(int n, int n2){
    int n3 = n2 - n;
    print("-------------------------------");
    print("Previous Remaining Balance: $n2");
    print("Amount Withdraw: $n");
    print("Current Remaining Balance: $n3");
    print("-------------------------------");
  }

  static void tryAgain(){
    print("-------------------------------");
    print("Try Again?");
    print("[1] Yes | [2] No");
    print("-------------------------------");
  }

  static void checkBalance(int n){
    print("-------------------------------");
    print("Current Remaining Balance: $n");

    print("-------------------------------");
  }

  static void anotherTransaction(){
    print("-------------------------------");
    print("Make another transaction?");
    print("[1] Yes | [2] No");
    print("-------------------------------");
  }
}



