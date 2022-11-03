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
protected section.
private section.
ENDCLASS.



CLASS ZCL_NUVE_UTILITIES IMPLEMENTATION.


  METHOD convert_date_to_abap.

    DATA: tz         TYPE ttzz-tzone.

    CONVERT TIME STAMP im_time_stamp_v TIME ZONE tz
            INTO DATE re_date_v.
*            TIME DATA(tim)
*            DAYLIGHT SAVING TIME DATA(dst).

  ENDMETHOD.
ENDCLASS.
