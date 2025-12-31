FUNCTION-POOL /PWEAVER/ETT_V1.              "MESSAGE-ID ..



TYPE-POOLS: slis.
DATA test(10) TYPE c.

DATA: pw_delivery TYPE likp-vbeln,
      pw_salesorder TYPE vbak-vbeln,
      PW_CUSTOMERPO TYPE VBAK-BSTNK,
      PW_CARRIERNAME(40) TYPE C.

DATA: BEGIN OF ls_track,
  cellcolors TYPE lvc_t_scol ,
    SEL(1),
      date_added LIKE /PWEAVER/MANFEST-date_added,
  handling_unit LIKE /PWEAVER/MANFEST-handling_unit,
  carrier_code LIKE /PWEAVER/MANFEST-carrier_code,
  tracking_number    LIKE /PWEAVER/MANFEST-tracking_number ,
  pod_signature LIKE /PWEAVER/MANFEST-pod_signature,
   pod_date LIKE /PWEAVER/MANFEST-pod_date,
    pod_time LIKE /PWEAVER/MANFEST-pod_time,
  carriertype like /PWEAVER/MANFEST-carriertype,

  END OF ls_track.

DATA: lt_track LIKE TABLE OF ls_track with HEADER LINE.

DATA : BEGIN OF PW_itab OCCURS 0,
       trackn(25) TYPE c,
       END OF PW_itab.

CONTROLS: pwtrack TYPE TABLEVIEW USING SCREEN 9002.


DATA: PW_url(200) TYPE c .
TYPES pict_line(256) TYPE c.
DATA :init,

container TYPE REF TO cl_gui_custom_container,
editor TYPE REF TO cl_gui_textedit,
picture TYPE REF TO cl_gui_picture,
pict_tab TYPE TABLE OF pict_line,
document_viewer TYPE REF TO i_oi_document_viewer.


class lcl_event_receiver definition deferred.


data:
      g_max type i value 100,
      g_repid like sy-repid,
      gs_layout   type lvc_s_layo,
      cont_for_flights   type scrfname value 'PWTRACKALV',
      grid1  type ref to cl_gui_alv_grid,
      custom_container type ref to cl_gui_custom_container,
      grid2  type ref to cl_gui_alv_grid,
      event_receiver type ref to lcl_event_receiver.

DATA gt_fieldcat TYPE lvc_t_fcat .
*----------------------------------------------------------------------*
*       CLASS lcl_event_receiver DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_event_receiver definition.

  public section.
    methods:
handle_hotspot_click
FOR EVENT hotspot_click OF cl_gui_alv_grid
IMPORTING e_row_id e_column_id es_row_no .

endclass.                    "lcl_event_receiver DEFINITION


*----------------------------------------------------------------------*
*       CLASS lcl_event_receiver IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_event_receiver implementation.
  method handle_hotspot_click.
    CLEAR PW_URL.
* read selected row from internal table gt_sflight
    read table LT_TRACK  index e_row_id-index into ls_TRACK.
    IF SY-SUBRC = 0.
      if ls_track-carriertype = 'UPS'.
        CONCATENATE 'http://wwwapps.ups.com/WebTracking/processInputRequest?tracknum=' ls_track-tracking_number INTO pw_url.
      ELSEIF ls_track-carriertype = 'FEDEX'.
        CONCATENATE 'https://www.fedex.com/fedextrack/?trknbr=' ls_track-tracking_number
         INTO PW_url.
         ELSEIF ls_track-carriertype = 'TNT'.
        CONCATENATE 'http://www.tnt.com/webtracker/tracking.do?requestType=GEN&searchType=CON&respLang=en&respCountry=GENERIC&sourceID=1&sourceCountry=ww&cons=' ls_track-tracking_number  '&navigation=1&genericSiteIdent='
         INTO PW_url.
           ELSEIF ls_track-carriertype = 'DHL'.
        CONCATENATE 'http://www.dhl-usa.com/content/us/en/express/tracking.shtml?brand=DHL&AWB=' ls_track-tracking_number
         INTO PW_url.

      ENDIF.
      call screen 9003.
    endif.
  endmethod.                    "handle_hotspot_click
endclass.                    "lcl_event_receiver IMPLEMENTATION
