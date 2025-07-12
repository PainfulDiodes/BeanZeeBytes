## v1.2.1
  * Update to Marvin 1.2.1 map files, and relocate to a general lib directory shared by C and ASM examples
  * readchar - change the C-facing method - prefix with marvin_ (effectively create a marvin lib)
  * Call lcd_init after messing with LCD and before returning to monitor (some examples did this, others didn't)
  * Remove LIS and MAP files from repo
  * Improved build scripts, and new clean scripts - can execute in batch for ASM or C examples
  * Some additional C beanboard examples - mirroring ASM examples
  * Temporary C compiler test directory added - tests for a known issue in the Z88DK compiler
