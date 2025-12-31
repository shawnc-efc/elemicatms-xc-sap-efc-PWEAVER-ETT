*----------------------------------------------------------------------*
***INCLUDE LZPWDELIVERYEXITO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_9002  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module STATUS_9002 output.
*  SET PF-STATUS 'xxxxxxxx'.
*  SET TITLEBAR 'xxx'.
* Get Z-Fields(LIKP) thru BADI LE_SHP_TAB_CUST_HEAD
*Method TRANSFER_DATA_TO_SUBSCREEN .
  GET PARAMETER ID 'PWDELIVERYEXIT' FIELD  PW_DELIVERY.

CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
  EXPORTING
    input         = PW_DELIVERY
 IMPORTING
   OUTPUT        = PW_DELIVERY.
          .

SELECT SINGLE VGBEL FROM LIPS INTO PW_SALESORDER WHERE VBELN = PW_DELIVERY.
  SELECT SINGLE BSTNK INTO PW_CUSTOMERPO FROM VBAK WHERE VBELN = PW_SALESORDER.



SELECT * FROM /PWEAVER/MANFEST INTO CORRESPONDING FIELDS OF TABLE LT_TRACK
              WHERE vbeln = PW_DELIVERY
              AND   CANC_DT = '00000000'.

  READ TABLE LT_TRACK INTO LS_TRACK INDEX 1.

  SELECT SINGLE description FROM /PWEAVER/CCONFIG INTO PW_CARRIERNAME WHERE lifnr = LS_TRACK-carrier_code
                  AND CARRIERTYPE = LS_TRACK-CARRIERTYPE.

     if custom_container is initial.
SELECT * FROM /PWEAVER/MANFEST INTO CORRESPONDING FIELDS OF TABLE LT_TRACK
              WHERE vbeln = PW_DELIVERY
              AND   CANC_DT = '00000000'.
  DATA ls_cellcolor TYPE lvc_s_scol .
  data track_index type i.

** create a custom container control for our ALV Control
    create object custom_container
        exporting
            container_name = cont_for_flights
        exceptions
            cntl_error = 1
            cntl_system_error = 2
            create_error = 3
            lifetime_error = 4
            lifetime_dynpro_dynpro_link = 5.
    if sy-subrc ne 0.
* add your handling, for example
      call function 'POPUP_TO_INFORM'
           exporting
                titel = g_repid
                txt2  = sy-subrc
                txt1  = 'The control could not be created'(510).
    endif.
* create an instance of alv control
    create object grid1
         exporting i_parent = custom_container.
*
* Set a titlebar for the grid control
    PERFORM prepare_field_catalog CHANGING gt_fieldcat .
    gs_layout-grid_title = 'Shipment Tracking Details'(100).

    call method grid1->set_table_for_first_display
         exporting i_structure_name = 'LT_TRACK'
                   is_layout        = gs_layout

         changing  it_outtab        = LT_TRACK[]
           it_fieldcatalog = gt_fieldcat.

********
* ->Create Object to receive events and link them to handler methods.
* When the ALV Control raises the event for the specified instance
* the corresponding method is automatically called.
*
    create object event_receiver.
    set handler event_receiver->handle_hotspot_click for grid1.
*
********

  endif.                               "IF custom_container IS INITIAL
  call method cl_gui_control=>set_focus exporting control = grid1.

endmodule.                 " STATUS_9002  OUTPUT


*----------------------------------------------------------------------*
***INCLUDE LZPWDELIVERYEXITO02 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_9003  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module STATUS_9003 output.
  SET PF-STATUS 'PWTRACK'.
*  SET TITLEBAR 'xxx'.

  IF init IS INITIAL.
    init = 'X'.
    CREATE OBJECT:
    container EXPORTING container_name = 'PICTURE_CONTAINER'.

    CALL METHOD c_oi_container_control_creator=>get_document_viewer
      IMPORTING
        viewer = document_viewer.

    CALL METHOD document_viewer->init_viewer
      EXPORTING
        parent = container.
  ENDIF.


  CALL METHOD document_viewer->view_document_from_url
    EXPORTING
      document_url = pw_url
      show_inplace = 'X'.



endmodule.                 " STATUS_9003  OUTPUT
