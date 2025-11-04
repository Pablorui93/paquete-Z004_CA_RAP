CLASS zcl_u2_demos DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
    METHODS:
      demo_lesson1_types
        IMPORTING out TYPE REF TO if_oo_adt_classrun_out,
      demo_lesson2_conversions
        IMPORTING out TYPE REF TO if_oo_adt_classrun_out,
      demo_lesson3_calculations
        IMPORTING out TYPE REF TO if_oo_adt_classrun_out,
      demo_lesson4_system_info
        IMPORTING out TYPE REF TO if_oo_adt_classrun_out
        RAISING
                  cx_abap_context_info_error.
ENDCLASS.


CLASS zcl_u2_demos IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    demo_lesson1_types( out ).
    demo_lesson2_conversions( out ).
    demo_lesson3_calculations( out ).
    TRY.
        demo_lesson4_system_info( out ).
      CATCH cx_abap_context_info_error.
        "handle exception
    ENDTRY.
  ENDMETHOD.


  METHOD demo_lesson1_types.
    out->write( |--- Lesson 1: Understanding Data Types ---| ).

    DATA lv_char   TYPE c LENGTH 5 VALUE '12345'.
    DATA lv_numc   TYPE n LENGTH 5 VALUE '00042'.
    DATA lv_int    TYPE i VALUE 42.
    DATA lv_dec    TYPE decfloat16 VALUE '123.45'.

    out->write( |Char: { lv_char }| ).
    out->write( |Numc: { lv_numc }| ).
    out->write( |Int: { lv_int }| ).
    out->write( |DecFloat: { lv_dec }| ).
  ENDMETHOD.


  METHOD demo_lesson2_conversions.
    out->write( |--- Lesson 2: Converting Data Types ---| ).

    DATA(lv_text) = '123'.
    DATA(lv_int)  = CONV i( lv_text ).
    out->write( |Texto { lv_text } convertido a entero: { lv_int }| ).

    TRY.
        DATA(lv_fail) = EXACT i( 'ABC' ).
      CATCH cx_sy_conversion_no_number INTO DATA(lx).
        out->write( |Conversión fallida con EXACT: { lx->get_text( ) }| ).
    ENDTRY.
  ENDMETHOD.


  METHOD demo_lesson3_calculations.
    out->write( |--- Lesson 3: Performing Calculations ---| ).

    DATA lv_packed   TYPE p DECIMALS 2 VALUE '10.00'.
    DATA lv_int      TYPE i VALUE 3.
    DATA lv_result_p TYPE p DECIMALS 2.
    DATA lv_result_d TYPE decfloat16.

    " Cálculo con tipo P
    lv_result_p = lv_packed / lv_int.
    out->write( |Resultado con tipo P: { lv_result_p }| ).

    " Cálculo con decfloat16
    lv_result_d = CONV decfloat16( lv_packed ) / lv_int.
    out->write( |Resultado con decfloat16: { lv_result_d }| ).
  ENDMETHOD.

  METHOD demo_lesson4_system_info.

    DATA : var_date        TYPE d,
           var_time_system TYPE t,
           time_zone       TYPE  c LENGTH 6.


    var_date = cl_abap_context_info=>get_system_date( ).
    var_time_system = cl_abap_context_info=>get_system_time( ).
    time_zone =  cl_abap_context_info=>get_user_time_zone( ).

    out->write( var_date ).
    out->write( var_time_system ).
    out->write( time_zone ).
    out->write( utclong_current( ) ).
    out->write( cl_abap_context_info=>get_system_date( ) ).

  ENDMETHOD.

ENDCLASS.

