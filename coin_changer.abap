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
    me->assert_change_for_value( act = 1 exp = VALUE #( ( 1 ) ) ).
    me->assert_change_for_value( act = 2 exp = VALUE #( ( 1 ) ( 1 ) ) ).
    me->assert_change_for_value( act = 5 exp = VALUE #( ( 5 ) ) ).
    me->assert_change_for_value( act = 6 exp = VALUE #( ( 5 ) ( 1 ) ) ).
    me->assert_change_for_value( act = 10 exp = VALUE #( ( 10 ) ) ).
    me->assert_change_for_value( act = 24 exp = VALUE #( ( 10 ) ( 10 ) ( 1 ) ( 1 ) ( 1 ) ( 1 ) ) ).
    me->assert_change_for_value( act = 25 exp = VALUE #( ( 25 ) ) ).
    me->assert_change_for_value( act = 49 exp = VALUE #( ( 25 ) ( 10 ) ( 10 ) ( 1 ) ( 1 ) ( 1 ) ( 1 ) ) ).
    me->assert_change_for_value( act = 50 exp = VALUE #( ( 50 ) ) ).
    me->assert_change_for_value( act = 99 exp = VALUE #( ( 50 ) ( 25 ) ( 10 ) ( 10 ) ( 1 ) ( 1 ) ( 1 ) ( 1 ) ) ).
    me->assert_change_for_value( act = 100 exp = VALUE #( ( 100 ) ) ).
    me->assert_change_for_value( act = 199 exp = VALUE #( ( 100 ) ( 50 ) ( 25 ) ( 10 ) ( 10 ) ( 1 ) ( 1 ) ( 1 ) ( 1 ) ) ).
  ENDMETHOD.
 
ENDCLASS.
 
CLASS lcl_coin_changer IMPLEMENTATION.
 
  METHOD change_for.
    DATA(amount)  = iv_amount.
    DATA(coins) = VALUE tty_i( ( 100 ) ( 50 ) ( 25 ) ( 10 ) ( 5 ) ( 1 ) ).
 
    LOOP AT coins INTO DATA(coin).
      WHILE amount >= coin.
        APPEND coin TO rt_coins.
        amount = amount - coin.
      ENDWHILE.
    ENDLOOP.
 
  ENDMETHOD.
 
ENDCLASS.