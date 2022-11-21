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

*    DATA: tz         TYPE ttzz-tzone.

    CONVERT TIME STAMP im_time_stamp_v TIME ZONE 'UTC'
            INTO DATE re_date_v.
*            TIME DATA(tim)
*            DAYLIGHT SAVING TIME DATA(dst).

  ENDMETHOD.


  METHOD convert_date_to_epoch.
    CONVERT DATE im_date_v "TIME im_time_v
      INTO TIME STAMP re_time_stamp_v TIME ZONE sy-zonlo.

  ENDMETHOD.
ENDCLASS.
