*&---------------------------------------------------------------------*
*& Include          ZEREN_AYAR_032_TOP
*&---------------------------------------------------------------------*

DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat,
      gt_sort TYPE lvc_t_sort,
      gs_sort TYPE lvc_s_sort.
DATA: go_alv    TYPE REF TO cl_gui_alv_grid,
      go_cont   TYPE REF TO cl_gui_custom_container,
      gs_layout TYPE lvc_s_layo.
DATA: gt_member TYPE TABLE OF ZEREN_LIB_MEM_S_001,
      gs_member TYPE ZEREN_LIB_MEM_S_001.
FIELD-SYMBOLS: <gfs_fc> TYPE lvc_s_fcat,
               <gfs_member> TYPE ZEREN_LIB_MEM_S_001.

DATA: gt_fcat2 TYPE lvc_t_fcat,
      gs_fcat2 TYPE lvc_s_fcat,
      gt_sort2 TYPE lvc_t_sort,
      gs_sort2 TYPE lvc_s_sort.
DATA: go_alv2    TYPE REF TO cl_gui_alv_grid,
      go_cont2   TYPE REF TO cl_gui_custom_container,
      gs_layout2 TYPE lvc_s_layo.
DATA: gt_book TYPE TABLE OF ZEREN_LIB_BOOK_S_001,
      gs_book TYPE ZEREN_LIB_BOOK_S_001.
FIELD-SYMBOLS: <gfs_fc2> TYPE lvc_s_fcat,
               <gfs_book> TYPE ZEREN_LIB_BOOK_S_001.

DATA: gt_fcat3 TYPE lvc_t_fcat,
      gs_fcat3 TYPE lvc_s_fcat,
      gt_sort3 TYPE lvc_t_sort,
      gs_sort3 TYPE lvc_s_sort.
DATA: go_alv3    TYPE REF TO cl_gui_alv_grid,
      go_cont3   TYPE REF TO cl_gui_custom_container,
      gs_layout3 TYPE lvc_s_layo.
DATA: gt_borrow TYPE TABLE OF ZEREN_LIB_OWNER_S_001,
      gt_borrow2 TYPE TABLE OF ZEREN_LIB_OWNER_S_001,
      gs_borrow TYPE ZEREN_LIB_OWNER_S_001.
FIELD-SYMBOLS: <gfs_fc3> TYPE lvc_s_fcat,
               <gfs_borrow> TYPE ZEREN_LIB_OWNER_S_001.

CLASS l_cls_lib_member DEFINITION DEFERRED.
DATA: go_main TYPE REF TO l_cls_lib_member.
*Dropdown toolbar tanımlaması
DATA: gt_dropdown TYPE vrm_values,
      gs_dropdown TYPE vrm_value.
DATA: DD_OPT TYPE char1 .

DATA: I_USER_ID TYPE char10,
      I_USER_NAME TYPE CHAR20,
      I_USER_SURNAME TYPE char20.

DATA: i_give_mem TYPE char10.

DATA: gv_delete_mode TYPE abap_bool VALUE abap_false.
