CLASS zcl_atc_test_01_bl DEFINITION PUBLIC CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS :
      calculate_duration IMPORTING iv_departure       TYPE i "hora salida
                                   iv_arrival         TYPE i " hora llegada
                         RETURNING VALUE(rv_duration) TYPE i, "duracion
      inst_object        RETURNING VALUE(ri_cal) TYPE REF TO zcl_atc_test_01_bl.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_atc_test_01_bl IMPLEMENTATION.
  METHOD calculate_duration.
    rv_duration = ( ( iv_arrival DIV 100 ) * 60 + ( iv_arrival MOD 100 ) ) - (  ( iv_departure DIV 100 ) * 60 + ( iv_departure MOD 100 ) ) .
  ENDMETHOD.

  METHOD inst_object.
    ri_cal =  new zcl_atc_test_01_bl( ).
  ENDMETHOD.

ENDCLASS.
