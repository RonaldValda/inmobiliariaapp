
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/bank.dart';
import 'package:inmobiliariaapp/domain/usecases/general/usecase_bank.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
class SScreenCalculateAffordability extends StatefulWidget {
  SScreenCalculateAffordability({Key? key}) : super(key: key);

  @override
  _SScreenCalculateAffordabilityState createState() => _SScreenCalculateAffordabilityState();
}

class _SScreenCalculateAffordabilityState extends State<SScreenCalculateAffordability> {
  TextEditingController? controllerDollarValue;
  TextEditingController? controllerCII;
  TextEditingController? controllerCIIP;
  TextEditingController? controllerCPM;
  TextEditingController? controllerTIA;
  TextEditingController? controllerTerm;
  TextEditingController? controllerCCA;
  String resultado="";
  String resultado1="";
  final color=Colors.grey;
  final colorFill=Colors.white12;
  @override
  void initState() {
    super.initState();
    controllerDollarValue=TextEditingController(text: "6.86");
    controllerCII=TextEditingController(text: "0");
    controllerCIIP=TextEditingController(text: "0");
    controllerCPM=TextEditingController(text: "0");
    controllerTIA=TextEditingController(text: "0");
    controllerTerm=TextEditingController(text: "0");
    controllerCCA=TextEditingController(text: "0");
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Cálculadora de crédito"),
        
        actions: [
          
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10,bottom: 0,right: 15,left: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40,
                        width: 80,
                        child: FTextFieldBasico(
                          controller: controllerDollarValue!,
                          labelText: "Dólar",
                          onChanged: (x){},
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  FTextFieldBasico(
                    controller: controllerCII!, 
                    labelText: "Capacidad de inversión inicial propia",
                    onChanged: (x){
                      /*double c=double.parse(controllerCCA!.text);
                      double i=double.parse(x);
                      double j=i/c*100;
                      controllerCIIP!.text=j.toString();*/
                      
                      controllerCIIP!.text=("-");
                    },
                  ),
                  SizedBox(height: 10,),
                  FTextFieldBasico(
                    controller: controllerCIIP!, 
                    labelText: "Capacidad de inversión inicial propia (%)",
                    onChanged: (x){
                      /*double c=double.parse(controllerCCA!.text);
                      double j=double.parse(x);
                      double i=j*c/100;*/
                      controllerCII!.text="-";
                    },
                  ),
                  SizedBox(height: 10,),
                  FTextFieldBasico(
                    controller: controllerCPM!, 
                    labelText: "Capacidad de pago mensual",
                    onChanged: (x){},
                  ),
                  SizedBox(height: 10,),
                  FTextFieldBasico(
                    controller: controllerTIA!, 
                    labelText: "Tasa de interés anual (%)",
                    onChanged: (x){}
                  ),
                  SizedBox(height: 10,),
                  FTextFieldBasico(
                    controller: controllerTerm!, 
                    labelText: "Plazo (años)",
                    onChanged: (x){},
                  ),
                  SizedBox(height: 10,),
                  FTextFieldBasico(
                    controller: controllerCCA!, 
                    labelText: "Capacidad de compra aproximada",
                    onChanged: (x){
                      double c=double.parse(x);
                      double j=double.parse(controllerCIIP!.text);
                      double i=c*j/100;
                      controllerCII!.text=i.toString();
                    },
                  ),
                  SizedBox(height: 10,),
                  Text(
                    resultado,
                    style: TextStyle(
                      fontSize: 30
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    resultado1,
                    style: TextStyle(
                      fontSize: 30
                    ),
                  )
                ],
              )
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      double m=double.parse(controllerCPM!.text);
                      double t=double.parse(controllerTerm!.text);
                      double i=double.parse(controllerTIA!.text);
                      double iip=0.0,iic=0.0;
                      double s=double.parse(controllerDollarValue!.text);
                      double c=0.0;
                      if(controllerCII!.text!="-"){
                        iic=double.parse(controllerCII!.text);
                        c=((m*t*12)/((i/100*t+1))+iic)/s;
                        controllerCCA!.text=c.toString();
                        
                        iip=iic/c*100;
                        controllerCIIP!.text=iip.toString();
                      }else{
                        iip=double.parse(controllerCIIP!.text);
                        c=((m*t*12)/((i/100*t+1))*(1/(1-iip/100)))/s;
                        iic=iip*c/100;
                        controllerCII!.text=iic.toString();
                        controllerCCA!.text=c.toString();
                      }
                      /*if(controllerCII!.text=="-"){
                        iic=double.parse(controllerCIIP!.text);
                        c=(m*t*12)/((i/100*t+1)*(1-iic/100))/s;
                        controllerCCA!.text=c.toString();
                        iip=iic*c/100;
                        controllerCII!.text=iip.toString();
                      }else{
                        iip=double.parse(controllerCII!.text);
                        c=((m*a*12)/(t/100*a+1)+iip)/s;
                        iic=iip/c*100;
                        controllerCIIP!.text=iic.toString();
                        controllerCCA!.text=c.toString();
                      }*/
                      //Share.share("hola");
                      //Share.share('Sitio web https://example.com', subject: 'Titulo!');
                      setState(() {
                        
                      });
                    }, 
                    child: Text("Calcular")
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
class CalculadoraROI extends StatefulWidget {
  CalculadoraROI({Key? key}) : super(key: key);

  @override
  _CalculadoraROIState createState() => _CalculadoraROIState();
}

class _CalculadoraROIState extends State<CalculadoraROI> {
  TextEditingController? controllerROI;
  TextEditingController? controllerIngreso;
  TextEditingController? controllerPrecioInmueble;
  @override
  void initState() {
    super.initState();
    controllerROI=TextEditingController(text: "0.0");
    controllerIngreso=TextEditingController(text: "0.0");
    controllerPrecioInmueble=TextEditingController(text: "0.0");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora ROI"),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 0,left: 10,right: 10,top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                FTextFieldBasico(
                  controller: controllerIngreso!, 
                  labelText: "Ingreso mensual del inmueble", 
                  onChanged: (x){}
                ),
                SizedBox(height: 5,),
                FTextFieldBasico(
                  controller: controllerPrecioInmueble!, 
                  labelText: "Precio del inmueble", 
                  onChanged: (x){}
                ),
                SizedBox(height: 5,),
                FTextFieldBasico(
                  controller: controllerROI!, 
                  labelText: "Retorno de la inversión mensual (%)", 
                  onChanged: (x){}
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      double im=double.parse(controllerIngreso!.text);
                      double p=double.parse(controllerPrecioInmueble!.text);
                      double roi=im*12/p;
                      controllerROI!.text=roi.toString();
                      setState(() {
                        
                      });
                    }, 
                    child: Text("Calcular")
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
class CalculadoraHipotecariaSimple extends StatefulWidget {
  CalculadoraHipotecariaSimple({Key? key}) : super(key: key);

  @override
  _CalculadoraHipotecariaSimpleState createState() => _CalculadoraHipotecariaSimpleState();
}

class _CalculadoraHipotecariaSimpleState extends State<CalculadoraHipotecariaSimple> {
  TextEditingController? controllerMontoCredito;
  TextEditingController? controllerTIA;
  TextEditingController? controllerPlazo;
  TextEditingController? controllerCuotaMensual;
  @override
  void initState() {
    super.initState();
    controllerMontoCredito=TextEditingController(text: "0.0");
    controllerTIA=TextEditingController(text: "0.0");
    controllerPlazo=TextEditingController(text: "0");
    controllerCuotaMensual=TextEditingController(text: "0.0");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora hipotecaria simple"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 0,top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                FTextFieldBasico(
                  controller: controllerMontoCredito!, 
                  labelText: "Monto de crédito", 
                  onChanged: (x){}
                ),
                SizedBox(
                  height: 5,
                ),
                FTextFieldBasico(
                  controller: controllerTIA!, 
                  labelText: "Tasa de interés anual", 
                  onChanged: (x){}
                ),
                SizedBox(
                  height: 5,
                ),
                FTextFieldBasico(
                  controller: controllerPlazo!, 
                  labelText: "Plazo (años)", 
                  onChanged: (x){}
                ),
                SizedBox(
                  height: 5,
                ),
                FTextFieldBasico(
                  controller: controllerCuotaMensual!, 
                  labelText: "Cuota mensual aproximada", 
                  onChanged: (x){}
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      double c=double.parse(controllerMontoCredito!.text);
                      double i=double.parse(controllerTIA!.text);
                      double t=double.parse(controllerPlazo!.text);
                      double m=c*(i/100*t+1)/(t*12);
                      controllerCuotaMensual!.text=m.toString();
                      setState(() {
                        
                      });
                    }, 
                    child: Text("Calcular")
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
class CalculosBancarios extends StatefulWidget {
  CalculosBancarios({Key? key}) : super(key: key);

  @override
  _CalculosBancariosState createState() => _CalculosBancariosState();
}

class _CalculosBancariosState extends State<CalculosBancarios> {
  List<Bank> banks=[];
  int selected=-1;
  UseCaseBank useCaseBank=UseCaseBank();
  @override
  void initState() {
    super.initState();
    useCaseBank.getBanks().then((value){
      if(value["completed"]){
        banks=value["banks"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cáculos bancarios"),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Calculadoras",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            Column(
              children: [
                ListTile(
                  tileColor: Colors.black.withOpacity(0.05),
                  title: Text("Asequibilidad"),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return SScreenCalculateAffordability();
                        }
                      )
                    );
                  },
                ),
                ListTile(
                  title: Text("Hipotecaria simple"),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return CalculadoraHipotecariaSimple(
                          );
                        }
                      )
                    );
                  },
                ),
                ListTile(
                  tileColor: Colors.black.withOpacity(0.05),
                  title: Text("ROI"),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return CalculadoraROI(
                          );
                        }
                      )
                    );
                  },
                ),
              ],
            ),
            Divider(),
            Text("Bancos",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                itemCount: banks.length,
                itemBuilder: (context, index) {
                  Bank bank=banks[index];
                  return ListTile(
                    tileColor: (index+1)%2==0?Colors.black.withOpacity(0.05):Colors.transparent,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(bank.logoImageLink),
                      minRadius: 30,
                      maxRadius: 30,
                      //radius: 30,
                    ),
                    title: Text("${bank.bankName}"),
                    subtitle: Row(
                      children: [
                        IconButton(
                          onPressed: (){}, 
                          icon: Icon(Icons.apps_outlined)
                        ),
                        IconButton(
                          onPressed: (){}, 
                          icon: Icon(Icons.web)
                        ),
                        IconButton(
                          onPressed: (){}, 
                          icon: Icon(Icons.domain_verification_sharp)
                        ),
                      ],
                    ),
                    onTap: (){
                      if(selected==index){
                        selected=-1;
                      }else{
                        selected=index;
                      }
                      setState(() {
                        
                      });
                    },
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}