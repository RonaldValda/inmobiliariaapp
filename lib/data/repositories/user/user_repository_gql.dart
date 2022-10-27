String mutationAuthenticateUser(){
    String query=r"""
       mutation autenticarUsuario($nombres : String, $apellidos : String,$email : String,
        $password : String!, $medio_registro :String,$tipo_usuario : String, $nombre_agencia: String,
        $telefono: String,$web: String, $verificado: Boolean,$fecha_ultimo_ingreso: Date,$estado_cuenta: Boolean
      ){
      autenticarUsuario(input:{
              nombres: $nombres
              apellidos: $apellidos
              email:$email
              password:$password
              medio_registro: $medio_registro
              tipo_usuario: $tipo_usuario
              nombre_agencia: $nombre_agencia
              telefono: $telefono
              web: $web
              verificado: $verificado
              fecha_ultimo_ingreso:$fecha_ultimo_ingreso
              estado_cuenta:$estado_cuenta
            }){
              id
              link_foto
              nombres
              apellidos
              email
              medio_registro
              tipo_usuario
              nombre_agencia
              telefono
              web
              verificado
              fecha_ultimo_ingreso
              fecha_penultimo_ingreso
              estado_cuenta
              sumatoria_calificacion
              cantidad_calificados
              usuario_inmueble_base{
                id
                tipo
                cantidad_inmuebles
                dormitorios_min
                dormitorios_max
                banios_min
                banios_max
                garaje_min
                garaje_max
                superficie_terreno_min
                superficie_terreno_max
                superficie_construccion_min
                superficie_construccion_max
                antiguedad_construccion_min
                antiguedad_construccion_max
                precio_min
                precio_max
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
                fecha_inicio
                fecha_ultimo_guardado
                fecha_cache
              }
            	membresia_pagos{
              id
                fecha_solicitud
                medio_pago
                monto_pago
                membresia_planes_pago{
                  id
                  nombre_plan
                  unidad_medida_tiempo
                  tiempo
                  costo
                  activo
                }
                numero_transaccion
                cuenta_banco{
                  id
                  fecha_habilitacion
                  fecha_cierre
                  activo
                  numero_cuenta
                  titular
                  nombre_banco
                  link_logo_banco
                }
                nombre_depositante
                link_imagen_deposito
                autorizacion
                observaciones
                fecha_respuesta
                respuesta_entregada
                fecha_inicio
                fecha_final
                activo
                fecha_cancelacion
                motivo_cancelacion
                fecha_solicitud_super_usuario
                fecha_respuesta_super_usuario
                respuesta_entregada_super_usuario
                autorizacion_super_usuario
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
                  sumatoria_calificacion
                  cantidad_calificados
                }
                administrador{
                  id
                  nombres
                  apellidos
                  email
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
  String mutationCreateUpdateUser(){
    String query=r"""
       mutation crearModificarUsuario($link_foto:String,$nombres : String!, $apellidos : String!,$email : String!,
        $password : String!, $medio_registro :String!,$tipo_usuario : String, $nombre_agencia: String,
        $telefono: String,$web: String, $verificado: Boolean,$fecha_ultimo_ingreso: Date,$estado_cuenta: Boolean,
        $actividad: String
      ){
      crearModificarUsuario(
          actividad: $actividad,
          input:{
              link_foto:$link_foto
              nombres: $nombres
              apellidos: $apellidos
              email:$email
              password:$password
              medio_registro: $medio_registro
              tipo_usuario: $tipo_usuario
              nombre_agencia: $nombre_agencia
              telefono: $telefono
              web: $web
              verificado: $verificado
              fecha_ultimo_ingreso:$fecha_ultimo_ingreso
              estado_cuenta:$estado_cuenta
              
            }){
              id
              link_foto
              nombres
              apellidos
              email
              medio_registro
              tipo_usuario
              nombre_agencia
              telefono
              web
              verificado
              fecha_ultimo_ingreso
              fecha_penultimo_ingreso
              estado_cuenta
              sumatoria_calificacion
              cantidad_calificados
              membresia_pagos{
              id
                fecha_solicitud
                medio_pago
                monto_pago
                membresia_planes_pago{
                  id
                  nombre_plan
                  unidad_medida_tiempo
                  tiempo
                  costo
                  activo
                }
                numero_transaccion
                cuenta_banco{
                  id
                  fecha_habilitacion
                  fecha_cierre
                  activo
                  numero_cuenta
                  titular
                  nombre_banco
                  link_logo_banco
                }
                nombre_depositante
                link_imagen_deposito
                autorizacion
                observaciones
                fecha_respuesta
                respuesta_entregada
                fecha_inicio
                activo
                fecha_cancelacion
                motivo_cancelacion
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
                  sumatoria_calificacion
                  cantidad_calificados
                }
                administrador{
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
                  sumatoria_calificacion
                  cantidad_calificados
                }
            }
        }
    }
    """;
    return query;
  }
  String mutationUpdateUser(){
    String query=r"""
     mutation modificarUsuario(
          $link_foto: String,
          $nombres : String, $apellidos : String,$email : String,
          $password : String, $nombre_agencia: String,
          $telefono: String,$web: String,$estado_cuenta:Boolean
        ){
        modificarUsuario(input:{
          link_foto:$link_foto
          nombres: $nombres
          apellidos: $apellidos
          email:$email
          password:$password
          nombre_agencia: $nombre_agencia
          telefono: $telefono
          web: $web
          estado_cuenta:$estado_cuenta
        })
    }
    """;
    return query;
  }
  String queryGetUsuarioEmail(){
    String query="";
    query=r"""
    query obtenerUsuarioEmail($email:String){
      obtenerUsuarioEmail(email:$email){
        id
        nombres
        apellidos
        email
        medio_registro
        tipo_usuario
        nombre_agencia
        telefono
        web
        verificado
        fecha_ultimo_ingreso
        estado_cuenta
        sumatoria_calificacion
        cantidad_calificados
      }
    }
    """;
    return query;
  }
  String queryRequests(){
    String query="";
    query=r"""
    query obtenerSolicitudesUsuarios($id:ID){
      obtenerSolicitudesUsuarios(id:$id){
        inmueble{
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
          remates_judiciales
          imagenes_2D_link
          video_2D_link
          tour_virtual_360_link
          video_tour_360_link
          fecha_creacion
          fecha_publicacion
          autorizacion
          categoria
          cantidad_vistos
          cantidad_favoritos
          cantidad_doble_vistos
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
        }
        usuario_respondedor{
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
        id
        tipo_solicitud
        fecha_solicitud
        fecha_respuesta
        respuesta
        observaciones
        solicitud_terminada
        respuesta_entregada
      }
    }
    """;
    return query;
  }
  String mutationAnswerUserRequestQualification(){
    String query="";
    query=r"""
      mutation responderSolicitudUsuarioCalificacion($id_solicitud:ID,$calificacion:Int){
        responderSolicitudUsuarioCalificacion(
          id_solicitud:$id_solicitud
          calificacion:$calificacion
        )
      }
    """;
    return query;
  }
  String queryGetMembershipPayments(){
    String query="";
    query=r"""
    query obtenerMembresiaPagos($id:ID){
      obtenerMembresiaPagos(id:$id){
        id
        fecha_solicitud
        medio_pago
        monto_pago
        membresia_planes_pago{
          id
          nombre_plan
          unidad_medida_tiempo
          tiempo
          costo
          activo
        }
        numero_transaccion
        cuenta_banco{
          id
          fecha_habilitacion
          fecha_cierre
          activo
          numero_cuenta
          titular
          nombre_banco
          link_logo_banco
        }
        nombre_depositante
        link_imagen_deposito
        autorizacion
        observaciones
        fecha_respuesta
        respuesta_entregada
        fecha_inicio
        fecha_final
        activo
        fecha_cancelacion
        motivo_cancelacion
        fecha_solicitud_super_usuario
        fecha_respuesta_super_usuario
        respuesta_entregada_super_usuario
        autorizacion_super_usuario
        usuario{
          id
          nombres
          apellidos
          email
          tipo_usuario
          nombre_agencia
          telefono
          web
          verificado
          estado_cuenta
        }
        administrador{
            id
            nombres
            apellidos
            email
            tipo_usuario
            telefono
            verificado
            estado_cuenta
        }
      }
    }
    """;
    return query;
  }
  String mutationRegisterMembershipPayment(){
    String query="";
    query=r"""
    mutation registrarMembresiaPago(
      $medio_pago:String,$monto_pago:Int,
          $membresia_planes_pago:ID,$numero_transaccion:String,
          $cuenta_banco:ID,$nombre_depositante:String,$link_imagen_deposito:String,
          $observaciones:String,$usuario:ID
        ){
          registrarMembresiaPago(input:{
            medio_pago:$medio_pago
            monto_pago:$monto_pago
            membresia_planes_pago:$membresia_planes_pago
            numero_transaccion:$numero_transaccion
            cuenta_banco:$cuenta_banco
            nombre_depositante:$nombre_depositante
            link_imagen_deposito:$link_imagen_deposito
            observaciones:$observaciones
            usuario:$usuario
          }){
            id
            fecha_solicitud
            fecha_final
            medio_pago
            monto_pago
            membresia_planes_pago{
              id
              nombre_plan
              unidad_medida_tiempo
              tiempo
              costo
              activo
            }
            numero_transaccion
            cuenta_banco{
              id
              fecha_habilitacion
              fecha_cierre
              activo
              numero_cuenta
              titular
              nombre_banco
              link_logo_banco
            }
            nombre_depositante
            link_imagen_deposito
            autorizacion
            observaciones
            fecha_respuesta
            respuesta_entregada
            fecha_inicio
            activo
            fecha_cancelacion
            motivo_cancelacion
            usuario{
              id
              nombres
              apellidos
              email
              tipo_usuario
              nombre_agencia
              telefono
              web
              verificado
              estado_cuenta
            }
            administrador{
              id
              nombres
              apellidos
              email
              tipo_usuario
              nombre_agencia
              telefono
              web
              verificado
              estado_cuenta
            }
          }
        }
    """;
    return query;
  }
  String mutationRegisterEmailKeyVerifications(){
    String query="";
    query=r"""
    mutation registrarEmailClaveVerificaciones($email:String,$actividad:String){
      registrarEmailClaveVerificaciones(input:{email:$email},actividad:$actividad){
        id
        fecha_creacion
        fecha_vencimiento
        email
        clave
      }
    }
    """;
    return query;
  }
  String queryGetEmailKeyVerifications(){
    String query="";
    query=r"""
    mutation obtenerEmailClaveVerificaciones($email:String,$clave:Int){
      obtenerEmailClaveVerificaciones(email:$email,clave:$clave){
        id
        fecha_creacion
        fecha_vencimiento
        email
        clave
        usuario{
          id
          nombres
          apellidos
          email
          medio_registro
          tipo_usuario
          telefono
        }
      }
    }
    """;
    return query;
  }
  String queryAuthenticateUserAutomatic(){
    String query="";
    query=r"""
    query autenticarUsuarioAutomatico($email:String,$imei:String){
      autenticarUsuarioAutomatico(
      email:$email,imei:$imei){
              id
              link_foto
              nombres
              apellidos
              imei_telefono
              email
              medio_registro
              tipo_usuario
              nombre_agencia
              telefono
              web
              verificado
              fecha_ultimo_ingreso
              fecha_penultimo_ingreso
              estado_cuenta
              sumatoria_calificacion
              cantidad_calificados
              usuario_inmueble_base{
                id
                tipo
                cantidad_inmuebles
                dormitorios_min
                dormitorios_max
                banios_min
                banios_max
                garaje_min
                garaje_max
                superficie_terreno_min
                superficie_terreno_max
                superficie_construccion_min
                superficie_construccion_max
                antiguedad_construccion_min
                antiguedad_construccion_max
                precio_min
                precio_max
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
                fecha_inicio
                fecha_ultimo_guardado
                fecha_cache
              }
            
            membresia_pagos{
              id
                fecha_solicitud
                medio_pago
                monto_pago
                membresia_planes_pago{
                  id
                  nombre_plan
                  unidad_medida_tiempo
                  tiempo
                  costo
                  activo
                }
                numero_transaccion
                cuenta_banco{
                  id
                  fecha_habilitacion
                  fecha_cierre
                  activo
                  numero_cuenta
                  titular
                  nombre_banco
                  link_logo_banco
                }
                nombre_depositante
                link_imagen_deposito
                autorizacion
                observaciones
                fecha_respuesta
                respuesta_entregada
                fecha_inicio
                fecha_final
                activo
                fecha_cancelacion
                motivo_cancelacion
                fecha_solicitud_super_usuario
                fecha_respuesta_super_usuario
                respuesta_entregada_super_usuario
                autorizacion_super_usuario
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
                  sumatoria_calificacion
                  cantidad_calificados
                }
                administrador{
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
                    sumatoria_calificacion
                    cantidad_calificados
                }
            }
        }
    }
    """;
    return query;
  }
  String mutationSearchUserEmail(){
    String query="";
    query=r"""
    mutation buscarUsuarioEmail($email:String){
      buscarUsuarioEmail(email:$email){
        id
        email
        nombres
        apellidos
        estado_cuenta
      }
    }
    """;
    return query;
  }
  String mutationRegisterUserPropertySearched(){
    String query="";
    query=r"""
    mutation registrarUsuarioInmuebleBuscado(
        $id_usuario:ID,$nombre_configuracion:String,$numero_telefono:String,$tipo_contrato:String,$tipo_inmueble:String,
        $ciudad:String,$zona:String,$ambientes:Int,$plantas:Int,
        $dormitorios: Int,$banios:Int,$garaje: Int,
        $superficie_terreno_min: Int,$superficie_terreno_max:Int,
        $superficie_construccion_min: Int,$superficie_construccion_max:Int,
        $antiguedad_construccion_min: Int,$antiguedad_construccion_max:Int,
        $tamanio_frente_min:Int,$tamanio_frente_max:Int,
        $precio_min:Int,$precio_max:Int,
        $mascotas_permitidas:Boolean,$sin_hipoteca:Boolean,$construccion_estrenar:Boolean,
        $materiales_primera:Boolean,$proyecto_preventa:Boolean,$inmueble_compartido:Boolean,
        $numero_duenios:Int,$servicios_basicos:Boolean,$gas_domiciliario:Boolean,
        $wifi:Boolean,$medidor_independiente:Boolean,$termotanque:Boolean,$calle_asfaltada:Boolean,
        $transporte:Boolean,$preparado_discapacidad:Boolean,$papeles_orden:Boolean,
        $habilitado_credito:Boolean,
        $amoblado:Boolean,$lavanderia:Boolean,$cuarto_lavado:Boolean,$churrasquero: Boolean,$azotea:Boolean,
        $condominio_privado:Boolean,$cancha:Boolean,
        $piscina:Boolean,$sauna:Boolean,$jacuzzi:Boolean,$estudio:Boolean,$jardin:Boolean,
        $porton_electrico:Boolean,$aire_acondicionado:Boolean,$calefaccion:Boolean,$ascensor:Boolean,
        $deposito:Boolean,$sotano:Boolean,$balcon:Boolean,$tienda:Boolean,$amurallado_terreno:Boolean,
        $iglesia:Boolean,$parque_infantil:Boolean,$escuela:Boolean,$universidad:Boolean,
        $plazuela:Boolean,$modulo_policial:Boolean,$sauna_piscina_publica:Boolean,$gym_publico:Boolean,
        $centro_deportivo:Boolean,$puesto_salud:Boolean,$zona_comercial:Boolean,
        $remates_judiciales:Boolean,$video_2D:Boolean,
        $tour_virtual_360:Boolean,$video_tour_360:Boolean
    ){
      registrarUsuarioInmuebleBuscado(
        id_usuario:$id_usuario,
        input:{
          nombre_configuracion:$nombre_configuracion
          numero_telefono:$numero_telefono
          tipo_contrato:$tipo_contrato
          tipo_inmueble:$tipo_inmueble
          ciudad:$ciudad
          zona:$zona
          superficie_terreno_min:$superficie_terreno_min
          superficie_terreno_max:$superficie_terreno_max
          superficie_construccion_min:$superficie_construccion_min
          superficie_construccion_max:$superficie_construccion_max
          antiguedad_construccion_min:$antiguedad_construccion_min
          antiguedad_construccion_max:$antiguedad_construccion_max
          tamanio_frente_min:$tamanio_frente_min
          tamanio_frente_max:$tamanio_frente_max
          precio_min:$precio_min
          precio_max:$precio_max
          mascotas_permitidas:$mascotas_permitidas
          sin_hipoteca:$sin_hipoteca
          construccion_estrenar:$construccion_estrenar
          materiales_primera:$materiales_primera
          proyecto_preventa:$proyecto_preventa
          inmueble_compartido:$inmueble_compartido
          numero_duenios:$numero_duenios
          servicios_basicos:$servicios_basicos
          gas_domiciliario:$gas_domiciliario
          wifi:$wifi
          medidor_independiente:$medidor_independiente
          termotanque:$termotanque
          calle_asfaltada:$calle_asfaltada
          transporte:$transporte
          preparado_discapacidad:$preparado_discapacidad
          papeles_orden:$papeles_orden
          habilitado_credito:$habilitado_credito
          plantas:$plantas
          ambientes:$ambientes
          dormitorios:$dormitorios
          banios:$banios
          garaje:$garaje
          amoblado:$amoblado
          lavanderia:$lavanderia
          cuarto_lavado:$cuarto_lavado
          churrasquero:$churrasquero
          azotea:$azotea
          condominio_privado:$condominio_privado
          cancha:$cancha
          piscina:$piscina
          sauna:$sauna
          jacuzzi:$jacuzzi
          estudio:$estudio
          jardin:$jardin
          porton_electrico:$porton_electrico
          aire_acondicionado:$aire_acondicionado
          calefaccion:$calefaccion
          ascensor:$ascensor
          deposito:$deposito
          sotano:$sotano
          balcon:$balcon
          tienda:$tienda
          amurallado_terreno:$amurallado_terreno
          iglesia:$iglesia
          parque_infantil:$parque_infantil
          escuela:$escuela
          universidad:$universidad
          plazuela:$plazuela
          modulo_policial:$modulo_policial
          sauna_piscina_publica:$sauna_piscina_publica
          gym_publico:$gym_publico
          centro_deportivo:$centro_deportivo
          puesto_salud:$puesto_salud
          zona_comercial:$zona_comercial
          remates_judiciales:$remates_judiciales
          video_2D:$video_2D
          tour_virtual_360:$tour_virtual_360
          video_tour_360:$video_tour_360
        }
      ){
        id
        nombre_configuracion
        numero_telefono
        tipo_contrato
        tipo_inmueble
        ciudad
        zona
        superficie_terreno_min
        superficie_terreno_max
        superficie_construccion_min
        superficie_construccion_max
        antiguedad_construccion_min
        antiguedad_construccion_max
        tamanio_frente_min
        tamanio_frente_max
        precio_min
        precio_max
        mascotas_permitidas
        sin_hipoteca
        construccion_estrenar
        materiales_primera
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
        remates_judiciales
        video_2D
        tour_virtual_360
        video_tour_360
      }
    }
    """;
    return query;
  }
  String mutationUpdatePropertiesSearcheds(){
    String query="";
    query=r"""
    mutation modificarUsuarioInmuebleBuscado(
        $id:ID,$nombre_configuracion:String,$numero_telefono:String,$tipo_contrato:String,$tipo_inmueble:String,
        $ciudad:String,$zona:String,$ambientes:Int,$plantas:Int,
        $dormitorios: Int,$banios:Int,$garaje: Int,
        $superficie_terreno_min: Int,$superficie_terreno_max:Int,
        $superficie_construccion_min: Int,$superficie_construccion_max:Int,
        $antiguedad_construccion_min: Int,$antiguedad_construccion_max:Int,
        $tamanio_frente_min:Int,$tamanio_frente_max:Int,
        $precio_min:Int,$precio_max:Int,
        $mascotas_permitidas:Boolean,$sin_hipoteca:Boolean,$construccion_estrenar:Boolean,
        $materiales_primera:Boolean,$proyecto_preventa:Boolean,$inmueble_compartido:Boolean,
        $numero_duenios:Int,$servicios_basicos:Boolean,$gas_domiciliario:Boolean,
        $wifi:Boolean,$medidor_independiente:Boolean,$termotanque:Boolean,$calle_asfaltada:Boolean,
        $transporte:Boolean,$preparado_discapacidad:Boolean,$papeles_orden:Boolean,
        $habilitado_credito:Boolean,
        $amoblado:Boolean,$lavanderia:Boolean,$cuarto_lavado:Boolean,$churrasquero: Boolean,$azotea:Boolean,
        $condominio_privado:Boolean,$cancha:Boolean,
        $piscina:Boolean,$sauna:Boolean,$jacuzzi:Boolean,$estudio:Boolean,$jardin:Boolean,
        $porton_electrico:Boolean,$aire_acondicionado:Boolean,$calefaccion:Boolean,$ascensor:Boolean,
        $deposito:Boolean,$sotano:Boolean,$balcon:Boolean,$tienda:Boolean,$amurallado_terreno:Boolean,
        $iglesia:Boolean,$parque_infantil:Boolean,$escuela:Boolean,$universidad:Boolean,
        $plazuela:Boolean,$modulo_policial:Boolean,$sauna_piscina_publica:Boolean,$gym_publico:Boolean,
        $centro_deportivo:Boolean,$puesto_salud:Boolean,$zona_comercial:Boolean,
        $remates_judiciales:Boolean,$video_2D:Boolean,
        $tour_virtual_360:Boolean,$video_tour_360:Boolean
    ){
      modificarUsuarioInmuebleBuscado(
        id:$id,
        input:{
          nombre_configuracion:$nombre_configuracion
          numero_telefono:$numero_telefono
          tipo_contrato:$tipo_contrato
          tipo_inmueble:$tipo_inmueble
          ciudad:$ciudad
          zona:$zona
          superficie_terreno_min:$superficie_terreno_min
          superficie_terreno_max:$superficie_terreno_max
          superficie_construccion_min:$superficie_construccion_min
          superficie_construccion_max:$superficie_construccion_max
          antiguedad_construccion_min:$antiguedad_construccion_min
          antiguedad_construccion_max:$antiguedad_construccion_max
          tamanio_frente_min:$tamanio_frente_min
          tamanio_frente_max:$tamanio_frente_max
          precio_min:$precio_min
          precio_max:$precio_max
          mascotas_permitidas:$mascotas_permitidas
          sin_hipoteca:$sin_hipoteca
          construccion_estrenar:$construccion_estrenar
          materiales_primera:$materiales_primera
          proyecto_preventa:$proyecto_preventa
          inmueble_compartido:$inmueble_compartido
          numero_duenios:$numero_duenios
          servicios_basicos:$servicios_basicos
          gas_domiciliario:$gas_domiciliario
          wifi:$wifi
          medidor_independiente:$medidor_independiente
          termotanque:$termotanque
          calle_asfaltada:$calle_asfaltada
          transporte:$transporte
          preparado_discapacidad:$preparado_discapacidad
          papeles_orden:$papeles_orden
          habilitado_credito:$habilitado_credito
          plantas:$plantas
          ambientes:$ambientes
          dormitorios:$dormitorios
          banios:$banios
          garaje:$garaje
          amoblado:$amoblado
          lavanderia:$lavanderia
          cuarto_lavado:$cuarto_lavado
          churrasquero:$churrasquero
          azotea:$azotea
          condominio_privado:$condominio_privado
          cancha:$cancha
          piscina:$piscina
          sauna:$sauna
          jacuzzi:$jacuzzi
          estudio:$estudio
          jardin:$jardin
          porton_electrico:$porton_electrico
          aire_acondicionado:$aire_acondicionado
          calefaccion:$calefaccion
          ascensor:$ascensor
          deposito:$deposito
          sotano:$sotano
          balcon:$balcon
          tienda:$tienda
          amurallado_terreno:$amurallado_terreno
          iglesia:$iglesia
          parque_infantil:$parque_infantil
          escuela:$escuela
          universidad:$universidad
          plazuela:$plazuela
          modulo_policial:$modulo_policial
          sauna_piscina_publica:$sauna_piscina_publica
          gym_publico:$gym_publico
          centro_deportivo:$centro_deportivo
          puesto_salud:$puesto_salud
          zona_comercial:$zona_comercial
          remates_judiciales:$remates_judiciales
          video_2D:$video_2D
          tour_virtual_360:$tour_virtual_360
          video_tour_360:$video_tour_360
        }
      )
    }
    """;
    return query;
  }
  String mutationUpdateUserPropertySearchedPersonalInformation(){
    String query="";
    query=r"""
      mutation modificarUsuarioInmuebleBuscadoPersonales(
        $id:ID,
        $nombre_configuracion:String,
        $numero_telefono:String
      ){
        modificarUsuarioInmuebleBuscadoPersonales(
          id:$id
          nombre_configuracion:$nombre_configuracion
          numero_telefono:$numero_telefono
        )
      }
    """;
    return query;
  }
  String queryGetUserPropertiesSearcheds(){
    String query="";
    query=r"""
    query obtenerUsuarioInmueblesBuscados(
      $id:ID
    ){
      obtenerUsuarioInmueblesBuscados(
        id:$id
      ){
        id
        nombre_configuracion
        numero_telefono
        tipo_contrato
        tipo_inmueble
        ciudad
        zona
        superficie_terreno_min
        superficie_terreno_max
        superficie_construccion_min
        superficie_construccion_max
        antiguedad_construccion_min
        antiguedad_construccion_max
        tamanio_frente_min
        tamanio_frente_max
        precio_min
        precio_max
        mascotas_permitidas
        sin_hipoteca
        construccion_estrenar
        materiales_primera
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
        remates_judiciales
        video_2D
        tour_virtual_360
        video_tour_360
      }
    }
    """;
    return query;
  }
  String mutationRegisterAgentRegistrationRequest(){
    String query="";
    query=r"""
      mutation registrarSolicitudInscripcionAgente(
        $id_usuario_solicitante:ID,
        $agencia:String,$web:String,$telefono:String,$ciudad:String
      ){
        registrarSolicitudInscripcionAgente(
          id_usuario_solicitante:$id_usuario_solicitante
          agencia:$agencia
          web:$web
          telefono:$telefono
          ciudad:$ciudad
        ){
          id
          fecha_solicitud
        }
      }
    """;
    return query;
  }
  String queryGetAgentsCity(){
    String query="";
    query=r"""
    query obtenerAgentesCiudad(
      $ciudad:String
    ){
      obtenerAgentesCiudad(
        ciudad:$ciudad
      ){
        id
        nombres
        apellidos
        email
        telefono
        nombre_agencia
        web
        sumatoria_calificacion
        cantidad_calificados
      }
    }
    """;
    return query;
  }
  String mutationUpdatePropertyBase(){
  String query="";
  query=r"""
    mutation actualizarInmuebleBase($id_usuario: ID,
  	$dormitorios_min_v: Int,$dormitorios_max_v:Int, $banios_min_v: Int,$banios_max_v:Int,
    $garaje_min_v: Int,$garaje_max_v:Int,$superficie_terreno_min_v: Int,$superficie_terreno_max_v:Int,
  	$superficie_construccion_min_v: Int,$superficie_construccion_max_v:Int,
  	$antiguedad_construccion_min_v: Int,$antiguedad_construccion_max_v:Int,$precio_min_v:Int,$precio_max_v:Int,
  	$cantidad_inmuebles_v:Int,
  	$amoblado_v:Int,$lavanderia_v:Int,$cuarto_lavado_v:Int,$churrasquero_v: Int,$azotea_v:Int,$condominio_privado_v:Int,$cancha_v:Int,
  	$piscina_v:Int,$sauna_v:Int,$jacuzzi_v:Int,$estudio_v:Int,$jardin_v:Int,$porton_electrico_v:Int,
  	$aire_acondicionado_v:Int,$calefaccion_v:Int,$ascensor_v:Int,$deposito_v:Int,$sotano_v:Int,$balcon_v:Int,
  	$tienda_v:Int,$amurallado_terreno_v:Int,
  	$dormitorios_min_dv: Int,$dormitorios_max_dv:Int, $banios_min_dv: Int,$banios_max_dv:Int,
    $garaje_min_dv: Int,$garaje_max_dv:Int,$superficie_terreno_min_dv: Int,$superficie_terreno_max_dv:Int,
  	$superficie_construccion_min_dv: Int,$superficie_construccion_max_dv:Int,
  	$antiguedad_construccion_min_dv: Int,$antiguedad_construccion_max_dv:Int,$precio_min_dv:Int,$precio_max_dv:Int,
  	$cantidad_inmuebles_dv:Int,
  	$amoblado_dv:Int,$lavanderia_dv:Int,$cuarto_lavado_dv:Int,$churrasquero_dv: Int,$azotea_dv:Int,$condominio_privado_dv:Int,$cancha_dv:Int,
  	$piscina_dv:Int,$sauna_dv:Int,$jacuzzi_dv:Int,$estudio_dv:Int,$jardin_dv:Int,$porton_electrico_dv:Int,
  	$aire_acondicionado_dv:Int,$calefaccion_dv:Int,$ascensor_dv:Int,$deposito_dv:Int,$sotano_dv:Int,$balcon_dv:Int,
  	$tienda_dv:Int,$amurallado_terreno_dv:Int,
  	$dormitorios_min_f: Int,$dormitorios_max_f:Int, $banios_min_f: Int,$banios_max_f:Int,
    $garaje_min_f: Int,$garaje_max_f:Int,$superficie_terreno_min_f: Int,$superficie_terreno_max_f:Int,
  	$superficie_construccion_min_f: Int,$superficie_construccion_max_f:Int,
  	$antiguedad_construccion_min_f: Int,$antiguedad_construccion_max_f:Int,$precio_min_f:Int,$precio_max_f:Int,
  	$cantidad_inmuebles_f:Int,
  	$amoblado_f:Int,$lavanderia_f:Int,$cuarto_lavado_f:Int,$churrasquero_f: Int,$azotea_f:Int,$condominio_privado_f:Int,$cancha_f:Int,
  	$piscina_f:Int,$sauna_f:Int,$jacuzzi_f:Int,$estudio_f:Int,$jardin_f:Int,$porton_electrico_f:Int,
  	$aire_acondicionado_f:Int,$calefaccion_f:Int,$ascensor_f:Int,$deposito_f:Int,$sotano_f:Int,$balcon_f:Int,
  	$tienda_f:Int,$amurallado_terreno_f:Int,
){
    actualizarInmuebleBase(
      id_usuario:$id_usuario,
      input_visto:{
        dormitorios_min: $dormitorios_min_v
        dormitorios_max: $dormitorios_max_v
        banios_min: $banios_min_v
        banios_max: $banios_max_v
        garaje_min: $garaje_min_v
        garaje_max: $garaje_max_v
        superficie_terreno_min: $superficie_terreno_min_v
        superficie_terreno_max: $superficie_terreno_max_v
        superficie_construccion_min: $superficie_construccion_min_v
        superficie_construccion_max: $superficie_construccion_max_v
        antiguedad_construccion_min: $antiguedad_construccion_min_v
        antiguedad_construccion_max: $antiguedad_construccion_max_v
        precio_min:$precio_min_v
        precio_max:$precio_max_v
        cantidad_inmuebles:$cantidad_inmuebles_v
        amoblado:$amoblado_v
        lavanderia:$lavanderia_v
        cuarto_lavado:$cuarto_lavado_v
        churrasquero:$churrasquero_v
        azotea:$azotea_v
        condominio_privado:$condominio_privado_v
        cancha:$cancha_v
        piscina:$piscina_v
        sauna:$sauna_v
        jacuzzi:$jacuzzi_v
        estudio:$estudio_v
        jardin:$jardin_v
        porton_electrico:$porton_electrico_v
        aire_acondicionado:$aire_acondicionado_v
        calefaccion:$calefaccion_v
        ascensor:$ascensor_v
        deposito:$deposito_v
        sotano:$sotano_v
        balcon:$balcon_v
        tienda:$tienda_v
        amurallado_terreno:$amurallado_terreno_v
      },
      input_doble_visto:{
        dormitorios_min: $dormitorios_min_dv
        dormitorios_max: $dormitorios_max_dv
        banios_min: $banios_min_dv
        banios_max: $banios_max_dv
        garaje_min: $garaje_min_dv
        garaje_max: $garaje_max_dv
        superficie_terreno_min: $superficie_terreno_min_dv
        superficie_terreno_max: $superficie_terreno_max_dv
        superficie_construccion_min: $superficie_construccion_min_dv
        superficie_construccion_max: $superficie_construccion_max_dv
        antiguedad_construccion_min: $antiguedad_construccion_min_dv
        antiguedad_construccion_max: $antiguedad_construccion_max_dv
        precio_min:$precio_min_dv
        precio_max:$precio_max_dv
        cantidad_inmuebles:$cantidad_inmuebles_dv
        amoblado:$amoblado_dv
        lavanderia:$lavanderia_dv
        cuarto_lavado:$cuarto_lavado_dv
        churrasquero:$churrasquero_dv
        azotea:$azotea_dv
        condominio_privado:$condominio_privado_dv
        cancha:$cancha_dv
        piscina:$piscina_dv
        sauna:$sauna_dv
        jacuzzi:$jacuzzi_dv
        estudio:$estudio_dv
        jardin:$jardin_dv
        porton_electrico:$porton_electrico_dv
        aire_acondicionado:$aire_acondicionado_dv
        calefaccion:$calefaccion_dv
        ascensor:$ascensor_dv
        deposito:$deposito_dv
        sotano:$sotano_dv
        balcon:$balcon_dv
        tienda:$tienda_dv
        amurallado_terreno:$amurallado_terreno_dv
      },
      input_favorito:{
        dormitorios_min: $dormitorios_min_f
        dormitorios_max: $dormitorios_max_f
        banios_min: $banios_min_f
        banios_max: $banios_max_f
        garaje_min: $garaje_min_f
        garaje_max: $garaje_max_f
        superficie_terreno_min: $superficie_terreno_min_f
        superficie_terreno_max: $superficie_terreno_max_f
        superficie_construccion_min: $superficie_construccion_min_f
        superficie_construccion_max: $superficie_construccion_max_f
        antiguedad_construccion_min: $antiguedad_construccion_min_f
        antiguedad_construccion_max: $antiguedad_construccion_max_f
        precio_min:$precio_min_f
        precio_max:$precio_max_f
        cantidad_inmuebles:$cantidad_inmuebles_f
        amoblado:$amoblado_f
        lavanderia:$lavanderia_f
        cuarto_lavado:$cuarto_lavado_f
        churrasquero:$churrasquero_f
        azotea:$azotea_f
        condominio_privado:$condominio_privado_f
        cancha:$cancha_f
        piscina:$piscina_f
        sauna:$sauna_f
        jacuzzi:$jacuzzi_f
        estudio:$estudio_f
        jardin:$jardin_f
        porton_electrico:$porton_electrico_f
        aire_acondicionado:$aire_acondicionado_f
        calefaccion:$calefaccion_f
        ascensor:$ascensor_f
        deposito:$deposito_f
        sotano:$sotano_f
        balcon:$balcon_f
        tienda:$tienda_f
        amurallado_terreno:$amurallado_terreno_f
      }
    )
  }
  """;
  return query;
}