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

DATA: v_username     TYPE bapibname-bapibname,
      s_key          TYPE /iwbep/s_mgw_name_value_pair,
      s_address      TYPE bapiaddr3,
      s_password     TYPE bapipwd,
      s_logon_data   TYPE bapilogond,
      s_user_payload TYPE znuve_user_mgmt_user_s,
      t_return       TYPE TABLE OF bapiret2.

io_data_provider->read_entry_data( IMPORTING es_data = s_user_payload ).
v_username          = s_user_payload-username.
s_password-bapipwd  = 'ukisug22'.
s_address-firstname = s_user_payload-first_name.
s_address-lastname  = s_user_payload-last_name.
s_address-e_mail    = s_user_payload-email.
s_logon_data-gltgv  = zcl_nuve_utilities=>convert_date_to_abap( s_user_payload-valid_from ).
s_logon_data-gltgb  = zcl_nuve_utilities=>convert_date_to_abap( s_user_payload-valid_to ).

CALL FUNCTION 'BAPI_USER_CREATE1'
  EXPORTING
    username  = v_username
    logondata = s_logon_data
    password  = s_password
    address   = s_address
  TABLES
    return    = t_return.


  ENDMETHOD.


  METHOD userset_delete_entity.

* INSERT "DELETE" CODE HERE


  ENDMETHOD.


  METHOD userset_get_entity.

* INSERT "READ-DETAIL" CODE HERE


  ENDMETHOD.


  METHOD userset_get_entityset.

TYPES: BEGIN OF ty_user,
         bname TYPE bname,
       END OF ty_user.

DATA: v_username   TYPE bapibname-bapibname,
      s_key        TYPE /iwbep/s_mgw_name_value_pair,
      s_address    TYPE bapiaddr3,
      s_password   TYPE bapipwd,
      s_islocked   TYPE bapislockd,
      s_logon_data TYPE bapilogond,
      s_entityset  TYPE znuve_user_mgmt_user_s,
      s_user       TYPE ty_user,
      t_user       TYPE TABLE OF ty_user,
      t_return     TYPE TABLE OF bapiret2.

SELECT bname
  FROM usr01
  INTO TABLE t_user.

LOOP AT t_user INTO s_user.
  CLEAR v_username.
  v_username = s_user-bname.

  CALL FUNCTION 'BAPI_USER_GET_DETAIL'
    EXPORTING
      username  = v_username
    IMPORTING
      logondata = s_logon_data
      address   = s_address
      islocked  = s_islocked
    TABLES
      return    = t_return.

  s_entityset-username     = v_username.
  s_entityset-first_name   = s_address-firstname.
  s_entityset-last_name    = s_address-lastname.
  s_entityset-email        = s_address-e_mail.
  s_entityset-valid_from   = zcl_nuve_utilities=>convert_date_to_epoch( s_logon_data-gltgv ).
  s_entityset-valid_to     = zcl_nuve_utilities=>convert_date_to_epoch( s_logon_data-gltgb ).
  s_entityset-is_locked    = s_islocked-local_lock.

  APPEND s_entityset TO et_entityset.
ENDLOOP.


  ENDMETHOD.


  METHOD userset_update_entity.

* INSERT "UPDATE" CODE HERE


  ENDMETHOD.
ENDCLASS.
