IFNDEF _HD44780_INC
DEFINE _HD44780_INC

; HD44780 LCD controller constants
; Hardware specification values - independent of Marvin version

; Commands
LCD_CLEAR_DISPLAY           EQU 0x01
LCD_FUNCTION_SET            EQU 0x20
LCD_DISPLAY_ON_OFF_CONTROL  EQU 0x08
LCD_SET_DDRAM_ADDR          EQU 0x80

; Function set flags
LCD_DATA_LEN_8              EQU 0x10
LCD_DISP_LINES_2            EQU 0x08
LCD_FONT_8                  EQU 0x00

; Display on/off control flags
LCD_DISPLAY_ON              EQU 0x04
LCD_CURSOR_ON               EQU 0x02
LCD_BLINK_ON                EQU 0x01

; DDRAM line start addresses (20x4 LCD)
LCD_LINE_0_ADDR             EQU 0x00
LCD_LINE_1_ADDR             EQU 0x40
LCD_LINE_2_ADDR             EQU 0x14
LCD_LINE_3_ADDR             EQU 0x54

; Display geometry (20x4)
LCD_LINE_LEN                EQU 0x14
LCD_NUM_LINES               EQU 0x04
LCD_EOL_3                   EQU 0x67

ENDIF ; _HD44780_INC
