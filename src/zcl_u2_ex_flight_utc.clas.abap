"! <strong>Metodo para calcular duracion</strong><br>
"! otra linea de doc
CLASS zcl_u2_ex_flight_utc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    TYPES : BEGIN OF ty_airports,
              airport_id TYPE /dmo/airport_id, "AA DL
            END OF ty_airports,
            tt_airports TYPE STANDARD TABLE OF ty_airports WITH DEFAULT KEY.

    TYPES: BEGIN OF ty_connection,
             carrid      TYPE /dmo/carrier_id,
             connid      TYPE /dmo/connection_id,
             dep_airport TYPE /dmo/airport_id,
             arr_airport TYPE /dmo/airport_id,
             dep_time    TYPE /dmo/flight_departure_time,
             arr_time    TYPE /dmo/flight_arrival_time,
             duration    TYPE i,
           END OF ty_connection,
           tt_connection TYPE STANDARD TABLE OF ty_connection WITH DEFAULT KEY.

    CLASS-DATA lt_conections TYPE tt_connection.

    METHODS calcular_duracion.

ENDCLASS.



CLASS zcl_u2_ex_flight_utc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    calcular_duracion( ).

    LOOP AT lt_conections INTO data(ls_cons_p).
    out->write( | Vuelo:  { ls_cons_p-carrid } -- { ls_cons_p-connid } = { ls_cons_p-duration } minutos| ).
    endloop.

  ENDMETHOD.


  METHOD calcular_duracion.

    SELECT carrier_id, connection_id,
       airport_from_id AS dep_airport,
       airport_to_id AS arr_airport,
       departure_time   AS dep_time,
       arrival_time   AS arr_time
  FROM /dmo/connection
  INTO TABLE @lt_conections
  UP TO 10 ROWS.
  if sy-subrc NE 0.

 "exception Z
  ENDIF.

*    LOOP AT lt_conections INTO DATA(ls_conections).
    LOOP AT lt_conections ASSIGNING FIELD-SYMBOL(<fs_conections>).

      DATA(lv_date_s)  = cl_abap_context_info=>get_system_date( ).
      DATA lv_dep_ts TYPE utclong.
      DATA lv_arr_ts TYPE utclong.

      CONVERT DATE lv_date_s TIME <fs_conections>-dep_time
      INTO UTCLONG lv_dep_ts TIME ZONE 'UTC'.

      CONVERT DATE lv_date_s TIME <fs_conections>-arr_time
      INTO UTCLONG lv_arr_ts TIME ZONE 'UTC'.


      <fs_conections>-duration = utclong_diff( high = lv_arr_ts
                                             low  = lv_dep_ts ) / 60 .
*      MODIFY lt_conections FROM ls_conections.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
