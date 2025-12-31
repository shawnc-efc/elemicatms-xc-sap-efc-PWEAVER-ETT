*----------------------------------------------------------------------*
***INCLUDE LZPWDELIVERYEXITF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  prepare_field_catalog
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GT_FIELDCAT  text
*----------------------------------------------------------------------*
FORM prepare_field_catalog CHANGING pt_fieldcat TYPE lvc_t_fcat .

DATA ls_fcat type lvc_s_fcat .
ls_fcat-fieldname = 'DATE_ADDED' .
*ls_fcat-inttype = 'C' .
ls_fcat-outputlen = '10' .
ls_fcat-coltext = 'Ship Date' .
ls_fcat-seltext = 'Ship Date' .
APPEND ls_fcat to pt_fieldcat .
CLEAR ls_fcat .

*DATA ls_fcat type lvc_s_fcat .
ls_fcat-fieldname = 'HANDLING_UNIT' .
*ls_fcat-inttype = 'C' .
ls_fcat-outputlen = '25' .
ls_fcat-coltext = 'Handling Unit' .
ls_fcat-seltext = 'Handling Unit' .
APPEND ls_fcat to pt_fieldcat .
CLEAR ls_fcat .

ls_fcat-fieldname = 'TRACKING_NUMBER' .
*ls_fcat-inttype = 'C' .
ls_fcat-outputlen = '25' .
ls_fcat-coltext = 'Tracking Number' .
ls_fcat-seltext = 'Tracking Number' .
ls_fcat-HOTSPOT = 'X'.
ls_fcat-EMPHASIZE = 'C511'.
APPEND ls_fcat to pt_fieldcat .
CLEAR ls_fcat .

ls_fcat-fieldname = 'POD_SIGNATURE' .
*ls_fcat-inttype = 'C' .
ls_fcat-outputlen = '25' .
ls_fcat-coltext = 'POD Signature' .
ls_fcat-seltext = 'POD Signature' .
APPEND ls_fcat to pt_fieldcat .
CLEAR ls_fcat .

ls_fcat-fieldname = 'POD_DATE' .
*ls_fcat-inttype = 'C' .
ls_fcat-outputlen = '12' .
ls_fcat-coltext = 'POD Date'.
ls_fcat-seltext = 'POD Date'.
APPEND ls_fcat to pt_fieldcat .
CLEAR ls_fcat .

ls_fcat-fieldname = 'POD_TIME' .
*ls_fcat-inttype = 'C' .
ls_fcat-outputlen = '12' .
ls_fcat-coltext = 'POD Time'.
ls_fcat-seltext = 'POD Time'.
APPEND ls_fcat to pt_fieldcat .
CLEAR ls_fcat .

ENDFORM .                 " prepare_field_catalog
