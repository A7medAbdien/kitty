#!/bin/bash
# Run the locally built Kitty with a nested instance for panel kitten

# Get the directory where this script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ensure the PYTHONPATH includes our build directory
export PYTHONPATH="$DIR:$PYTHONPATH"

# Create a temporary script to execute in Kitty
TEMP_SCRIPT=$(mktemp)
cat > "$TEMP_SCRIPT" << 'EOF'
#!/bin/bash
# Print the config file being used by kitty
echo "Config file being used by nested kitty:"
kitty +kitten panel -o background_opacity=0.2 --edge=background cava
# Keep the parent window open
echo "Press Enter to close this window"
read
EOF
chmod +x "$TEMP_SCRIPT"

# Print config file being used by local kitty build
echo "Config file being used by local kitty build:"
"$DIR/kitty/launcher/kitty" --debug-config | grep -E "Config file|config_files" -A 1

# Run the locally built Kitty executing the temp script
"$DIR/kitty/launcher/kitty" \
  --config "~/.config/kitty/kitty-bg.conf" \
  -e "$TEMP_SCRIPT"

# Clean up
rm "$TEMP_SCRIPT"