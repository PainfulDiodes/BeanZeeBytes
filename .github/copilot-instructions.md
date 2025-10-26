# copilot instructions

## copilot style and approach

- do not apologise for errors, simply note them

## code style guidelines

- Follow the existing code structure and style closely
- Never add put comments on the same line as code
- Always put comments above the related code
- Use lowercase and underscores for all function labels in assembly files
- Use uppercase and underscores for all constant and variable labels
- Always use four spaces for indentation in assembly files
- For private helper functions which won't be called from outside of the current file, use a leading underscore in the label name
- Maintain consistency in naming conventions and code organization

##  syntax and structure guidelines

- Generate valid Z80 assembly code
- Anticipate code may be written to ROM and so variables should be placed in a dedicated section at the end of each file

## quality checks

- Check for register conflicts - don't save a value to a register and then save another value to the same register in the same scope
- Check for valid use of Z80 addressing modes - for example logical "and" cannot work with indirect addressing: and (LABEL)
- Run build.sh scripts to check syntax
