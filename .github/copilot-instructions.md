# copilot instructions
- generate z80 assembly code
- Use lowercase and underscores for all function labels in assembly files
- Prefer comments above code instead of inline comments
- Always use two spaces for indentation in assembly files
- Do not generate code for unsupported platforms
- for helper functions which won't be called from outside of the current file, use a leading underscore in the label name
- anticipate code may be written to ROM and so variables should be placed in a dedicated section at the end of each file