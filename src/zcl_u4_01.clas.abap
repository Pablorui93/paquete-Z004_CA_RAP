


CLASS zcl_u4_01 DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
    METHODS:
      demo_lesson1_joins
        IMPORTING out TYPE REF TO if_oo_adt_classrun_out,
      demo_lesson2_aggregates
        IMPORTING out TYPE REF TO if_oo_adt_classrun_out,
      demo_lesson3_subqueries
        IMPORTING out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.


CLASS zcl_u4_01 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
*codigo del manual

*    demo_lesson1_joins( out ).
*    demo_lesson2_aggregates( out ).
*    demo_lesson3_subqueries( out ).

*****************************************************
**Ejercicio 4 - 10
*     SELECT a~carrier_id,
*           a~connection_id,
*           a~airport_from_id,
*           a~airport_to_id,
*           b~name
*      FROM /dmo/connection AS a
*      INNER JOIN /dmo/carrier AS b
*        ON a~carrier_id = b~carrier_id
*      INTO TABLE @DATA(it_join1)
*      UP TO 10 ROWS.
*
*    out->write( |--- Task 1: INNER JOIN | ).
*    LOOP AT it_join1 INTO DATA(ls_join1).
*      out->write(
*        |{ ls_join1-carrier_id }-{ ls_join1-connection_id }: { ls_join1-airport_from_id } → { ls_join1-airport_to_id } ({ ls_join1-name })| ).
*    ENDLOOP.
*
*
*
*    SELECT a~carrier_id,
*           a~connection_id,
*           b~name,
*           a~airport_from_id AS dep_airport,
*           dep~name     AS dep_name,
*           a~airport_to_id  AS arr_airport,
*           arr~name     AS arr_name
*      FROM /dmo/connection AS a
*      LEFT OUTER JOIN /dmo/carrier AS b
*        ON a~carrier_id = b~carrier_id
*      LEFT OUTER JOIN /dmo/airport AS dep
*        ON a~airport_from_id = dep~airport_id
*      LEFT OUTER JOIN /dmo/airport AS arr
*        ON a~airport_to_id = arr~airport_id
*      INTO TABLE @DATA(it_join2)
*      UP TO 10 ROWS.
*
*    out->write( |--- Task 2: LEFT OUTER JOIN | ).
*    LOOP AT it_join2 INTO DATA(ls_join2).
*      out->write(
*        |{ ls_join2-carrier_id }-{ ls_join2-connection_id }: { ls_join2-dep_name } → { ls_join2-arr_name } ({ ls_join2-name })| ).
*    ENDLOOP.
*
*
*
*    out->write( |--- Task 3: Optimized Single LEFT OUTER JOIN ---| ).
*    LOOP AT it_join2 INTO DATA(ls_final).
*      out->write(
*        |{ ls_final-carrier_id }-{ ls_final-connection_id }: { ls_final-dep_name } → { ls_final-arr_name } ({ ls_final-name })| ).
*    ENDLOOP.
*
* 4 - 11


    SELECT FROM /dmo/flight
    FIELDS carrier_id ,SUM( seats_max - seats_occupied ) AS suma, COUNT( * ) AS Count
    GROUP BY carrier_id
    INTO TABLE @DATA(lt_flights).

*    SELECT  SINGLE FROM /dmo/flight
*    FIELDS carrier_id, connection_id, flight_date, seats_max, seats_occupied , ( seats_max - seats_occupied ) AS seats_available
*    INTO @DATA(ls_flights).
    IF sy-subrc EQ 0.
      LOOP AT  lt_flights ASSIGNING FIELD-SYMBOL(<fs_flights>)."INTO DATA(ls_flights).
*      out->write( |{ ls_flights-carrier_id }-{ ls_flights-connection_id }:  Max Seats->{ ls_flights-seats_max } - Seats available :{ ls_flights-seats_available }| ).
        out->write( | { <fs_flights>-carrier_id } Max Seats-> { <fs_flights>-suma } - Count :{ <fs_flights>-Count }| ).
      ENDLOOP.
    ENDIF.

*
  ENDMETHOD.


  METHOD demo_lesson1_joins.


    SELECT a~carrier_id,
           a~connection_id,
           a~airport_from_id,
           a~airport_to_id,
           b~name
      FROM /dmo/connection AS a
     RIGHT OUTER JOIN /dmo/carrier   AS b
        ON a~carrier_id = b~carrier_id
      INTO TABLE @DATA(it_join_result)
      UP TO 10 ROWS.

    LOOP AT it_join_result INTO DATA(ls_row).
      out->write( |{ ls_row-carrier_id }-{ ls_row-connection_id }: { ls_row-airport_from_id } -> { ls_row-airport_to_id } ({ ls_row-name })| ).
    ENDLOOP.

  ENDMETHOD.



  METHOD demo_lesson2_aggregates.


    SELECT carrier_id,
           COUNT( * )     AS num_flights,
           AVG( distance ) AS avg_distance
      FROM /dmo/connection
      GROUP BY carrier_id
      HAVING COUNT( * ) > 3
      INTO TABLE @DATA(it_stats).

    LOOP AT it_stats INTO DATA(ls_stat).
      out->write( |Carrier { ls_stat-carrier_id }: { ls_stat-num_flights } flights, Avg. distance { ls_stat-avg_distance } km| ).
    ENDLOOP.
  ENDMETHOD.



  METHOD demo_lesson3_subqueries.

    SELECT carrier_id,
           COUNT( * ) AS num_flights,
          AVG( CAST( distance AS FLTP ) ) AS avg_distance
      FROM /dmo/connection
      GROUP BY carrier_id
      HAVING COUNT( * ) > 3
      INTO TABLE @DATA(it_stats1).

*    SORT it_stats1 BY carrier_id num_flights.

    LOOP AT it_stats1 INTO DATA(ls_stat).
      out->write( |Carrier { ls_stat-carrier_id }: { ls_stat-num_flights } flights, Avg. distance { ls_stat-avg_distance } km| ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
