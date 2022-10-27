class GeneralOperators{
  static String stringToStringFormat(String date,{bool isOrderReverse=false}){
    Map<String,dynamic> mapDate={};
    String dateString="";
    mapDate["day"]=isOrderReverse?date.substring(8,10):date.substring(0,2);
    mapDate["month"]=isOrderReverse?date.substring(5,7):date.substring(3,5);
    mapDate["year"]=isOrderReverse?date.substring(0,4):date.substring(6,10);
    mapDate["time"]=date.substring(11,19);
    dateString="${mapDate["day"]}/${mapDate["month"]}/${mapDate["year"]} ${mapDate["time"]}";
    return dateString;
  }
}