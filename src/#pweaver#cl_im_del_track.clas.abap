class /PWEAVER/CL_IM_DEL_TRACK definition
  public
  final
  create public .

*"* public components of class /PWEAVER/CL_IM_DEL_TRACK
*"* do not include other source files here!!!
public section.

  interfaces IF_EX_LE_SHP_TAB_CUST_HEAD .
protected section.
*"* protected components of class /PWEAVER/CL_IM_DEL_TRACK
*"* do not include other source files here!!!
private section.
*"* private components of class /PWEAVER/CL_IM_DEL_TRACK
*"* do not include other source files here!!!
ENDCLASS.



CLASS /PWEAVER/CL_IM_DEL_TRACK IMPLEMENTATION.


method IF_EX_LE_SHP_TAB_CUST_HEAD~ACTIVATE_TAB_PAGE.
  ef_caption = 'ECS Tracking'.
  ef_program = '/PWEAVER/SAPLETT_V1'.
  ef_dynpro = '9002'.
endmethod.


method IF_EX_LE_SHP_TAB_CUST_HEAD~PASS_FCODE_TO_SUBSCREEN.
endmethod.


method IF_EX_LE_SHP_TAB_CUST_HEAD~TRANSFER_DATA_FROM_SUBSCREEN.
endmethod.


method IF_EX_LE_SHP_TAB_CUST_HEAD~TRANSFER_DATA_TO_SUBSCREEN.
  SET PARAMETER ID 'PWDELIVERYEXIT' FIELD IS_LIKP-VBELN.
endmethod.
ENDCLASS.
