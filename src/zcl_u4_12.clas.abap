


CLASS zcl_u4_12 DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_u4_12 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    out->write( |=== Unit 4 Solution 12 – Working with Aggregate Functions ===| ).


*--------------------------------------------------------------------*
    SELECT COUNT( * ) AS total_connections,
           AVG( CAST( distance AS FLTP ) ) AS avg_distance
      FROM /dmo/connection
      INTO @DATA(ls_overall).

    out->write( |--- Task 1 Result (Total & Average) ---| ).
    out->write( |Total vuelos: { ls_overall-total_connections } | ).
    DATA(lv_avg_distance) = round( val = ls_overall-avg_distance dec = 2 ).
    out->write( |Distancia promedio: { lv_avg_distance } km| ).


*--------------------------------------------------------------------*
    SELECT carrier_id,
           COUNT( * ) AS num_flights,
           AVG( CAST( distance AS FLTP ) ) AS avg_distance
      FROM /dmo/connection
      GROUP BY carrier_id
      INTO TABLE @DATA(it_grouped).

    out->write( |--- Task 2 Result (Group By Carrier) ---| ).
    LOOP AT it_grouped INTO DATA(ls_group).
      DATA(lv_avg_distance2) = round( val = ls_overall-avg_distance dec = 2 ).
      out->write(
        |Carrier { ls_group-carrier_id }: { ls_group-num_flights } vuelos, Distancia promedio { lv_avg_distance2 } km| ).
    ENDLOOP.


*--------------------------------------------------------------------*
    SELECT carrier_id,
           COUNT( * ) AS num_flights,
           AVG( CAST( distance AS FLTP ) ) AS avg_distance
      FROM /dmo/connection
      GROUP BY carrier_id
      HAVING COUNT( * ) > 3
      INTO TABLE @DATA(it_filtered).

    out->write( |--- Task 3 Result (HAVING > 3 Flights) ---| ).
    LOOP AT it_filtered INTO DATA(ls_filtered).
      DATA(lv_avg_distance3) = round( val = ls_overall-avg_distance dec = 2 ).

      out->write(
        |Carrier { ls_filtered-carrier_id }: { ls_filtered-num_flights } vuelos, Distancia promedio { lv_avg_distance3 } km| ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

