#!/bin/bash

# Prompt the user for Component Name
echo "Please enter the Component Name: "
read component_name

# Create a new directory with the Component Name
mkdir "$component_name"

# Create the index.tsx file with the required code
echo "export { default } from './$component_name'" > "$component_name/index.tsx"

# Create the types.ts file with the required code
echo "export interface ${component_name}Props {}" > "$component_name/types.ts"

# Create the React component file with the required code
echo "import { ${component_name}Props } from './types'

const ${component_name} = ({}: ${component_name}Props) => {
  return (
    <div>
      <div>${component_name}</div>
    </div>
  )
}

export default ${component_name}" > "$component_name/$component_name.tsx"

echo "Component created successfully!"
