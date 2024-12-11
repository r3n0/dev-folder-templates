#!/bin/bash


create_theme(){
	# Capture the theme name from all arguments
	THEME_NAME="$*"	

	# Convert THEME_NAME to lowercase
	THEME_TEXT_DOMAIN=$(echo "$THEME_NAME" | tr '[:upper:]' '[:lower:]')	

	# Replace spaces with underscores in THEME_TEXT_DOMAIN
	THEME_TEXT_DOMAIN=${THEME_TEXT_DOMAIN// /_}	
	SCHEMA='$schema'	

	# Define theme directory path
	THEME_DIR="$HOME/Development/WordPress/Templates/$THEME_TEXT_DOMAIN"	

	# Check if a theme name was provided
	if [ -z "$THEME_NAME" ]; then
    	echo "Usage: $0 <theme-name>"
    	exit 1
	fi

	# Create the theme directory
	mkdir -p "$THEME_DIR"

	# Create essential files and folders
	mkdir -p "$THEME_DIR/assets"
	mkdir -p "$THEME_DIR/assets/js"
	mkdir -p "$THEME_DIR/assets/css"
	mkdir -p "$THEME_DIR/assets/images"
	mkdir -p "$THEME_DIR/block-templates"
	mkdir -p "$THEME_DIR/block-template-parts"
	mkdir -p "$THEME_DIR/blocks"
	mkdir -p "$THEME_DIR/blocks/my-custom-block"
	mkdir -p "$THEME_DIR/patters"

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

	# Create the theme.json file
	cat > "$THEME_DIR/theme.json" <<EOL
	{
		"$SCHEMA": "https://schemas.wp.org/trunk/theme.json",
		"version": 3,
		"settings": {
			"color": {
				"defaultPalette": false,
				"palette": [
					{
						"name": "Primary",
						"slug": "anti-primary",
						"color": "#0073aa"
					},
					{
						"name": "Secondary",
						"slug": "anti-secondary",
						"color": "#005075"
					}
				]
			},
			"typography": {
				"fontSizes": [
					{
						"name": "Small",
						"slug": "anti-small",
						"size": "0.9rem"
					},
					{
						"name": "Medium",
						"slug": "anti-medium",
						"size": "1rem"
					}
				]
			},
			"spacing": {
				"units": ["px", "em", "rem", "%"]
			},
			"blocks": {
				"core/site-title": {
					"color": {
						"defaultPalette": true,
					}
				}
			}
		}
	}
EOL

	# Create a basic index.php file (fallback)
	cat > "$THEME_DIR/index.php" <<EOL
	<?php
	// Silence is golden.
	?>
EOL

	# Create the index.html template file
	cat > "$THEME_DIR/block-templates/index.html" <<EOL
	<!-- wp:group {"tagName":"main"} -->
	<main>
	<!-- wp:post-title /-->
	<!-- wp:post-content /-->
	</main>
	<!-- /wp:group -->
EOL

	# Create header.html file (template part)
	cat > "$THEME_DIR/block-templates-parts/header.html" <<EOL
	<!-- wp:group {"tagName":"header"} -->
	<header>
	<!-- wp:site-title /-->
	<!-- wp:navigation /-->
	</header>
	<!-- /wp:group -->
EOL

	# Create footer.html file (template part)
	cat > "$THEME_DIR/block-templates-parts/footer.html" <<EOL
	<!-- wp:group {"tagName":"footer"} -->
	<footer>
	<p>&copy; $(date +%Y) $THEME_NAME. All rights reserved.</p>
	</footer>
	<!-- /wp:group -->
EOL

	# Create block.json for a custom block
	cat > "$THEME_DIR/blocks/my-custom-block/block.json" <<EOL
	{
	"apiVersion": 2,
	"name": "$THEME_TEXT_DOMAIN/my-custom-block",
	"title": "My Custom Block",
	"category": "widgets",
	"icon": "smiley",
	"description": "A custom block for $THEME_NAME.",
	"supports": {
		"html": false
	},
	"editorScript": "file:./index.js",
	"attributes": {
		"content": {
		"type": "string",
		"default": "Hello, world!"
		}
	},
	"render": "file:./render.php"
	}
EOL

	# Create index.js for the custom block
	cat > "$THEME_DIR/blocks/my-custom-block/index.js" <<EOL
	( function( blocks, element ) {
		var el = element.createElement;

		blocks.registerBlockType( '$THEME_TEXT_DOMAIN/my-custom-block', {
			edit: function( props ) {
				return el(
					'p',
					null,
					'Hello from the editor!'
				);
			},
			save: function() {
				return el(
					'p',
					null,
					'Hello from the frontend!'
				);
			}
		} );
	} )( window.wp.blocks, window.wp.element );
EOL

	# Create render.php for server-side rendering of the block
	cat > "$THEME_DIR/blocks/my-custom-block/render.php" <<EOL
	<?php
	function render_my_custom_block( \$attributes ) {
		return '<p>' . esc_html( \$attributes['content'] ) . '</p>';
	}
	?>
EOL

	# Create functions.php to enqueue block editor assets
	cat > "$THEME_DIR/functions.php" <<EOL
	<?php
	// Exit if accessed directly
	if ( ! defined( 'ABSPATH' ) ) {
    	exit;
	}

	// Enqueue block editor assets
	function ${THEME_TEXT_DOMAIN}_enqueue_assets() {
		wp_enqueue_script(
			'${THEME_TEXT_DOMAIN}-editor',
			get_template_directory_uri() . '/blocks/my-custom-block/index.js',
			array( 'wp-blocks', 'wp-element', 'wp-editor' ),
			filemtime( get_template_directory() . '/blocks/my-custom-block/index.js' )
		);
	}
	add_action( 'enqueue_block_editor_assets', '${THEME_TEXT_DOMAIN}_enqueue_assets' );
	

	function ${THEME_TEXT_DOMAIN}_enqueue_assets(){
		 wp_enqueue_style(
			'${THEME_TEXT_DOMAIN}-style', // Handle
			get_stylesheet_uri(), // Path to the main style.css file
			array(), // Dependencies
			wp_get_theme()->get( 'Version' ) // Use theme version for cache busting
		);

		 wp_enqueue_script(
			'${THEME_TEXT_DOMAIN}-script',
			get_template_directory_uri() . '/assets/js/main.js',
			array(), // Dependencies
			null,
			true
		);
	}

	add_action( 'wp_enqueue_scripts', '${THEME_TEXT_DOMAIN}_enqueue_assets' );
EOL


	cat > "$THEME_DIR/composer.json" <<EOL
	{
		"name": "r3n0/${THEME_TEXT_DOMAIN}",
		"autoload": {
			"psr-4": {
				"R3n0\\${THEME_TEXT_DOMAIN}\\": "src/"
			}
		},
		"authors": [
			{
				"name": "René Martínez",
				"email": "hola@r3n0.com"
			}
		],
		"require-dev": {
			"friendsofphp/php-cs-fixer": "^3.64"
		}
	}
EOL

	# Success message
	echo "Block theme '$THEME_TEXT_DOMAIN' created successfully in '$THEME_DIR'."
}

create_theme $1