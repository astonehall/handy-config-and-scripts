@echo off
setlocal

:: Prompt the user for Component Name
set /p component_name="Please enter the Component Name: "

:: Create a new directory with the Component Name
mkdir "%component_name%"

:: Create the index.tsx file with the required code
echo export { default } from './%component_name%' > "%component_name%\index.tsx"

:: Create the types.ts file with the required code
echo export interface %component_name%Props {} > "%component_name%\types.ts"

:: Create the React component file with the required code
(
    echo import ^{ %component_name%Props ^} from './types'
    echo(
    echo const %component_name% = (^{}: %component_name%Props^) ^=^> ^{
    echo    return ^(
    echo        ^<div^>
    echo            ^<div^>%component_name%^</div^>
    echo        ^</div^>
    echo    ^);
    echo ^};
    echo(
    echo export default %component_name%
) > "%component_name%\%component_name%.tsx"

echo Component created successfully!
endlocal