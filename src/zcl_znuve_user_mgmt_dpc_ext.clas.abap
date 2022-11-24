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

* INSERT "READ-DETAIL" CODE HERE


  ENDMETHOD.


  METHOD userset_get_entityset.

* INSERT "READ-LIST" CODE HERE


  ENDMETHOD.


  METHOD userset_update_entity.

* INSERT "UPDATE" CODE HERE


  ENDMETHOD.
ENDCLASS.
