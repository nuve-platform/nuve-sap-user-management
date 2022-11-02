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

    CALL FUNCTION 'BAPI_USER_GET_DETAIL'
      EXPORTING
        username      = v_username
        cache_results = 'X'
* IMPORTING
*       LOGONDATA     =
*       DEFAULTS      =
*       ADDRESS       =
*       COMPANY       =
*       SNC           =
*       REF_USER      =
*       ALIAS         =
*       UCLASS        =
*       LASTMODIFIED  =
*       ISLOCKED      =
*       IDENTITY      =
*       ADMINDATA     =
*       DESCRIPTION   =
      TABLES
*       PARAMETER     =
*       PROFILES      =
*       ACTIVITYGROUPS       =
        return        = t_return
*       ADDTEL        =
*       ADDFAX        =
*       ADDTTX        =
*       ADDTLX        =
*       ADDSMTP       =
*       ADDRML        =
*       ADDX400       =
*       ADDRFC        =
*       ADDPRT        =
*       ADDSSF        =
*       ADDURI        =
*       ADDPAG        =
*       ADDCOMREM     =
*       PARAMETER1    =
*       GROUPS        =
*       UCLASSSYS     =
*       EXTIDHEAD     =
*       EXTIDPART     =
*       SYSTEMS       =
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
      uflag AS is_locked
    FROM usr02
    INTO CORRESPONDING FIELDS OF TABLE t_user.

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
