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
    v_username           = s_user_payload-username.
    s_password-bapipwd   = 'ukisug22'.
    s_address-firstname  = s_user_payload-first_name.
    s_address-lastname   = s_user_payload-last_name.
    s_address-e_mail     = s_user_payload-email.
    s_logon_data-gltgv   = zcl_nuve_utilities=>convert_date_to_abap( s_user_payload-valid_from ).
    s_logon_data-gltgb   = zcl_nuve_utilities=>convert_date_to_abap( s_user_payload-valid_to ).

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

    DATA: v_username TYPE bapibname-bapibname,
          s_key      TYPE /iwbep/s_mgw_name_value_pair,
          t_return   TYPE TABLE OF bapiret2.

    READ TABLE it_key_tab INTO s_key WITH KEY name = 'username'.
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
        username  = v_username
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

    DATA: v_username     TYPE bapibname-bapibname,
          s_key          TYPE /iwbep/s_mgw_name_value_pair,
          s_user_payload TYPE znuve_user_mgmt_user_s,
          s_address      TYPE bapiaddr3,
          s_address_u    TYPE bapiaddr3,
          s_address_x    TYPE bapiaddr3x,
          s_password     TYPE bapipwd,
          s_islocked     TYPE bapislockd,
          s_islocked_u   TYPE bapislockd,
          s_logon_data   TYPE bapilogond,
          s_logon_data_u TYPE bapilogond,
          s_logon_data_x TYPE bapilogonx,
          t_return       TYPE TABLE OF bapiret2.

    READ TABLE it_key_tab INTO s_key WITH KEY name = 'username'.
    IF sy-subrc EQ 0.
      v_username = s_key-value.

    ENDIF.

    CALL FUNCTION 'BAPI_USER_GET_DETAIL'
      EXPORTING
        username  = v_username
      IMPORTING
        logondata = s_logon_data
        address   = s_address
        islocked  = s_islocked
      TABLES
        return    = t_return.

    io_data_provider->read_entry_data( IMPORTING es_data = s_user_payload ).
    s_address_u-firstname    = s_user_payload-first_name.
    s_address_u-lastname     = s_user_payload-last_name.
    s_address_u-e_mail       = s_user_payload-email.
    s_islocked_u-local_lock  = s_user_payload-is_locked.
    s_logon_data_u-gltgv     = zcl_nuve_utilities=>convert_date_to_abap( s_user_payload-valid_from ).
    s_logon_data_u-gltgb     = zcl_nuve_utilities=>convert_date_to_abap( s_user_payload-valid_to ).

    IF s_address-firstname NE s_address_u-firstname.
      s_address_x-firstname = abap_true.

    ENDIF.

    IF s_address-lastname NE s_address_u-lastname.
      s_address_x-lastname = abap_true.

    ENDIF.

    IF s_address-e_mail NE s_address_u-e_mail.
      s_address_x-e_mail = abap_true.

    ENDIF.

    IF s_logon_data-gltgv NE s_logon_data_u-gltgv.
      s_logon_data_x-gltgv = abap_true.

    ENDIF.

    IF s_logon_data-gltgb NE s_logon_data_u-gltgb.
      s_logon_data_x-gltgb = abap_true.

    ENDIF.

    IF s_islocked-local_lock EQ s_islocked_u-local_lock.
      CLEAR s_islocked_u-local_lock.

    ENDIF.

    CALL FUNCTION 'BAPI_USER_CHANGE'
      EXPORTING
        username   = v_username
        logondata  = s_logon_data_u
        logondatax = s_logon_data_x
        address    = s_address_u
        addressx   = s_address_x
      TABLES
        return     = t_return.

    IF s_islocked_u-local_lock = 'L'.
      CALL FUNCTION 'BAPI_USER_LOCK'
        EXPORTING
          username = v_username
        TABLES
          return   = t_return.

    ELSEIF s_islocked_u-local_lock = 'U'.
      CALL FUNCTION 'BAPI_USER_UNLOCK'
        EXPORTING
          username = v_username
        TABLES
          return   = t_return.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
