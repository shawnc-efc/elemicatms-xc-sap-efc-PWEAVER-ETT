*----------------------------------------------------------------------*
***INCLUDE LZPWDELIVERYEXITI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_9002  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module USER_COMMAND_9002 input.
  READ TABLE LT_TRACK INTO LS_TRACK WITH KEY SEL = 'X'.
  IF SY-SUBRC = 0.
    MOVE LS_TRACK-TRACKING_NUMBER TO PW_itab-trackn.
    EXPORT PW_itab-trackn TO MEMORY ID 'PWTRACKTD'.
    SUBMIT zcs_call_url AND RETURN.
    endif.
endmodule.                 " USER_COMMAND_9002  INPUT


*&---------------------------------------------------------------------*
*&      Module  PW_read_table_control  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PW_read_table_control input.
    MODIFY LT_TRACK FROM LS_TRACK INDEX PWTRACK-current_line.
endmodule.                 " PW_read_table_control  INPUT

*&---------------------------------------------------------------------*
*&      Module  CANCEL  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module CANCEL input.
LEAVE TO SCREEN 0.
endmodule.                 " CANCEL  INPUT
