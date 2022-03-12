import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';

String getQuery(){
    String query="";
    query=r"""
      query obtenerInmueblesSimpleFiltro(
        $tipo_contrato: String,$ciudad: String,$id_usuario:String
        ){
            obtenerInmueblesSimpleFiltro(input1:{
              tipo_contrato: $tipo_contrato 
              ciudad: $ciudad
              id_usuario:$id_usuario
            }){
              inmuebles{
                indice
                id
                direccion
                ciudad
                tipo_contrato
                tipo_inmueble
                estado_negociacion
                precio
                historial_precios
                zona
                coordenadas
                mascotas_permitidas
                sin_hipoteca
                construccion_estrenar
                materiales_primera
                superficie_terreno
                superficie_construccion
                tamanio_frente
                antiguedad_construccion
                proyecto_preventa
                inmueble_compartido
                numero_duenios
                servicios_basicos
                gas_domiciliario
                wifi
                medidor_independiente
                termotanque
                calle_asfaltada
                transporte
                preparado_discapacidad
                papeles_orden
                habilitado_credito
                detalles_generales
                plantas
                ambientes
                dormitorios
                banios
                garaje
                amoblado
                lavanderia
                cuarto_lavado 
                churrasquero
                azotea
                condominio_privado
                cancha
                piscina
                sauna
                jacuzzi
                estudio
                jardin
                porton_electrico
                aire_acondicionado
                calefaccion
                ascensor
                deposito
                sotano
                balcon
                tienda
                amurallado_terreno
                detalles_internas
                iglesia
                parque_infantil
                escuela
                universidad
                plazuela
                modulo_policial
                sauna_piscina_publica
                gym_publico
                centro_deportivo
                puesto_salud
                zona_comercial
                detalles_comunidad
                remates_judiciales
                imagenes_2D_link
                video_2D_link
                tour_virtual_360_link
                video_tour_360_link
                detalles_otros
                fecha_creacion
                fecha_publicacion
                ultima_modificacion
                autorizacion
                categoria
                cantidad_vistos
                cantidad_doble_vistos
                cantidad_favoritos
                imagenes{
                  principales
                  plantas
                  ambientes
                  dormitorios
                  banios
                  garaje
                  amoblado
                  lavanderia
                  cuarto_lavado 
                  churrasquero
                  azotea
                  condominio_privado
                  cancha
                  piscina
                  sauna
                  jacuzzi
                  estudio
                  jardin
                  porton_electrico
                  aire_acondicionado
                  calefaccion
                  ascensor
                  deposito
                  sotano
                  balcon
                  tienda
                  amurallado_terreno
                }
                usuarios_favorito{
                  visto
                  doble_visto
                  favorito
                  contactado
                  id
                  usuario{
                    id
                    nombres
                    apellidos
                    email
                    medio_registro
                  }
                }
                propietario{
                  id
                  nombres
                  apellidos
                  email
                  medio_registro
                  fecha_ultimo_ingreso
                  tipo_usuario
                  nombre_agencia
                  telefono
                  web
                  verificado
                  estado_cuenta
                }
                creador{
                  id
                  nombres
                  apellidos
                  email
                  medio_registro
                  fecha_ultimo_ingreso
                  tipo_usuario
                  nombre_agencia
                  telefono
                  web
                  verificado
                  estado_cuenta
                }
              }
              publicidades{
                id
                precio_min
                precio_max
                tipo_contrato
                tipo_inmueble
                tipo_publicidad
                descripcion_publicidad
                link_imagen_publicidad
                link_web_publicidad
              }
            }
          }
      """;
    
    return query;
  }
  String getQueryNotificaciones(){
    String query="";
    query=r"""
    query obtenerInmueblesNuevos(
      $fecha: Date,$id_usuario: String,$dormitorios_min: Int, $dormitorios_max: Int,
      $banios_min: Int,$banios_max: Int,$garaje_min: Int,$garaje_max: Int,
      $superficie_terreno_min:Int,$superficie_terreno_max:Int,
      $superficie_construccion_min:Int,$superficie_construccion_max: Int,
      $tiempo_construccion_min:Int,$tiempo_construccion_max: Int,
      $precio_min: Int,$precio_max: Int
    ){
      obtenerInmueblesNuevos(input:{
        fecha: $fecha
        id_usuario:$id_usuario
        dormitorios_min:$dormitorios_min
        dormitorios_max:$dormitorios_max
        banios_min:$banios_min
        banios_max:$banios_max
        garaje_min:$garaje_min
        garaje_max:$garaje_max
        superficie_terreno_min:$superficie_terreno_min
        superficie_terreno_max:$superficie_terreno_max
        superficie_construccion_min:$superficie_construccion_min
        superficie_construccion_max:$superficie_construccion_max
        tiempo_construccion_min:$tiempo_construccion_min
        tiempo_construccion_max:$tiempo_construccion_max
        precio_min:$precio_min
        precio_max:$precio_max
      }){
        indice
        id
        propietario{
          id
          nombres
          apellidos
          email
          medio_registro
          fecha_ultimo_ingreso
          tipo_usuario
          nombre_agencia
          telefono
          web
          verificado
          estado_cuenta
        }
       direccion
        ciudad
        tipo_contrato
        tipo_inmueble
        estado_negociacion
        precio
        historial_precios
        zona
        coordenadas
        mascotas_permitidas
        sin_hipoteca
        construccion_estrenar
        materiales_primera
        superficie_terreno
        superficie_construccion
        tamanio_frente
        antiguedad_construccion
        proyecto_preventa
        inmueble_compartido
        numero_duenios
        servicios_basicos
        gas_domiciliario
        wifi
        medidor_independiente
        termotanque
        calle_asfaltada
        transporte
        preparado_discapacidad
        papeles_orden
        habilitado_credito
        detalles_generales
        plantas
        ambientes
        dormitorios
        banios
        garaje
        amoblado
        lavanderia
        cuarto_lavado 
        churrasquero
        azotea
        condominio_privado
        cancha
        piscina
        sauna
        jacuzzi
        estudio
        jardin
        porton_electrico
        aire_acondicionado
        calefaccion
        ascensor
        deposito
        sotano
        balcon
        tienda
        amurallado_terreno
        detalles_internas
        iglesia
        parque_infantil
        escuela
        universidad
        plazuela
        modulo_policial
        sauna_piscina_publica
        gym_publico
        centro_deportivo
        puesto_salud
        zona_comercial
        detalles_comunidad
        remates_judiciales
        imagenes_2D_link
        video_2D_link
        tour_virtual_360_link
        video_tour_360_link
        detalles_otros
        fecha_creacion
        fecha_publicacion
        autorizacion
        categoria
        cantidad_vistos
        cantidad_doble_vistos
        cantidad_favoritos
        imagenes{
          inmueble
          principales
           plantas
          ambientes
          dormitorios
          banios
          garaje
          amoblado
          lavanderia
          cuarto_lavado 
          churrasquero
          azotea
          condominio_privado
          cancha
          piscina
          sauna
          jacuzzi
          estudio
          jardin
          porton_electrico
          aire_acondicionado
          calefaccion
          ascensor
          deposito
          sotano
          balcon
          tienda
          amurallado_terreno
        }
        creador{
          id
          nombres
          apellidos
          email
          medio_registro
          fecha_ultimo_ingreso
          tipo_usuario
          nombre_agencia
          telefono
          web
          verificado
          estado_cuenta
        }
        usuarios_favorito{
          visto
          doble_visto
          favorito
          contactado
          id
          usuario{
            id
            nombres
            apellidos
            email
            medio_registro
            fecha_ultimo_ingreso
            tipo_usuario
            nombre_agencia
            telefono
            web
            verificado
            estado_cuenta
          }
        }
      }
    }
    """;
    return query;
  }
  String getQuery1(bool isPorUsuario){
    String query="";
    if(!isPorUsuario){
    query=r"""
      query obtenerInmuebles($tipo_inmueble: String,$tipo_contrato: String,$precio_min: Int,$precio_max: Int,
        $sup_terreno_min: Int, $sup_terreno_max: Int,$sup_construccion_min: Int,
        $sup_construccion_max: Int,$documentos_dia: Boolean,
        $construccion_estrenar: Boolean,$incluye_credito: Boolean,$sin_construir: Boolean,
        $tiempo_construccion_min: Int,$tiempo_construccion_max: Int,$inmueble_compartido: Boolean,
        $numero_duenios: Int,$numero_pisos: Int,$sin_hipoteca: Boolean
        $numero_dormitorios: Int,$numero_banios:Int,$numero_garaje:Int,$mascotas_permitidas:Boolean,
        $lavanderia: Boolean,$zona_lavadora: Boolean,$churrasquero:Boolean,
        $azotea:Boolean, $cancha: Boolean,$piscina: Boolean, $sauna: Boolean, 
        $tienda: Boolean, $estudio: Boolean,$jardin: Boolean, $balcon:Boolean,
        $ascensor: Boolean, $sotano: Boolean,$deposito: Boolean,
        $iglesia: Boolean,$parque:Boolean,$deportiva: Boolean,$policial:Boolean,
        $residencial: Boolean,$estudiantil: Boolean,$comercial:Boolean,
        $verificados:Boolean,$bienes_adjudicados:Boolean,$remates_judiciales:Boolean,
        $imagenes_2D:Boolean,$video_2D:Boolean,$tour_virtual:Boolean,$video_tour:Boolean,$id_usuario:String
        ){
        obtenerInmuebles(input1:{
          tipo_inmueble:$tipo_inmueble tipo_contrato: $tipo_contrato precio_min: $precio_min 
          precio_max: $precio_max sup_terreno_min:$sup_terreno_min sup_terreno_max:$sup_terreno_max
          sup_construccion_min:$sup_construccion_min sup_construccion_max:$sup_construccion_max
          documentos_dia:$documentos_dia construccion_estrenar:$construccion_estrenar
          incluye_credito:$incluye_credito sin_construir:$sin_construir
          tiempo_construccion_min:$tiempo_construccion_min tiempo_construccion_max:$tiempo_construccion_max
          inmueble_compartido:$inmueble_compartido numero_duenios:$numero_duenios
          numero_pisos:$numero_pisos sin_hipoteca:$sin_hipoteca
          numero_dormitorios:$numero_dormitorios numero_banios:$numero_banios numero_garaje:$numero_garaje
          mascotas_permitidas:$mascotas_permitidas lavanderia:$lavanderia zona_lavadora:$zona_lavadora
          churrasquero:$churrasquero azotea:$azotea cancha:$cancha piscina:$piscina sauna:$sauna tienda:$tienda 
          estudio:$estudio jardin:$jardin balcon:$balcon ascensor:$ascensor sotano:$sotano deposito:$deposito
          iglesia:$iglesia parque:$parque deportiva:$deportiva policial:$policial residencial:$residencial
          estudiantil:$estudiantil comercial:$comercial 
          verificados:$verificados bienes_adjudicados:$bienes_adjudicados remates_judiciales:$remates_judiciales
          imagenes_2D:$imagenes_2D video_2D:$video_2D tour_virtual:$tour_virtual video_tour:$video_tour,
          id_usuario:$id_usuario
        }){
          
          id
          propietario{
            id
            nombres
            apellidos
            email
            medio_registro
            fecha_ultimo_ingreso
            tipo_usuario
            nombre_agencia
            telefono
            web
            verificado
            estado_cuenta
          }
          direccion
          zona
          ciudad
          tipo_contrato
          tipo_inmueble
          precio
          superficie_terreno
          superficie_construccion
          documentos_dia
          construccion_estrenar
          incluye_credito
          sin_construir
          tiempo_construccion
          inmueble_compartido
          numero_duenios
          numero_pisos
          sin_hipoteca
          url_imagenes
          creador{
            id
            nombres
            apellidos
            email
            medio_registro
            fecha_ultimo_ingreso
            tipo_usuario
            nombre_agencia
            telefono
            web
            verificado
            estado_cuenta
          }
          numero_dormitorios
          numero_banios
          numero_garaje
          mascotas_permitidas
          lavanderia
          zona_lavadora 
          churrasquero
          azotea
          cancha
          piscina
          sauna
          tienda
          estudio
          jardin
          balcon
          ascensor
          sotano
          deposito
          iglesia
          parque
          deportiva
          policial
          residencial
          estudiantil
          comercial
          verificados
          bienes_adjudicados
          remates_judiciales
          imagenes_2D_link
          video_2D_link
          tour_virtual_360_link
          video_tour_360_link
          usuarios_favorito{
            visto
            doble_visto
            favorito
            contactado
            id
            usuario{
              id
              nombres
              apellidos
              email
              medio_registro
              fecha_ultimo_ingreso
              tipo_usuario
              nombre_agencia
              telefono
              web
              verificado
              estado_cuenta
            }
          }
        }
      }
    """;
    }else{
      query=r"""
        query obtenerUsuarioFavorito(
          $id:ID
        ){
          obtenerUsuarioFavorito(id:$id){
            id
            visto
            doble_visto
            favorito
            usuario{
              id
              nombres
              apellidos
              email
              medio_registro
            }
            inmueble{
              id
              propietario{
                id
                nombres
                apellidos
                email
                medio_registro
                fecha_ultimo_ingreso
                tipo_usuario
                nombre_agencia
                telefono
                web
                verificado
                estado_cuenta
              }
              direccion
              zona
              ciudad
              tipo_contrato
              tipo_inmueble
              precio
              superficie_terreno
              superficie_construccion
              documentos_dia
              construccion_estrenar
              incluye_credito
              sin_construir
              tiempo_construccion
              inmueble_compartido
              numero_duenios
              numero_pisos
              sin_hipoteca
              url_imagenes
              dormitorios
              banios
              garaje
              mascotas_permitidas
              lavanderia
              zona_lavadora 
              churrasquero
              azotea
              cancha
              piscina
              sauna
              tienda
              estudio
              jardin
              balcon
              ascensor
              sotano
              deposito
              iglesia
              parque
              deportiva
              policial
              residencial
              estudiantil
              comercial
              verificados
              bienes_adjudicados
              remates_judiciales
              imagenes_2D_link
              video_2D_link
              tour_virtual_360_link
              video_tour_360_link
              agencia{
                id
                nombre_agencia
                nombre_propietario
                telefono
                web
              }
            }
          }
        }
      """;
    }
    return query;
  }
  
  

String getQueryMutationRegistrarFavorito(){
  String query=r"""
    mutation registrarInmuebleFavorito($id_usuario: ID, $id_inmueble: ID,
    $favorito: Boolean, $doble_visto: Boolean, $visto: Boolean,$contactado: Boolean
  ){
    registrarInmuebleFavorito(
      id_usuario:$id_usuario,id_inmueble:$id_inmueble,
      input1:{
        favorito:$favorito
        doble_visto:$doble_visto
        visto:$visto
        contactado:$contactado
      },
    )
  }
  """;
  return query;
}

Map<String,dynamic> getMapRegistroFavoritos(String idUsuario,String idInmueble,UsuariosInmueblesFavoritos usuarioFavorito){
  Map<String,dynamic> mapDatos={
    "id_usuario":idUsuario,
    "id_inmueble":idInmueble,
    "visto":usuarioFavorito.visto,
    "doble_visto":usuarioFavorito.dobleVisto,
    "favorito":usuarioFavorito.favorito,
    "contactado":usuarioFavorito.contactado
  };
  //print(mapDatos);
  return mapDatos;
}



  String getMutationReponderQuejaInmueble(){
    String query="";
    query=r"""
      mutation responderInmuebleQuejaSuperUsuario(
        $id:ID,
        $id_super_usuario:ID,
        $sin_respuesta:Boolean,
        $rechazado_sin_justificacion:Boolean,
        $otro:Boolean,
        $observaciones_solicitud:String,
      ){
        responderInmuebleQuejaSuperUsuario(
          id_solicitud:$id,
          id_super_usuario:$id_super_usuario
          input:{
            sin_respuesta:$sin_respuesta
            rechazado_sin_justificacion:$rechazado_sin_justificacion
            otro:$otro
            observaciones_solicitud:$observaciones_solicitud
          }
        ){
          fecha_respuesta
        }
      }
    """;
    return query;
  }