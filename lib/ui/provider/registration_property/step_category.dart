class StepRegistrationProperty{
  int number;
  String nameStep;
  bool selected;
  StepRegistrationProperty({
    required this.number,
    required this.nameStep,
    required this.selected
  });
  factory StepRegistrationProperty.empty(){
    return StepRegistrationProperty(number:0,nameStep: "", selected: false);
  }
  factory StepRegistrationProperty.copyWith({required StepRegistrationProperty srp,bool? select}){
    return StepRegistrationProperty(
      number: srp.number, nameStep: srp.nameStep, selected: select??srp.selected
    );
  }

  List<StepRegistrationProperty> get steps{
    return [
      StepRegistrationProperty(number: 1, nameStep: "Generales", selected: true),
      StepRegistrationProperty(number: 2, nameStep: "Internas", selected: false),
      StepRegistrationProperty(number: 3, nameStep: "Comunidad", selected: false),
      StepRegistrationProperty(number: 4, nameStep: "Otros", selected: false),
    ];
  }
}