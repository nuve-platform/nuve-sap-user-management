class ZCL_ZNUVE_USER_MGMT_DPC_EXT definition
  public
  inheriting from ZCL_ZNUVE_USER_MGMT_DPC
  create public .

public section.
protected section.

  methods USERSET_CREATE_ENTITY
    redefinition .
  methods USERSET_DELETE_ENTITY
    redefinition .
  methods USERSET_UPDATE_ENTITY
    redefinition .
  methods USERSET_GET_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZNUVE_USER_MGMT_DPC_EXT IMPLEMENTATION.


  METHOD userset_create_entity.

    DATA: v_username TYPE bapibname-bapibname,
          s_key      TYPE /iwbep/s_mgw_name_value_pair,
          t_return   TYPE TABLE OF bapiret2.

    READ TABLE it_key_tab INTO s_key WITH KEY name = 'Username'.
    IF sy-subrc EQ 0.
      v_username = s_key-value.

    ENDIF.

*    CALL FUNCTION 'BAPI_USER_CREATE1'
*      EXPORTING
*        username  =
*        logondata =
*        password  =
*        address   =
*      TABLES
*        return    = t_return.
*

  ENDMETHOD.


  METHOD userset_delete_entity.

    DATA: v_username TYPE bapibname-bapibname,
          s_key      TYPE /iwbep/s_mgw_name_value_pair,
          t_return   TYPE TABLE OF bapiret2.

    READ TABLE it_key_tab INTO s_key WITH KEY name = 'Username'.
    IF sy-subrc EQ 0.
      v_username = s_key-value.

    ENDIF.

    CALL FUNCTION 'BAPI_USER_DELETE'
      EXPORTING
        username = v_username
      TABLES
        return   = t_return.

  ENDMETHOD.


  METHOD userset_get_entity.

    DATA: v_username TYPE bapibname-bapibname,
          s_key      TYPE /iwbep/s_mgw_name_value_pair,
          t_return   TYPE TABLE OF bapiret2.

    READ TABLE it_key_tab INTO s_key WITH KEY name = 'Username'.
    IF sy-subrc EQ 0.
      v_username = s_key-value.

    ENDIF.

    CALL FUNCTION 'BAPI_USER_DISPLAY'
      EXPORTING
        username = v_username
      IMPORTING
        return   = t_return.

  ENDMETHOD.


  METHOD userset_update_entity.

    DATA: v_username TYPE bapibname-bapibname,
          t_return   TYPE TABLE OF bapiret2.

    CALL FUNCTION 'BAPI_USER_CHANGE'
      EXPORTING
        username = v_username
      TABLES
        return   = t_return.

  ENDMETHOD.
ENDCLASS.
