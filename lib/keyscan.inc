; Marvin internal RAM - key matrix buffer address
;
; NOTE: KEY_MATRIX_BUFFER is a Marvin implementation detail, not a stable
; interface. The beanboard_keyscan example accesses this directly, which is
; tight coupling to Marvin internals. That example needs to be removed or
; rethought - ideally using MARVIN_KEY_READCHAR from marvin.inc instead.

KEY_MATRIX_BUFFER           EQU 0xF010
