class ZCL_NUVE_UTILITIES definition
  public
  final
  create public .

public section.

  class-methods CONVERT_DATE_TO_ABAP
    importing
      !IM_TIME_STAMP_V type TIMESTAMPL
    returning
      value(RE_DATE_V) type DATUM .
  class-methods CONVERT_DATE_TO_EPOCH
    importing
      !IM_DATE_V type DATUM
    returning
      value(RE_TIME_STAMP_V) type TIMESTAMPL .
protected section.
private section.
ENDCLASS.



CLASS ZCL_NUVE_UTILITIES IMPLEMENTATION.


  METHOD convert_date_to_abap.

    CONSTANTS: c_utc TYPE c LENGTH 6 VALUE 'UTC'.

    CONVERT TIME STAMP im_time_stamp_v TIME ZONE c_utc
            INTO DATE re_date_v.

  ENDMETHOD.


  METHOD convert_date_to_epoch.
    CONVERT DATE im_date_v "TIME im_time_v
      INTO TIME STAMP re_time_stamp_v TIME ZONE sy-zonlo.

  ENDMETHOD.
ENDCLASS.
