#!/bin/bash

# Script to generate PNG files from PlantUML diagrams
# Usage: ./generate-plantuml-png.sh <input-file>

if [ $# -eq 0 ]; then
  echo "Usage: $0 <input-file>" >&2
  echo "Example: $0 /Users/tiagonpsilva/code/diagramas-conceituais/005-genai-mcp.puml" >&2
  exit 1
fi

# Turn off command tracing for cleaner output
set +x

INPUT_FILE=$1
FILENAME=$(basename "$INPUT_FILE")
DIRNAME=$(dirname "$INPUT_FILE")
BASE_FILENAME="${FILENAME%.*}"

# Make sure we can display outputs
#exec > /dev/tty 2>&1 # Uncomment for interactive output

echo "==== PlantUML PNG Generator ===="
echo "Input file: $INPUT_FILE"

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
  echo "❌ ERROR: Input file does not exist: $INPUT_FILE"
  exit 1
fi

# Check if plantuml.jar exists
if [ ! -f ~/plantuml.jar ]; then
  echo "PlantUML JAR not found. Downloading..."
  curl -L https://sourceforge.net/projects/plantuml/files/plantuml.jar/download -o ~/plantuml.jar
fi

# Get the absolute path of the input file
ABS_INPUT_FILE=$(realpath "$INPUT_FILE")
ABS_DIRNAME=$(dirname "$ABS_INPUT_FILE")

echo "Generating diagram from: $ABS_INPUT_FILE"
echo "Working directory: $ABS_DIRNAME"

# Create a temporary work directory
TEMP_DIR=$(mktemp -d)
echo "Using temporary directory: $TEMP_DIR"

# Copy the input file to the temp directory
cp "$ABS_INPUT_FILE" "$TEMP_DIR/"
TEMP_FILENAME=$(basename "$ABS_INPUT_FILE")

# Change to the temp directory
cd "$TEMP_DIR"

echo "Running PlantUML..."
java -jar ~/plantuml.jar -verbose "$TEMP_FILENAME"

# Check for ANY PNG file created in temp directory (PlantUML might use diagram title as filename)
PNG_FILES=$(find . -name "*.png" -type f)

if [ -n "$PNG_FILES" ]; then
  echo "PNG file(s) found in temp directory:"
  ls -la *.png
  
  # Get the first PNG file found (should be only one)
  GENERATED_PNG=$(echo "$PNG_FILES" | head -1)
  echo "Found generated PNG: $GENERATED_PNG"
  
  # Copy the generated PNG back to the original directory with the expected name
  OUTPUT_FILE="$ABS_DIRNAME/${BASE_FILENAME}.png"
  cp "$GENERATED_PNG" "$OUTPUT_FILE"
  
  echo "----------------------------------------"
  echo "✅ SUCCESS: PlantUML diagram conversion completed successfully."
  echo "📁 File location: $OUTPUT_FILE"
  echo "📝 Note: Original PNG was named \"$(basename "$GENERATED_PNG")\" based on diagram title"
  
  # Clean up the temp directory
  rm -rf "$TEMP_DIR"
  exit 0
else
  echo "❌ ERROR: PNG file not created in temp directory."
  echo "Files in temp directory:"
  ls -la
  
  echo "----------------------------------------"
  echo "Try running this command manually:"
  echo "cd \"$ABS_DIRNAME\" && java -jar ~/plantuml.jar \"$FILENAME\""
  
  # Clean up the temp directory
  rm -rf "$TEMP_DIR"
  exit 1
fi
