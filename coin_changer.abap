CLASS lcl_coin_changer DEFINITION.
 
  PUBLIC SECTION.
    TYPES tty_i TYPE TABLE OF i WITH EMPTY KEY.
    CLASS-METHODS change_for
      IMPORTING
        iv_amount       TYPE i
      RETURNING
        VALUE(rt_coins) TYPE tty_i.
ENDCLASS.
 
CLASS ltc_coin_changer DEFINITION FOR TESTING
  INHERITING FROM cl_aunit_assert
  RISK LEVEL DANGEROUS DURATION SHORT.
 
  PRIVATE SECTION.
    TYPES tty_i TYPE lcl_coin_changer=>tty_i.
    METHODS assert_change_for_value
      IMPORTING
        !act TYPE i
        !exp TYPE tty_i.
 
    METHODS:
      change_scenarios FOR TESTING.
 
ENDCLASS.
 
CLASS ltc_coin_changer IMPLEMENTATION.
 
  METHOD assert_change_for_value.
    DATA(lv_msg) = |on change for value { act }|.
    me->assert_equals( act = lcl_coin_changer=>change_for( act ) exp = exp quit = no msg = lv_msg ).
  ENDMETHOD.
 
  METHOD change_scenarios.
    me->assert_change_for_value( act = 0 exp = VALUE #( ) ).
  ENDMETHOD.
 
ENDCLASS.
 
CLASS lcl_coin_changer IMPLEMENTATION.
 
  METHOD change_for.
    "Change code goes here
  ENDMETHOD.
 
ENDCLASS.