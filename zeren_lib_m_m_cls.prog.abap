*&---------------------------------------------------------------------*
*& Include          ZEREN_AYAR_032_CLS
*&---------------------------------------------------------------------*
CLASS l_cls_lib_member DEFINITION.      "LCL_IKRAMIYE
  PUBLIC SECTION.
    METHODS: display_alv,
      get_data,
      set_fcat,
      set_layout,
      add_user,
      delete_user,
      freeze_user,
      set_fcat2,
      set_layout2,
      display_alv2,
      get_data2,
      give_book,
      set_fcat3,
      set_layout3,
      display_alv3,
      get_data3,
      return_book_menu,
      return_book.
ENDCLASS.

CLASS l_cls_lib_member IMPLEMENTATION.
  METHOD display_alv.
    IF go_alv IS INITIAL.
      CREATE OBJECT go_cont
        EXPORTING
          container_name = 'CC_ALV'.

      CREATE OBJECT go_alv
        EXPORTING
          i_parent = go_cont.

      CALL METHOD go_alv->set_table_for_first_display
        EXPORTING
          i_structure_name = 'GS_MEMBER'
          is_layout        = gs_layout              " Layout
        CHANGING
          it_outtab        = gt_member  " Output Table
          it_fieldcatalog  = gt_fcat        " Field Catalog
          it_sort          = gt_sort.
    ELSE.
      CALL METHOD go_alv->refresh_table_display.
    ENDIF.
    "CALL SCREEN 0100.
  ENDMETHOD.
  METHOD get_data.
    SELECT * FROM zeren_lib_member
    INTO CORRESPONDING FIELDS OF TABLE gt_member
    WHERE zeren_lib_is_p <> 'X'.
  ENDMETHOD.
  METHOD set_fcat.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZEREN_LIB_MEM_S_001'
      CHANGING
        ct_fieldcat      = gt_fcat.
  ENDMETHOD.
  METHOD set_layout.
    CLEAR: gs_layout.
    gs_layout-zebra = abap_true.
    gs_layout-sel_mode  = 'A'.
  ENDMETHOD.
  METHOD add_user.
    DATA: ls_user    TYPE zeren_lib_member,
          lv_counter TYPE int4 VALUE 0.
    LOOP AT gt_member ASSIGNING <gfs_member>.
      IF <gfs_member>-zeren_lib_user_id = i_user_id.
        lv_counter = 1.
      ENDIF.
    ENDLOOP.
    IF lv_counter <> 1.
      CLEAR: gs_member.
      gs_member-zeren_lib_user_id = i_user_id.
      gs_member-zeren_lib_user_name = i_user_name.
      gs_member-zeren_lib_user_sname = i_user_surname.
      APPEND gs_member TO gt_member.
      ls_user-zeren_lib_user_id = i_user_id.
      ls_user-zeren_lib_user_name = i_user_name.
      ls_user-zeren_lib_user_sname = i_user_surname.
      ls_user-zeren_lib_is_p = ''.
      INSERT zeren_lib_member FROM ls_user.
      CALL METHOD go_alv->refresh_table_display.
    ELSE.
      MESSAGE 'You can not add an existing user!' TYPE 'I'.
    ENDIF.
  ENDMETHOD.
  METHOD delete_user.
    DATA: lt_rows   TYPE lvc_t_row,
          ls_row    TYPE lvc_s_row,
          lv_index  TYPE sy-tabix,
          ls_member TYPE zeren_lib_mem_s_001,
          lv_mess   TYPE char300.
    CALL METHOD go_alv->get_selected_rows
      IMPORTING
        et_index_rows = lt_rows.
    IF lt_rows IS NOT INITIAL.
      READ TABLE lt_rows INTO ls_row INDEX 1.
      lv_index = ls_row-index.
      READ TABLE gt_member INTO ls_member INDEX lv_index.
      DELETE gt_member INDEX lv_index.
      DELETE FROM zeren_lib_member WHERE zeren_lib_user_id = ls_member-zeren_lib_user_id.
      CALL METHOD go_alv->refresh_table_display.
      CONCATENATE 'This member is deleted from database.'
                    'ID:'
                    ls_member-zeren_lib_user_id
                    'Name:'
                    ls_member-zeren_lib_user_name
                    'Surname:'
                    ls_member-zeren_lib_user_sname
                    INTO lv_mess SEPARATED BY space.
    ENDIF.
  ENDMETHOD.
  METHOD freeze_user.
    DATA: lt_rows   TYPE lvc_t_row,
          ls_row    TYPE lvc_s_row,
          lv_index  TYPE sy-tabix,
          ls_member TYPE zeren_lib_mem_s_001,
          ls_m_t    TYPE zeren_lib_member,
          lv_mess   TYPE char300.
    CALL METHOD go_alv->get_selected_rows
      IMPORTING
        et_index_rows = lt_rows.
    IF lt_rows IS NOT INITIAL.
      READ TABLE lt_rows INTO ls_row INDEX 1.
      lv_index = ls_row-index.
      READ TABLE gt_member INTO ls_member INDEX lv_index.
      LOOP AT gt_member ASSIGNING <gfs_member>.
        IF <gfs_member>-zeren_lib_user_id = ls_member-zeren_lib_user_id.
          <gfs_member>-zeren_lib_is_p = 'X'.
          CLEAR ls_m_t.
          ls_m_t-zeren_lib_user_id = <gfs_member>-zeren_lib_user_id.
          ls_m_t-zeren_lib_user_name = <gfs_member>-zeren_lib_user_name.
          ls_m_t-zeren_lib_user_sname = <gfs_member>-zeren_lib_user_sname.
          ls_m_t-zeren_lib_is_p = <gfs_member>-zeren_lib_is_p.
          UPDATE zeren_lib_member FROM ls_m_t.
          IF sy-subrc = 0.
            COMMIT WORK.
*          ELSE.
*            MESSAGE 'Update failed!' TYPE 'E'.
          ENDIF.
        ENDIF.
      ENDLOOP.
      CALL METHOD go_alv->refresh_table_display.
      CONCATENATE 'This member is now a passive member.'
                    'ID:'
                    ls_member-zeren_lib_user_id
                    'Name:'
                    ls_member-zeren_lib_user_name
                    'Surname:'
                    ls_member-zeren_lib_user_sname
                    INTO lv_mess SEPARATED BY space.
    ENDIF.
    MESSAGE lv_mess TYPE 'I'.
  ENDMETHOD.

  METHOD display_alv2.
    IF go_alv2 IS INITIAL.
      CREATE OBJECT go_cont2
        EXPORTING
          container_name = 'CC_ALV2'.

      CREATE OBJECT go_alv2
        EXPORTING
          i_parent = go_cont2.

      CALL METHOD go_alv2->set_table_for_first_display
        EXPORTING
          i_structure_name = 'GS_BOOK'
          is_layout        = gs_layout2              " Layout
        CHANGING
          it_outtab        = gt_book  " Output Table
          it_fieldcatalog  = gt_fcat2        " Field Catalog
          it_sort          = gt_sort2.
    ELSE.
      CALL METHOD go_alv2->refresh_table_display.
    ENDIF.
    "CALL SCREEN 0200.
  ENDMETHOD.
  METHOD get_data2.
    SELECT *
      FROM zeren_lib_book AS book
      WHERE NOT EXISTS (
        SELECT *
          FROM zeren_lib_borrow AS borrow
          WHERE borrow~zeren_lib_book_id = book~zeren_lib_book_id )
      INTO CORRESPONDING FIELDS OF TABLE @gt_book.
  ENDMETHOD.
  METHOD set_fcat2.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZEREN_LIB_BOOK_S_001'
      CHANGING
        ct_fieldcat      = gt_fcat2.
  ENDMETHOD.
  METHOD set_layout2.
    CLEAR: gs_layout2.
    gs_layout2-zebra = abap_true.
    gs_layout2-sel_mode  = 'A'.
  ENDMETHOD.
  METHOD give_book.
    DATA: lv_mem_id   TYPE char10,
          lv_counter  TYPE int4 VALUE 0,
          ls_borrow_t TYPE zeren_lib_borrow,
          lt_rows     TYPE lvc_t_row,
          ls_row      TYPE lvc_s_row,
          lv_index    TYPE sy-tabix,
          ls_book     TYPE zeren_lib_book_s_001,
          lv_today    TYPE dats,
          lv_mess     TYPE char200.
    lv_today = sy-datum.
    CALL METHOD go_alv2->get_selected_rows
      IMPORTING
        et_index_rows = lt_rows.
    IF lt_rows IS NOT INITIAL.
      READ TABLE lt_rows INTO ls_row INDEX 1.
      lv_index = ls_row-index.
      READ TABLE gt_book INTO ls_book INDEX lv_index.
      LOOP AT gt_member ASSIGNING <gfs_member>.
        IF <gfs_member>-zeren_lib_user_id = i_give_mem.
          lv_counter = 1.
        ENDIF.
      ENDLOOP.
      IF lv_counter = 0.
        MESSAGE 'Member is not found' TYPE 'I'.
      ELSE.
        LOOP AT gt_member ASSIGNING <gfs_member>.
          IF <gfs_member>-zeren_lib_user_id = i_give_mem.
            ls_borrow_t-zeren_lib_user_id = i_give_mem.
            ls_borrow_t-zeren_lib_book_id = ls_book-zeren_lib_book_id.
            ls_borrow_t-zeren_lib_bdate = lv_today.
*            ls_borrow_t-zeren_lib_rdate = '99999999'.
            INSERT zeren_lib_borrow FROM ls_borrow_t.
          ENDIF.
        ENDLOOP.
        CONCATENATE 'Book '
                    ls_book-zeren_lib_book_id
                    'borrowed by '
                    i_give_mem
                    INTO lv_mess SEPARATED BY space.
        MESSAGE lv_mess TYPE 'I'.
      ENDIF.
    ENDIF.

  ENDMETHOD.
  METHOD display_alv3.
    IF go_alv3 IS INITIAL.
      CREATE OBJECT go_cont3
        EXPORTING
          container_name = 'CC_ALV3'.

      CREATE OBJECT go_alv3
        EXPORTING
          i_parent = go_cont3.

      CALL METHOD go_alv3->set_table_for_first_display
        EXPORTING
          i_structure_name = 'GS_BORROW'
          is_layout        = gs_layout3              " Layout
        CHANGING
          it_outtab        = gt_borrow  " Output Table
          it_fieldcatalog  = gt_fcat3        " Field Catalog
          it_sort          = gt_sort3.
    ELSE.
      CALL METHOD go_alv3->refresh_table_display.
    ENDIF.
    "CALL SCREEN 0100.
  ENDMETHOD.
  METHOD set_fcat3.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZEREN_LIB_OWNER_S_001'
      CHANGING
        ct_fieldcat      = gt_fcat3.
  ENDMETHOD.
  METHOD set_layout3.
    CLEAR: gs_layout3.
    gs_layout3-zebra = abap_true.
    gs_layout3-sel_mode  = 'A'.
  ENDMETHOD.
  METHOD get_data3.
    SELECT * FROM zeren_lib_borrow INTO CORRESPONDING FIELDS OF TABLE gt_borrow.
  ENDMETHOD.
  METHOD return_book_menu.
    DATA: lt_rows   TYPE lvc_t_row,
          ls_row    TYPE lvc_s_row,
          lv_index  TYPE sy-tabix,
          ls_member TYPE zeren_lib_mem_s_001,
          lv_mess   TYPE char300,
          lv_found  TYPE char1 VALUE 0.
    CALL METHOD go_alv->get_selected_rows
      IMPORTING
        et_index_rows = lt_rows.
    IF lt_rows IS NOT INITIAL.
      READ TABLE lt_rows INTO ls_row INDEX 1.
      lv_index = ls_row-index.
      READ TABLE gt_member INTO ls_member INDEX lv_index.
      LOOP AT gt_borrow ASSIGNING <gfs_borrow>.
        IF <gfs_borrow>-zeren_lib_user_id = ls_member-zeren_lib_user_id.
          lv_found = 1.
        ENDIF.
      ENDLOOP.
      IF lv_found = 1.
        SELECT * FROM zeren_lib_borrow
            WHERE zeren_lib_borrow~zeren_lib_user_id = @ls_member-zeren_lib_user_id
          INTO CORRESPONDING FIELDS OF TABLE @gt_borrow.
        CALL SCREEN 0300.
      ELSE.
        MESSAGE 'User has no books borrowed!' TYPE 'I'.
      ENDIF.
    ENDIF.
  ENDMETHOD.
  METHOD return_book.
    DATA: lt_rows  TYPE lvc_t_row,
          ls_row   TYPE lvc_s_row,
          lv_index TYPE sy-tabix,
          ls_owner TYPE zeren_lib_owner_s_001,
          lv_mess  TYPE char300,
          lv_found TYPE char1 VALUE 0,
          ls_b_t   TYPE zeren_lib_borrow,
          lv_today TYPE dats.
    lv_today = sy-datum.
    CALL METHOD go_alv->get_selected_rows
      IMPORTING
        et_index_rows = lt_rows.
    IF lt_rows IS NOT INITIAL.
      READ TABLE lt_rows INTO ls_row INDEX 1.
      lv_index = ls_row-index.
      READ TABLE gt_borrow INTO ls_owner INDEX lv_index.
      LOOP AT gt_borrow ASSIGNING <gfs_borrow>.
        IF <gfs_borrow>-zeren_lib_user_id = ls_owner-zeren_lib_user_id AND
          <gfs_borrow>-zeren_lib_book_id = ls_owner-zeren_lib_book_id AND
          <gfs_borrow>-zeren_lib_rdate = '00000000'.
          CLEAR ls_b_t.
          ls_b_t-zeren_lib_user_id = <gfs_borrow>-zeren_lib_user_id.
          ls_b_t-zeren_lib_book_id = <gfs_borrow>-zeren_lib_book_id.
          ls_b_t-zeren_lib_bdate = <gfs_borrow>-zeren_lib_bdate.
          ls_b_t-zeren_lib_rdate = lv_today.
          UPDATE zeren_lib_borrow FROM ls_b_t.
          IF sy-subrc = 0.
            COMMIT WORK.
            CALL METHOD go_alv3->refresh_table_display.
          ELSE.
            MESSAGE 'Update failed!' TYPE 'E'.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.
ENDCLASS.







*CLASS lcl_event_handler DEFINITION.
*  PUBLIC SECTION.
*    METHODS: hotspot_click_handler
*      FOR EVENT hotspot_click OF cl_gui_alv_grid
*      IMPORTING es_row_no.
*
*ENDCLASS.


*CLASS lcl_event_handler IMPLEMENTATION.
*  METHOD hotspot_click_handler.
*    DATA: ls_member  TYPE zeren_lib_mem_s_001,
*          lv_counter TYPE int4 VALUE 0,
*          lv_mess    TYPE char200.
*    READ TABLE gt_member INTO ls_member INDEX es_row_no-row_id.
*    LOOP AT gt_member ASSIGNING <gfs_member>.
*      IF <gfs_member>-zeren_lib_user_id = ls_member-zeren_lib_user_id.
*        lv_counter = 1.
*      ENDIF.
*    ENDLOOP.
*    IF lv_counter = 1.
*      DELETE gt_member WHERE zeren_lib_user_id = ls_member-zeren_lib_user_id.
*      DELETE FROM zeren_lib_member WHERE zeren_lib_user_id = ls_member-zeren_lib_user_id.
*      CONCATENATE 'This member is deleted from database.'
*                  'ID:'
*                  ls_member-zeren_lib_user_id
*                  'Name:'
*                  ls_member-zeren_lib_user_name
*                  'Surname:'
*                  ls_member-zeren_lib_user_sname
*                  INTO lv_mess SEPARATED BY space.
*    ELSE.
*      lv_mess = 'There is no user with ID' + ls_member-zeren_lib_user_id.
*    ENDIF.
*    MESSAGE lv_mess TYPE 'I'.
*    CALL METHOD go_alv->refresh_table_display.
*  ENDMETHOD.
*ENDCLASS.
