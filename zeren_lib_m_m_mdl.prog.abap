MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.

  CLEAR sy-ucomm.

  go_main->set_fcat( ).
  go_main->set_layout( ).
  go_main->display_alv( ).

  REFRESH gt_dropdown.
  CLEAR gs_dropdown.
  gs_dropdown-key = '1'.
  gs_dropdown-text = 'Add User'.
  APPEND gs_dropdown TO gt_dropdown.
  CLEAR gs_dropdown.
  gs_dropdown-key = '2'.
  gs_dropdown-text = 'Delete User'.
  APPEND gs_dropdown TO gt_dropdown.
  CLEAR gs_dropdown.
  gs_dropdown-key = '3'.
  gs_dropdown-text = 'Freeze User'.
  APPEND gs_dropdown TO gt_dropdown.
  CLEAR gs_dropdown.
  gs_dropdown-key = '4'.
  gs_dropdown-text = 'Give Book'.
  APPEND gs_dropdown TO gt_dropdown.
  CLEAR gs_dropdown.
  gs_dropdown-key = '5'.
  gs_dropdown-text = 'Return Book'.
  APPEND gs_dropdown TO gt_dropdown.
  CLEAR gs_dropdown.
  gs_dropdown-key = '6'.
  gs_dropdown-text = 'Select Option'.
  APPEND gs_dropdown TO gt_dropdown.
  CLEAR gs_dropdown.

  IF dd_opt IS INITIAL.
    dd_opt = '6'.
  ENDIF.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'DD_OPT'
      values = gt_dropdown.

ENDMODULE.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      LEAVE TO SCREEN 0.
      CLEAR sy-ucomm.
    WHEN '&OPT'.
      CASE dd_opt.
        WHEN '1'.
          CALL SCREEN 0101 STARTING AT 60 70 ENDING AT 130 80.
          CLEAR sy-ucomm.
        WHEN '2'.
          CALL SCREEN 0102 STARTING AT 60 70 ENDING AT 100 80.
          CLEAR sy-ucomm.
        WHEN '3'.
          go_main->freeze_user( ).
        WHEN '4'.
          CALL SCREEN 0200.
        WHEN '5'.
          CALL SCREEN 0103 STARTING AT 60 70 ENDING AT 100 80.
      ENDCASE.
  ENDCASE.
ENDMODULE.

MODULE status_0101 OUTPUT.
  SET PF-STATUS '0101'.
  SET TITLEBAR '0101'.
ENDMODULE.

MODULE user_command_0101 INPUT.
  CASE sy-ucomm.
    WHEN '&ADD'.
      go_main->add_user( ).
    WHEN '&CLS'.
      LEAVE TO SCREEN 0.
    WHEN '&BACK'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.

MODULE status_0102 OUTPUT.
  SET PF-STATUS '0102'.
  SET TITLEBAR '0102'.
ENDMODULE.

MODULE user_command_0102 INPUT.
  CASE sy-ucomm.
    WHEN '&SLC'.
      go_main->delete_user( ).
      LEAVE TO SCREEN 0.
    WHEN '&CNC'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.

MODULE status_0200 OUTPUT.
  SET PF-STATUS '0200'.
  SET TITLEBAR '0200'.
  CLEAR sy-ucomm.
  go_main->set_fcat2( ).
  go_main->set_layout2( ).
  go_main->display_alv2( ).
ENDMODULE.

MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN '&BCK'.
      LEAVE TO SCREEN 0.
    WHEN '&GVE'.
      CALL SCREEN 0201 STARTING AT 60 70 ENDING AT 100 80.
  ENDCASE.
ENDMODULE.

MODULE status_0201 OUTPUT.
 SET PF-STATUS '0201'.
 SET TITLEBAR '0201'.
ENDMODULE.

MODULE user_command_0201 INPUT.

  CASE sy-ucomm.
    WHEN '&BOO'.
      go_main->give_book( ).
    WHEN '&CLS'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.

MODULE status_0103 OUTPUT.
 SET PF-STATUS '0103'.
 SET TITLEBAR '0103'.
ENDMODULE.

MODULE user_command_0103 INPUT.
  CASE sy-ucomm.
    WHEN '&CAN'.
      Leave TO SCREEN 0.
    WHEN '&RTN'.
      go_main->return_book_menu( ).
  ENDCASE.
ENDMODULE.

MODULE status_0300 OUTPUT.
 SET PF-STATUS '0300'.
 SET TITLEBAR '0300'.
  go_main->set_fcat3( ).
  go_main->set_layout3( ).
  go_main->display_alv3( ).
ENDMODULE.

MODULE user_command_0300 INPUT.
  CASE sy-ucomm.
    WHEN '&BCK'.
      LEAVE TO SCREEN 0.
    WHEN '&RET'.
      go_main->return_book( ).

  ENDCASE.

ENDMODULE.
