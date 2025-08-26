# copilot instructions
## syntax and structure guidelines
- generate z80 assembly code
- anticipate code may be written to ROM and so variables should be placed in a dedicated section at the end of each file
## code style guidelines
- Use lowercase and underscores for all function labels in assembly files
- use uppercase and underscores for all constant and variable labels
- Always put comments above the related code instead of using inline comments
- Always use two spaces for indentation in assembly files
- for private helper functions which won't be called from outside of the current file, use a leading underscore in the label name
