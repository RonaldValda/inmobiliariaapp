  String getQueryObtenerAdministradorInmuebleSuperUsuario(){
    String query="";
    query=r"""
      query obtenerAdministradorInmuebleSuperUsuario($id:ID)
    {
      obtenerAdministradorInmuebleSuperUsuario(id:$id)
      {
        inmueble{
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
          comprobante{
            id
            medio_pago
            monto_pago
            plan
            numero_transaccion
            cuenta_banco{
              id
              activo
              numero_cuenta
              titular
              nombre_banco
              link_logo_banco
            }
            nombre_depositante
            link_imagen_deposito
          }
        }
        super_usuario{
          id
          nombres
          apellidos
          email
          telefono
          tipo_usuario
          estado_cuenta
        }
        usuario_respondedor{
          id
          nombres
          apellidos
          email
          tipo_usuario
          telefono
          estado_cuenta
        }
        id
        tipo_solicitud
        fecha_solicitud
        fecha_respuesta
        respuesta
        observaciones
        link_respaldo_solicitud
        link_respaldo_respuesta
        solicitud_terminada
        fecha_solicitud_super_usuario
        fecha_respuesta_super_usuario
        respuesta_super_usuario
        respuesta_entregada_super_usuario
        observaciones_super_usuario
        solicitud_terminada_super_usuario
      }
    }
    """;
    return query;  
  }
  String getQueryMutationResponderSolicitudAdministradorSuperUsuario(){
    String query="";
    query=r"""
      mutation responderSolicitudAdministradorSuperUsuario(
        $id:ID,$id_super_usuario:ID,$tipo_solicitud:String,$respuesta:String,$observaciones:String,
        $solicitud_terminada:Boolean,
        $id_solicitud:ID
      ){
        responderSolicitudAdministradorSuperUsuario(
          id:$id
          id_super_usuario:$id_super_usuario
          id_solicitud:$id_solicitud
          input:{
            tipo_solicitud:$tipo_solicitud
            respuesta:$respuesta
            observaciones:$observaciones
            solicitud_terminada:$solicitud_terminada
          }
        )
      }
    """;
    return query;
  }
  String getQueryObtenerSolicitudesAdministradoresSuperUsuario(){
    String query=r"""
      query obtenerSolicitudesAdministradoresSuperUsuario($id:ID){
      obtenerSolicitudesAdministradoresSuperUsuario(id:$id){
        id
        fecha_solicitud
        fecha_respuesta
        respuesta_entregada
        tipo_solicitud
        respuesta
        observaciones
        link_respaldo_solicitud
        link_respaldo_respuesta
        solicitud_terminada
        fecha_solicitud_super_usuario
        fecha_respuesta_super_usuario
        respuesta_super_usuario
        respuesta_entregada_super_usuario
        observaciones_super_usuario
        solicitud_terminada_super_usuario
        inmueble_dar_baja{
          id
          limite_contrato
          cancelacion_contrato
          imagen_documento_propiedad
        }
        inmueble_vendido{
          id
          numero_testimonio
          usuario_comprador{
            id
            nombres
            apellidos
            email
            telefono
          }
        }

      }
    }
    """;
    return query;
  }
  String getQueryObtenerInmueblesSuperUsuario(){
    String query="";
    query=r"""
    query obtenerInmueblesSuperUsuario($ciudad:String,$tipo_contrato:String)
    {
      obtenerInmueblesSuperUsuario(
        ciudad:$ciudad
        tipo_contrato:$tipo_contrato
      )
      {
        inmueble{
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
          comprobante{
            id
            medio_pago
            monto_pago
            plan
            numero_transaccion
            cuenta_banco{
              id
              activo
              numero_cuenta
              titular
              nombre_banco
              link_logo_banco
            }
            nombre_depositante
            link_imagen_deposito
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
        link_respaldo_solicitud
        link_respaldo_respuesta
        solicitud_terminada
      }
    }
    """;
    return query;
  }
  String getQueryObtenerNotificacionesExisteSuperUsuario(){
    String query="";
    query=r"""
    query obtenerNotificacionesExisteSuperUsuario(
      $id:ID
    ){
      obtenerNotificacionesExisteSuperUsuario
      (
        id:$id
      )
    }
    """;
    return query;
  }
  String getQueryObtenerNotificacionesSuperUsuario(){
    String query=r"""
      query obtenerNotificacionesSuperUsuario(
        $id:ID
      ){
        obtenerNotificacionesSuperUsuario(
          id:$id
        ){
          reportar_inmueble{
            usuario_solicitante{
              id
              nombres
              apellidos
              email
              tipo_usuario
              estado_cuenta
              verificado
            }
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
                ultima_modificacion
                autorizacion
                categoria
                cantidad_vistos
                cantidad_doble_vistos
                cantidad_favoritos
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
            id
            vendido_multiples_lugares
            contenido_falso_imagen
            contenido_falso_texto
            contenido_inapropiado
            otro
            observaciones_solicitud
            fecha_solicitud
            fecha_respuesta
            respuesta
            observaciones_respuesta
            respuesta_entregada
          },
          inmuebles_quejas{
            id
            sin_respuesta
            rechazado_sin_justificacion
            otro
            observaciones_solicitud
            fecha_solicitud
            fecha_solicitud
            fecha_respuesta
            respuesta
            observaciones_respuesta
            respuesta_entregada
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
                ultima_modificacion
                autorizacion
                categoria
                cantidad_vistos
                cantidad_doble_vistos
                cantidad_favoritos
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
          }
         	membresias_pagos{
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
            fecha_solicitud_super_usuario
            fecha_respuesta_super_usuario
            autorizacion_super_usuario
            observaciones_super_usuario
            respuesta_entregada_super_usuario
            fecha_inicio
            fecha_final
            activo
            fecha_cancelacion
            motivo_cancelacion
            usuario{
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
              estado_cuenta
            }
            administrador{
                id
                nombres
                apellidos
                email
                telefono
                estado_cuenta
            }
          }
        }
      }
    """;
    return query;
  }

String getQueryObtenerAdministradores(){
  String query="";
  query=r"""
  query obtenerAdministradores{
    obtenerAdministradores{
      id
      nombres
      apellidos
      email
      estado_cuenta
      tipo_usuario
    }
  }
  """;
  return query;
}

String getMutationResponderInmuebleQueja(){
    String query="";
    query=r"""
      mutation responderInmuebleQuejaSuperUsuario(
        $id:ID,
        $id_super_usuario:ID,
        $observaciones_respuesta:String,
        $respuesta:String
      ){
        responderInmuebleQuejaSuperUsuario(
          id_solicitud:$id,
          id_super_usuario:$id_super_usuario
          input:{
            observaciones_respuesta:$observaciones_respuesta
            respuesta:$respuesta
          }
        ){
          fecha_respuesta
        }
      }
    """;
    return query;
  }
  String getMutationResponderReporteInmueble(){
    String query="";
    query=r"""
      mutation responderReporteInmueble(
        $id:ID,
        $observaciones_respuesta:String,
        $respuesta:String
      ){
        responderReporteInmueble(
          id_solicitud:$id,
          input:{
            observaciones_respuesta:$observaciones_respuesta
            respuesta:$respuesta
          }
        ){
          fecha_respuesta
        }
      }
    """;
    return query;
  }
  String getMutationResponderMembresiaPagoSuperUsuario(){
    String query="";
    query=r"""
    mutation responderMembresiaPagoSuperUsuario(
      $id_super_usuario:ID,$id:ID,
      $observaciones_super_usuario:String,$autorizacion_super_usuario:String
    ){
      responderMembresiaPagoSuperUsuario(
        id:$id
        id_super_usuario:$id_super_usuario
        observaciones:$observaciones_super_usuario
        autorizacion:$autorizacion_super_usuario
      ){
        id
        fecha_respuesta_super_usuario
      }
    }
    """;
    return query;
  }
  String getMutationHabilitarAdministrador(){
    String query="";
    query=r"""
    mutation habilitarAdministrador(
      $id_usuario:ID
    ){
      habilitarAdministrador(
        id_usuario:$id_usuario
      )
    }
    """;
    return query;
  }
  String getMutationInhabilitarAdministrador(){
    String query="";
    query=r"""
    mutation inhabilitarAdministrador(
      $id_usuario:ID
    ){
      inhabilitarAdministrador(
        id_usuario:$id_usuario
      )
    }
    """;
    return query;
  }
  String getMutationAsignarAdministradorZona(){
    String query="";
    query=r"""
    mutation asignarAdministradorZona(
      $id_administrador:ID,
      $id_zona:ID
    ){
      asignarAdministradorZona(
        id_usuario:$id_administrador
        id_zona:$id_zona
      )
    }
    """;
    return query;
  }
  String getMutationQuitarAdministradorZona(){
    String query="";
    query=r"""
    mutation quitarAdministradorZona(
      $id:ID
    ){
      quitarAdministradorZona(
        id:$id
      )
    }
    """;
    return query;
  }
  
  String getQueryObtenerUsuariosInmueblesBuscadosCiudad(){
    String query="";
    query=r"""
    query obtenerUsuariosInmuebleBuscadosCiudad(
      $ciudad:String
    ){
      obtenerUsuariosInmuebleBuscadosCiudad(
        ciudad:$ciudad
      ){
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
        imagenes_2D
        video_2D
        tour_virtual_360
        video_tour_360
      }
    }
    """;
    return query;
  }
  
  