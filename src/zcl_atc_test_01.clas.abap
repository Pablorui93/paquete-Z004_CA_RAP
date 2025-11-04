

CLASS zcl_atc_test_01 DEFINITION FINAL FOR TESTING PUBLIC
  DURATION SHORT RISK LEVEL HARMLESS.
  "@testing ZCL_ATC_TEST_01_BL
  PRIVATE SECTION.
    METHODS:
      calculate_duration FOR TESTING RAISING cx_static_check,
      inst_object        FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS zcl_atc_test_01 IMPLEMENTATION.

  METHOD calculate_duration.
    DATA lv_calculate_val TYPE i.
    DATA(lo_cal) = NEW zcl_atc_test_01_bl( ).

    lv_calculate_val =  lo_cal->calculate_duration( iv_departure = 800
                                                    iv_arrival  =  1200
                                                  ).
    IF lv_calculate_val >= 0.
*       cl_abap_unit_assert=>fail( msg = | Error: La duracion no es negativa -> el valor fue : { lv_calculate_val }  | ).
    ENDIF.


    cl_abap_unit_assert=>assert_equals( act = lv_calculate_val exp = 241 msg = 'La duración es 240.'(001) ).

  ENDMETHOD.

  METHOD inst_object.
    DATA : lo_cal TYPE REF TO zcl_atc_test_01_bl.

*  lo_cal =  new zcl_atc_test_01_bl( ).
*    data(lo_cal) = new zcl_atc_test_01_bl( ).

    cl_abap_unit_assert=>assert_bound( act = lo_cal
                                       msg = 'Object is not bound.' ).

  ENDMETHOD.

ENDCLASS.
