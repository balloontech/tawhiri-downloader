open Core
open Common

type message =
  { offset : int
  ; length : int
  ; fcst_time : Forecast_time.t
  ; variable : Variable.t
  ; level : Level.t
  ; hour : Hour.t
  }

val parse : string -> message list Or_error.t
val message_to_string : message -> string
