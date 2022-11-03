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

    DATA: v_username TYPE bapibname-bapibname,
          s_key      TYPE /iwbep/s_mgw_name_value_pair,
          t_return   TYPE TABLE OF bapiret2.

    READ TABLE it_key_tab INTO s_key WITH KEY name = 'Username'.
    IF sy-subrc EQ 0.
      v_username = s_key-value.

    ENDIF.

    CALL FUNCTION 'BAPI_USER_GET_DETAIL'
      EXPORTING
        USERNAME             = v_username
*       CACHE_RESULTS        = 'X'
*     IMPORTING
*       LOGONDATA            =
*       DEFAULTS             =
*       ADDRESS              =
*       COMPANY              =
*       SNC                  =
*       REF_USER             =
*       ALIAS                =
*       UCLASS               =
*       LASTMODIFIED         =
*       ISLOCKED             =
*       IDENTITY             =
*       ADMINDATA            =
*       DESCRIPTION          =
      TABLES
*       PARAMETER            =
*       PROFILES             =
*       ACTIVITYGROUPS       =
        RETURN               = t_return
*       ADDTEL               =
*       ADDFAX               =
*       ADDTTX               =
*       ADDTLX               =
*       ADDSMTP              =
*       ADDRML               =
*       ADDX400              =
*       ADDRFC               =
*       ADDPRT               =
*       ADDSSF               =
*       ADDURI               =
*       ADDPAG               =
*       ADDCOMREM            =
*       PARAMETER1           =
*       GROUPS               =
*       UCLASSSYS            =
*       EXTIDHEAD            =
*       EXTIDPART            =
*       SYSTEMS              =
              .

  ENDMETHOD.


  METHOD userset_get_entityset.

    DATA: t_user TYPE znuve_user_mgmt_user_t.

* USR21 get PERSNUMBER
* ADRP use PERSNUMBER to get NAME_FIRST NAME_LAST OR NAME_TEXT (full name)
    SELECT
      bname AS username
      gltgv AS valid_from
      gltgb AS valid_to
    FROM usr02
    INTO CORRESPONDING FIELDS OF TABLE et_entityset.

  ENDMETHOD.


  METHOD userset_update_entity.

    DATA: v_username TYPE bapibname-bapibname,
          s_key      TYPE /iwbep/s_mgw_name_value_pair,
          t_return   TYPE TABLE OF bapiret2.

    READ TABLE it_key_tab INTO s_key WITH KEY name = 'username'.
    IF sy-subrc EQ 0.
      v_username = s_key-value.

    ENDIF.

    CALL FUNCTION 'BAPI_USER_CHANGE'
      EXPORTING
        username = v_username
      TABLES
        return   = t_return.

  ENDMETHOD.
ENDCLASS.
