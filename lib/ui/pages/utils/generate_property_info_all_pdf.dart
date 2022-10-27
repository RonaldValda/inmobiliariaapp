import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/utils/general_operators.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:io';
pw.Document? pdf;
Uint8List? archivoPdf;
double _paddingVertical2=2.0;
Future<Uint8List> readFileByte(String filePath) async {
    final myUri = Uri.parse(filePath);
    print(myUri);
    final audioFile = File.fromUri(myUri);
    var bytes=Uint8List(2);
    await audioFile.readAsBytes().then((value) {
    bytes = Uint8List.fromList(value); 
    print('reading of bytes is completed');
  });
  return bytes;
}
  pw.Widget widgetImagenesCategoria(List imagenes){
    _widthImage=170;
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: imagenes.map((e){
        print(e);
        return pw.Image(
          e,
          fit: pw.BoxFit.cover,
          height: _widthImage*0.7,
          width: _widthImage,
        );
      }).toList()
    );
  }
  pw.Widget _widgetImages(dynamic image){
    _widthImage=340;
    return pw.Image(
      image,
      fit: pw.BoxFit.cover,
      height: 312,
      width: 240,
    );
  }
  double _widthImage=190;
  Future<Uint8List> generatePropertyInfoAll(PropertyTotal propertyTotal,List<AdministratorRequest> administratorRequests,List<PropertyReported> propertyReporteds,List<PropertyComplaint> propertyComplaints,Map<String,dynamic> mapImagenesFile) async {
    
    pdf = pw.Document();
    pdf!.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: pw.EdgeInsets.symmetric(vertical:30),

        build: (context) => [
          pw.Wrap(
            direction: pw.Axis.horizontal,
            children: getChildren(propertyTotal, administratorRequests,propertyReporteds,propertyComplaints, mapImagenesFile)
          ),
          
        ],
      ),
    );
    return pdf!.save();
  }

  List<pw.Widget> getChildren(PropertyTotal propertyTotal,List<AdministratorRequest> administratorRequests,List<PropertyReported> propertyReporteds,List<PropertyComplaint> propertyComplaints,Map<String,dynamic> mapImagenesFile){
    double horizontalPadding=40;
    List<pw.Widget> children=[];
    children.add(pw.SizedBox(width: double.infinity));
    children.add(
      pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: 20,horizontal: horizontalPadding),
        child: pw.Center(
          child: pw.Text(
            '${propertyTotal.property.propertyType} en ${propertyTotal.property.contractType}',
            style: pw.TextStyle(
              fontSize: 30,
              color: PdfColors.blue,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
      ),
    );
    children.add(
      pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: 20,horizontal: horizontalPadding),
        child: widgetImagenesCategoria(mapImagenesFile["principales"]??[]),
      ),
    );
    children.add(_wGenerals(horizontalPadding, propertyTotal));
    children.add(_wInternal(horizontalPadding, propertyTotal));
    children.add(_wCommunity(horizontalPadding, propertyTotal));
    children.add(_wOthers(horizontalPadding, propertyTotal));
    addWidgetsAdministratorRequests(horizontalPadding, administratorRequests, children);
    addWidgetsComplaints(horizontalPadding, propertyComplaints, children);
    addWidgetsReporteds(horizontalPadding, propertyReporteds, children);
    return children;
  }

  pw.Padding _wOthers(double horizontalPadding, PropertyTotal propertyTotal) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 20,horizontal: horizontalPadding),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 10),
            child: pw.Center(
              child: pw.Text("OTROS",
                style: pw.TextStyle(
                  fontSize: 15,
                  fontWeight: pw.FontWeight.bold
                )
              ),
            )
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text(
              "${propertyTotal.propertyOthers.judicialAuctions?"Remates judiciales, ":""}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text(
              "Link vídeo 2D: ${propertyTotal.propertyOthers.video2DLink}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text(
              "Tour virtual 360 ${propertyTotal.propertyOthers.tourVirtual360Link}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text(
              "Vídeo tour 360: ${propertyTotal.propertyOthers.videoTour360Link}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Detalles: ${propertyTotal.propertyOthers.othersDetails}"),
          ),
          pw.Divider(color: PdfColor.fromRYB(0.8, 0.8, 0.8)),
        ]
      )
    );
  }

  pw.Padding _wCommunity(double horizontalPadding, PropertyTotal propertyTotal) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 20,horizontal: horizontalPadding),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 10),
            child: pw.Center(
              child: pw.Text("COMUNIDAD",
                style: pw.TextStyle(
                  fontSize: 15,
                  fontWeight: pw.FontWeight.bold
                )
              ),
            )
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text(
              "${propertyTotal.propertyCommunity.church?"Iglesia, ":""} ${propertyTotal.propertyCommunity.playground?"Parque infantil, ":""}"
              +"${propertyTotal.propertyCommunity.school?"Escuela, ":""} ${propertyTotal.propertyCommunity.university?"Universidad, ":""} ${propertyTotal.propertyCommunity.smallSquare?"Plazuela, ":""}"
              +"${propertyTotal.propertyCommunity.policeModule?"Módulo policial, ":""} ${propertyTotal.propertyCommunity.publicSaunaPool?"Sauna/piscina pública, ":""}"
              +"${propertyTotal.propertyCommunity.publicGym?"Gym público, ":""} ${propertyTotal.propertyCommunity.sportCenter?"Centro deportivo, ":""}"
              +"${propertyTotal.propertyCommunity.postHealth?"Puesto de salud, ":""} ${propertyTotal.propertyCommunity.shoopingZone?"Zona comercial":""}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Detalles: ${propertyTotal.propertyCommunity.communityDetails}"),
          ),
        ]
      )
    );
  }

  pw.Padding _wInternal(double horizontalPadding, PropertyTotal propertyTotal) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 20,horizontal: horizontalPadding),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 10),
            child: pw.Center(
              child: pw.Text("INTERNAS",
                style: pw.TextStyle(
                  fontSize: 15,
                  fontWeight: pw.FontWeight.bold
                )
              ),
            )
          ),
          if(propertyTotal.propertyInternal.floorsNumber>0)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Plantas: ${propertyTotal.propertyInternal.floorsNumber}"),
          ),
          if(propertyTotal.propertyInternal.roomsNumber>0)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Ambientes: ${propertyTotal.propertyInternal.roomsNumber}"),
          ),
          if(propertyTotal.propertyInternal.bedroomsNumber>0)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Dormitorios: ${propertyTotal.propertyInternal.bedroomsNumber}"),
          ),
          if(propertyTotal.propertyInternal.bathroomsNumber>0)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Baños: ${propertyTotal.propertyInternal.bathroomsNumber}"),
          ),
          if(propertyTotal.propertyInternal.garagesNumber>0)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Garaje: ${propertyTotal.propertyInternal.garagesNumber}"),
          ),
          if(propertyTotal.propertyInternal.furnished)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Amoblado"),
          ),
          if(propertyTotal.propertyInternal.laundry)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Lavanderia"),
          ),
          if(propertyTotal.propertyInternal.laundryRoom)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Cuarto de lavado"),
          ),
          if(propertyTotal.propertyInternal.grill)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Churrasquero"),
          ),
          if(propertyTotal.propertyInternal.rooftop)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Azotea"),
          ),
          if(propertyTotal.propertyInternal.privateCondominium)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("[Club house]-> Condominio privado"),
          ),
          if(propertyTotal.propertyInternal.court)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Cancha de fútbol, tenis, etc. en inmueble"),
          ),
          if(propertyTotal.propertyInternal.pool)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Piscina"),
          ),
          if(propertyTotal.propertyInternal.sauna)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Sauna"),
          ),
          if(propertyTotal.propertyInternal.jacuzzi)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Jacuzzi"),
          ),
          if(propertyTotal.propertyInternal.studio)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Estudio"),
          ),
          if(propertyTotal.propertyInternal.garden)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Jardín"),
          ),
          if(propertyTotal.propertyInternal.electricGate)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Portón eléctrico"),
          ),
          if(propertyTotal.propertyInternal.airConditioning)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Aire acondicionado"),
          ),
          if(propertyTotal.propertyInternal.heating)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Calefacción"),
          ),
          if(propertyTotal.propertyInternal.elevator)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Ascensor"),
          ),
          if(propertyTotal.propertyInternal.warehouse)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Depósito"),
          ),
          if(propertyTotal.propertyInternal.basement)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Sótano"),
          ),
          if(propertyTotal.propertyInternal.balcony)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Balcón"),
          ),
          if(propertyTotal.propertyInternal.store)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Tienda"),
          ),
          if(propertyTotal.propertyInternal.landWalled)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("[Amurallado]-> Terreno"),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Detalles: ${propertyTotal.propertyInternal.internalDetails}"),
          ),
        ]
      )
    );
  }

  pw.Padding _wGenerals(double horizontalPadding, PropertyTotal propertyTotal) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 20,horizontal: horizontalPadding),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.only(top: 10,bottom:10),
            child: pw.Center(
              child: pw.Text("GENERALES",
                style: pw.TextStyle(
                  fontSize: 15,
                  fontWeight: pw.FontWeight.bold
                )
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Precio: ${propertyTotal.property.price}"+r"$")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Ciudad: ${propertyTotal.property.city}, Zona: ${propertyTotal.property.zoneName}, Dirección: ${propertyTotal.property.address}")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Vendedor o agente inmobilicario: ${propertyTotal.creator.names} ${propertyTotal.creator.surnames}, Email:${propertyTotal.creator.email}, Teléfono: ${propertyTotal.creator.phoneNumber}")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text(
              "${propertyTotal.property.enablePets?"Mascotas permitidas, ":""} ${propertyTotal.property.noMortgage?"Sin hipoteca, ":""} ${propertyTotal.property.newConstruction?"Construcción estrenar, ":""}"
              +"${propertyTotal.property.premiumMaterials?"Materiales de primera, ":""}Superficie de terreno en m2: ${propertyTotal.property.landSurface}, "
              +"Superficie de construcción en m2: ${propertyTotal.property.constructionSurface}, Tamaño de frente en metros: ${propertyTotal.property.frontSize}, "
              +"Antigüedad de construcción: ${propertyTotal.property.constructionAntiquity}, ${propertyTotal.property.preSaleProject?"Proyecto en pre venta, ":""}"
              +"Número de dueños: ${propertyTotal.property.ownersNumber}, ${propertyTotal.property.basicServices?"Servicios básicos, ":""}"
              +"${propertyTotal.property.householdGas?"Gas domiciliario, ":""} ${propertyTotal.property.wifi?"Wi-Fi, ":""} ${propertyTotal.property.independentMeter?"Medidor independiente, ":""}"
              +"${propertyTotal.property.hotWaterTank?"Termotanques, ":""} ${propertyTotal.property.pavedStreet?"Calle asfaltada, ":""} ${propertyTotal.property.transport?"Transporte (0-100m), ":""}"
              +"${propertyTotal.property.disabilityPrepared?"Preparado para discapacidad, ":""} ${propertyTotal.property.orderPapers?"Papeles en orden, ":""} ${propertyTotal.property.enabledCredit?"Habilitado para crédito de vivienda social":""}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            child: pw.Text("Detalles: ${propertyTotal.property.generalDetails}"),
          ),
        ]
      )
    );
  }
  
  void addWidgetsComplaints(double horizontalPadding,List<PropertyComplaint> propertyComplaints,List<pw.Widget> children){
    children.add(
      pw.Padding(
        padding: pw.EdgeInsets.only(top: 10,bottom:10),
        child: pw.Center(
          child: pw.Text("REPORTADOS INMUEBLE POR EL VENDEDOR",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold
            )
          ),
        ),
      ),
    );
    propertyComplaints.forEach((element) { 
      children.add(
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 5,horizontal: horizontalPadding),
          child: _wPropertyComplaint(element)
        )
        
      );
    });
  }
  void addWidgetsReporteds(double horizontalPadding,List<PropertyReported> propertyReporteds,List<pw.Widget> children){
    children.add(
      pw.Padding(
        padding: pw.EdgeInsets.only(top: 10,bottom:10),
        child: pw.Center(
          child: pw.Text("REPORTADOS INMUEBLE POR USUARIOS",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold
            )
          ),
        ),
      ),
    );
    propertyReporteds.forEach((element) { 
      children.add(
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 5,horizontal: horizontalPadding),
          child: _wPropertyReported(element)
        )
      );
    });
  }

  void addWidgetsAdministratorRequests(double horizontalPadding,List<AdministratorRequest> administratorRequests,List<pw.Widget> children){
    children.add(
      pw.Padding(
        padding: pw.EdgeInsets.only(top: 10,bottom:10),
        child: pw.Center(
          child: pw.Text("SOLICITUDES",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold
            )
          ),
        ),
      ),
    );
     administratorRequests.forEach((e) {
      children.add(
        pw.Padding(
          padding:pw.EdgeInsets.only(top: 0,right: horizontalPadding,left: horizontalPadding),
          child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _wAdministratorRequestsGeneral(e),
            ]
          )
        ),
      );
      if(e.requestType=="Publicar"||e.requestType=="Actualizar"||e.requestType=="Bajar precio"){
        if(e.propertyVoucher.publicationPlanPayment.planName!="")
          addWidgetsVoucherPostUpdate(horizontalPadding, e.propertyVoucher, children);
      }
      if(e.requestType=="Vendido"){
        if(e.propertyVoucher.id!="")
          addWidgetsSold(horizontalPadding, e.propertyVoucher, children);
      }
      if(e.requestType=="Dar baja"){
        if(e.propertyVoucher.id!="")
          addWidgetsDisable(horizontalPadding, e.propertyVoucher, children);
      }
      children.add(
        pw.Container(
          width: double.infinity,
          height: 0.3,
          margin: pw.EdgeInsets.symmetric(vertical: 7),
          color: PdfColor.fromRYB(0.2, 0.2, 0.2)
        )
      );
    });
  }
  void addWidgetsSold(double horizontalPadding,PropertyVoucher propertyVoucher,List<pw.Widget> children){
    children.add(
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 7,horizontal: horizontalPadding),
            child: pw.Text("DETALLES")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
            child: pw.Text("Nº Testimonio: ${propertyVoucher.testimonyNumber}")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
            child: pw.Text("Usuario comprador")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
            child: pw.Text("Nombres: ${propertyVoucher.userBuyer.namesSurnames}")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
            child: pw.Text("Email: ${propertyVoucher.userBuyer.email}")
          ),
        ]
      )
    );
  }

  void addWidgetsDisable(double horizontalPadding,PropertyVoucher propertyVoucher,List<pw.Widget> children){
    children.add(
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 7,horizontal: horizontalPadding),
            child: pw.Text("DETALLES")
          ),
          if(propertyVoucher.contractLimit)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
            child: pw.Text("Límite de contrato")
          ),
          if(propertyVoucher.contractCancel)
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
            child: pw.Text("Cancelación de contrato")
          ),
          if(propertyVoucher.documentPropertyImageLink!="")
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
                child: pw.Text("Documento de propiedad")
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
                child:_widgetImages(propertyVoucher.documentPropertyImageLink)
              )
            ]
          )
        ]
      )
    );
  }

  void addWidgetsVoucherPostUpdate(double horizontalPadding,PropertyVoucher propertyVoucher,List<pw.Widget> children){
    List<pw.Widget> childrenAux=[];
    childrenAux.add( pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 7,horizontal: horizontalPadding),
      child: pw.Text("DETALLES")
    ));
    childrenAux.add(
      pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
        child: pw.Text("Plan: ${propertyVoucher.publicationPlanPayment.planName}")
      ),
    );
    if(propertyVoucher.paymentMedium!=""){
      
      childrenAux.add(pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
        child: pw.Text("Medio pago: ${propertyVoucher.paymentMedium}")
      ));
      childrenAux.add(pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
        child: pw.Text("Monto pago: ${propertyVoucher.paymentAmount} Bs.")
      ));
      childrenAux.add(pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
        child: pw.Text("Nombre depositante: ${propertyVoucher.depositorName}")
      ));
      childrenAux.add(pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
        child: pw.Text("Nombre banco: ${propertyVoucher.bankAccount.bankName}")
      ));
      childrenAux.add(pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
        child: pw.Text("Nº cuenta: ${propertyVoucher.bankAccount.accountNumber}")
      ));
      childrenAux.add(pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
        child: pw.Text("Titular cuenta: ${propertyVoucher.bankAccount.owner}")
      ));
    }
    if(propertyVoucher.depositImageLink!="")
    childrenAux.add(
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
            child: pw.Text("Voucher depósito")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
            child:_widgetImages(propertyVoucher.depositImageLink)
          )
        ]
      )
    );
    if(propertyVoucher.documentPropertyImageLink!=""){
      childrenAux.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
              child: pw.Text("Documento de propiedad")
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
              child:_widgetImages(propertyVoucher.documentPropertyImageLink)
            )
          ]
        )
      );
    }
    if(propertyVoucher.documentSalesImageLink!=""){
      childrenAux.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
              child: pw.Text("Documento exclusivo de venta")
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
              child:_widgetImages(propertyVoucher.documentSalesImageLink)
            )
          ]
        )
      );
    }
    if(propertyVoucher.ownerDNIImageLink!=""){
      childrenAux.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
              child: pw.Text("Cédula de identidad del propietario")
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
              child:_widgetImages(propertyVoucher.ownerDNIImageLink)
            )
          ]
        )
      );
    }
    if(propertyVoucher.agentDNIImageLink!=""){
      childrenAux.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
              child: pw.Text("Cédula de identidad del agente")
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2,horizontal: horizontalPadding),
              child:_widgetImages(propertyVoucher.agentDNIImageLink)
            )
          ]
        )
      );
    }
    children.add(
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: childrenAux
      )
    );
    
    
  }

  pw.Column _wAdministratorRequestsGeneral(AdministratorRequest administratorRequest){
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 7),
            child: pw.Text("DATOS SOLICITUD")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
            child: pw.Text("Tipo solicitud: ${administratorRequest.requestType}")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
            child: pw.Text("Fecha solicitud: ${GeneralOperators.stringToStringFormat(administratorRequest.requestDate,isOrderReverse: true)}")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
            child: administratorRequest.response!=""?
            pw.Text("Fecha respuesta: ${GeneralOperators.stringToStringFormat(administratorRequest.responseDate,isOrderReverse: true)}")
            :pw.Text("Fecha respuesta: ")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
            child: pw.Text("Respuesta: ${administratorRequest.response}")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
            child: pw.Text("Observaciones: ${administratorRequest.observations}")
          ),
        ]
      );
      
  }
pw.Column _wPropertyReported(PropertyReported propertyReported){
  return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 7),
          child: pw.Text("DATOS REPORTE")
        ),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Fecha solicitud: ${GeneralOperators.stringToStringFormat(propertyReported.requestDate,isOrderReverse: true)}")
        ),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: propertyReported.response!=""?
          pw.Text("Fecha respuesta: ${GeneralOperators.stringToStringFormat(propertyReported.responseDate,isOrderReverse: true)}")
          :pw.Text("Fecha respuesta: ")
        ),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Respuesta: ${propertyReported.response}")
        ),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Observaciones respuesta: ${propertyReported.responseObservations}")
        ),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Motivo del reporte:")
        ),
        if(propertyReported.soldMultiplePlaces)
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Vendido en más de un lugar")
        ),
        if(propertyReported.fakeContentImage)
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Contenido falso imágen")
        ),
        if(propertyReported.fakeContentText)
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Contenido falso texto")
        ),
        if(propertyReported.inappropriateContent)
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Contenido inapropiado")
        ),
        if(propertyReported.other)
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Otro")
        ),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Observaciones: ${propertyReported.requestObservations}")
        ),
      ]
    );
  }
  pw.Column _wPropertyComplaint(PropertyComplaint propertyComplaint){
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 7),
          child: pw.Text("DATOS REPORTE")
        ),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Fecha solicitud: ${GeneralOperators.stringToStringFormat(propertyComplaint.requestDate,isOrderReverse: true)}")
        ),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: propertyComplaint.response!=""?
          pw.Text("Fecha respuesta: ${GeneralOperators.stringToStringFormat(propertyComplaint.responseDate,isOrderReverse: true)}")
          :pw.Text("Fecha respuesta: ")
        ),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Respuesta: ${propertyComplaint.response}")
        ),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Observaciones respuesta: ${propertyComplaint.responseObservations}")
        ),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Motivo del reporte:")
        ),
        if(propertyComplaint.noResponse)
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Sin respuesta")
        ),
        if(propertyComplaint.rejectedWithoutJustification)
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Rechazado sin justificación")
        ),
        if(propertyComplaint.other)
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Otro")
        ),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: _paddingVertical2),
          child: pw.Text("Observaciones: ${propertyComplaint.requestObservations}")
        ),
      ]
    );
  }