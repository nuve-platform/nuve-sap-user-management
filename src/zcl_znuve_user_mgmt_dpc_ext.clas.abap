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
  methods USERSET_GET_ENTITY
    redefinition .
  methods USERSET_UPDATE_ENTITY
    redefinition .
  methods USERSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZNUVE_USER_MGMT_DPC_EXT IMPLEMENTATION.


  METHOD userset_create_entity.

* INSERT "CREATE" CODE HERE

  ENDMETHOD.


  METHOD userset_delete_entity.

* INSERT "DELETE" CODE HERE


  ENDMETHOD.


  METHOD userset_get_entity.

DATA: v_username   TYPE bapibname-bapibname,
      s_key        TYPE /iwbep/s_mgw_name_value_pair,
      s_address    TYPE bapiaddr3,
      s_password   TYPE bapipwd,
      s_islocked   TYPE bapislockd,
      s_logon_data TYPE bapilogond,
      t_return     TYPE TABLE OF bapiret2.

READ TABLE it_key_tab INTO s_key WITH KEY name = 'username'.

IF sy-subrc EQ 0.
  v_username = s_key-value.
ENDIF.

CALL FUNCTION 'BAPI_USER_GET_DETAIL'
  EXPORTING
    ername    = v_username
  IMPORTING
    logondata = s_logon_data
    address   = s_address
    islocked  = s_islocked
  TABLES
    return    = t_return.

er_entity-username     = v_username.
er_entity-first_name   = s_address-firstname.
er_entity-last_name    = s_address-lastname.
er_entity-email        = s_address-e_mail.
er_entity-valid_from   = zcl_nuve_utilities=>convert_date_to_epoch( s_logon_data-gltgv ).
er_entity-valid_to     = zcl_nuve_utilities=>convert_date_to_epoch( s_logon_data-gltgb ).
er_entity-is_locked    = s_islocked-local_lock.


  ENDMETHOD.


  METHOD userset_get_entityset.

* INSERT "READ-LIST" CODE HERE


  ENDMETHOD.


  METHOD userset_update_entity.

* INSERT "UPDATE" CODE HERE


  ENDMETHOD.
ENDCLASS.
