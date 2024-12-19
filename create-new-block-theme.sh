#!/bin/bash


create_theme(){
	# Capture the theme name from all arguments
	THEME_NAME=$1	

	# Capture the theme text domain from all arguments
	THEME_TEXT_DOMAIN=$2
	SCHEMA='$schema'	

	# Define theme directory path
	THEME_DIR="$HOME/Development/WordPress/Templates/$THEME_TEXT_DOMAIN-theme"	

	# Check if theme name and text domain were provided
	if [ -z "$THEME_NAME" ] || [ -z "$THEME_TEXT_DOMAIN" ]; then
		echo "Usage: $0 <theme-name> <text-domain>"
		exit 1
	fi

	# Create the theme directory
	mkdir -p "$THEME_DIR"

	# Create essential files and folders
	mkdir -p "$THEME_DIR/assets"
	mkdir -p "$THEME_DIR/assets/js"
	mkdir -p "$THEME_DIR/assets/css"
	mkdir -p "$THEME_DIR/assets/images"
	mkdir -p "$THEME_DIR/includes"

	mkdir -p "$THEME_DIR/templates"
	mkdir -p "$THEME_DIR/parts"
	mkdir -p "$THEME_DIR/sass

	# Create the style.css file with dynamic theme name
	cat > "$THEME_DIR/style.css" <<EOL
	/*
	Theme Name: $THEME_NAME
	Theme URI: https://r3n0.com/$THEME_TEXT_DOMAIN
	Author: René Martíenz Sánchez
	Author URI: https://r3n0.com
	Description: Un tema de bloques perosnalizado.
	Version: 1.0
	License: GNU General Public License v2 or later
	License URI: http://www.gnu.org/licenses/gpl-2.0.html
	Text Domain: $THEME_TEXT_DOMAIN
	*/
EOL

	# Success message
	echo "Block theme '$THEME_TEXT_DOMAIN' created successfully in '$THEME_DIR'."
}

create_theme $1