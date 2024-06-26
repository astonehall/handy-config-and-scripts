#!/bin/bash

mkdir components
cd components

# Prompt the user for a comma-separated list of directory names
read -p "Please enter a comma-separated list of directory names: " dir_names
dirs=$(echo "$dir_names" | tr -d '[:space:]' | tr ',' '\n')

for dir in $dirs; do
  # Create the directory with the specified name
  mkdir "$dir"

  # Change into the directory
  cd "$dir"

  # Ask the user if they want to add components to the subfolder
  echo "$dir directory created."
  valid_response=false
  while [ $valid_response == false ]
  do
    read -p "Would you like to create components in the $dir folder? (y/n) " choice
    case "$choice" in 
      y|Y )
        # Run the script if the user chooses "y" or "Y"
        valid_response=true
        read -p "Please enter a comma-separated list of component names: " component_names
        components=($(echo $component_names | sed 's/\s*,\s*/ /g'))
        for component in "${components[@]}"; do
            # Create a new directory with the Component Name
            mkdir "$component"

            # Create the index.tsx file with the required code
            echo "export { default } from './$component'" > "$component/index.tsx"

            # Create the types.ts file with the required code
            echo "export interface ${component}Props {}" > "$component/types.ts"

            # Create the React component file with the required code
            echo "import { ${component}Props } from './types'

const ${component} = ({}: ${component}Props) => {
    return (
        <div>
            <div>${component}</div>
        </div>
    )
}

export default ${component}" > "$component/$component.tsx"

            echo "$component created successfully!"
        done
        ;;
      n|N ) 
        # Do nothing if the user chooses "n" or "N"
        valid_response=true
        echo "No components created for $dir directory."
        ;;
      * ) 
        # Prompt the user to enter a valid choice if they enter something other than "y" or "n"
        echo "Invalid choice. Please enter 'y' or 'n'."
        ;;
    esac
  done

  # Change back to the parent directory
  cd ..
done
