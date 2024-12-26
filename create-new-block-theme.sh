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

	mkdir -p "$THEME_DIR/sass"
	mkdir -p "$THEME_DIR/sass/abstracts"
	mkdir -p "$THEME_DIR/sass/base"
	mkdir -p "$THEME_DIR/sass/components"
	mkdir -p "$THEME_DIR/sass/layout"
	mkdir -p "$THEME_DIR/sass/pages"
	mkdir -p "$THEME_DIR/sass/themes"
	mkdir -p "$THEME_DIR/sass/utilities"
	mkdir -p "$THEME_DIR/sass/vendors"

	#
	#
	#Create all the files
	#
	#

	# Create the style.css file with dynamic theme name
	cat > "$THEME_DIR/style.css" <<EOL
	/*
	Theme Name: $THEME_NAME
	Theme URI: https://r3n0.com/$THEME_TEXT_DOMAIN
	Author: René Martíenz Sánchez
	Author URI: https://r3n0.com
	Description: Un tema de bloques personalizado.
	Version: 1.0
	License: GNU General Public License v2 or later
	License URI: http://www.gnu.org/licenses/gpl-2.0.html
	Text Domain: $THEME_TEXT_DOMAIN
	Tags: block-theme, full-site-editing, custom-colors, custom-menu, custom-logo, editor-style, featured-images, block-patterns
	Requires at least: 6.0
	Tested up to: 6.4
	Requires PHP: 7.4
	*/
EOL

	# functions.php	
	cat > "$THEME_DIR/functions.php" <<EOL
<?php

/**
 * Functions and definitions
 * 
 * 
 */

 if (!defined('ABSPATH')) {
	exit;
}

require_once get_template_directory() . '/includes/enqueue.php';
add_action('wp_enqueue_scripts', '${THEME_TEXT_DOMAIN}_enqueue_styles');
add_action('enqueue_block_editor_assets', '${THEME_TEXT_DOMAIN}_enqueue_editor_styles');
add_action('wp_enqueue_scripts', '${THEME_TEXT_DOMAIN}_enqueue_scripts');

add_action( 'wp_enqueue_scripts', '${THEME_TEXT_DOMAIN}_enqueue_google_fonts' );
add_action( 'enqueue_block_editor_assets', '${THEME_TEXT_DOMAIN}_enqueue_google_fonts' );

EOL

	# .gitignore
	cat > "$THEME_DIR/.gitignore" <<EOL
# Node modules
node_modules/

# npm debug logs
npm-debug.log*

# npm cache directory
.npm

# Optional npm cache directory
.node_repl_history

# Output of 'npm pack'
*.tgz

# dotenv environment variables file for npm
.env
EOL

	# package.json
	cat > "$THEME_DIR/package.json" <<EOL
{
	"name": "${THEME_TEXT_DOMAIN}_theme",
	"version": "1.0.0",
	"description": "This npm functions are ment to serve for frontend development",
	"main": "index.js",
	"scripts": {
		"test": "echo \"Error: no test specified\" && exit 1",
		"build:css": "sass sass/main.sass assets/css/styles.css",
		"watch:css": "sass --watch sass/main.sass assets/css/styles.css",
		"serve": "browser-sync start --https --proxy 'https://local.site.url/' --files 'assets/css/*.css' --browser 'firefox'",
		"start": "npm-run-all --parallel watch:css serve"
	},
	"keywords": [],
	"author": "",
	"license": "ISC",
	"devDependencies": {
		"browser-sync": "^3.0.3",
		"npm-run-all": "^4.1.5",
		"sass": "^1.81.0"
	}
}
EOL

	# theme.json
	cat > "$THEME_DIR/theme.json" <<EOL
{
	"$schema": "https://schemas.wp.org/trunk/theme.json",
	"version": 6.4,
	"title": "$THEME_NAME",
	"description": "This theme is built with the Block Theme API.",
	"author": "René Martínez Sánchez",
	"textDomain": "$THEME_TEXT_DOMAIN",
	"editorScript": "$THEME_TEXT_DOMAIN-main-script",
	"editorStyle": "$THEME_TEXT_DOMAIN-editor-style",
	"settings": {
		"layout": {
			"contentSize": "1000px",
			"wideSize": "1200px"
		},
		"alignments": {
			"wide": "wide"
		},
		"color": {
			"text": true,
			"background": true,
			"link": true
		},
		"border": {
			"color": true,
			"radius": true,
			"style": true,
			"width": true
		},
		"spacing": {
			"blockGap": true,
			"margin": true,
			"padding": true,
			"units": ["px", "em", "rem", "vh", "vw", "%"]
		},
		"custom": {
			"htmlAttributes": true,
			"breakpoints": {
				"mobile": "767px",
				"tablet": "1024px",
				"desktop": "1200px"
			}
		},
		"blocks": {
			"core/paragraph": {
				"htmlAttributes": true
			},
			"core/image": {
				"htmlAttributes": true
			},
			"core/group": {
				"htmlAttributes": true
			}
		},
		"typography": {
			"customFontSize": true,
			"customLineHeight": true,
			"textDecoration": true,
			"textTransform": true,
			"fontFamilies": [
				{
					"fontFamily": "Saira, sans-serif",
					"slug": "saira",
					"name": "Saira"
				}
			]
		}
	},
	"styles": [
		"wp-block-styles"
	],
	"templateParts": [
		{
			"name": "header",
			"title": "Header",
			"area": "header"
		},
		{
			"name": "footer",
			"title": "Footer",
			"area": "footer"
		}
	]
}
EOL

	# Main.js
	cat > "$THEME_DIR/assets/js/main.js" <<EOL
console.log('Hello World');
EOL

	# Styles.css
	cat > "$THEME_DIR/assets/css/styles.css" <<EOL
body {
	background-color: red;
}
EOL

	# Create the enqueue.php file
	cat > "$THEME_DIR/includes/enqueue.php" <<EOL
	<?php

function ${THEME_TEXT_DOMAIN}_enqueue_styles() {
	// register style file
	wp_register_style(
		'${THEME_TEXT_DOMAIN}-style', // name
		get_template_directory_uri() . '/assets/css/styles.css', // path
		array(), // dependencies
		wp_get_theme()->get('Version'), // version
		'all' // media
	);
	wp_enqueue_style('${THEME_TEXT_DOMAIN}-style');
}

function ${THEME_TEXT_DOMAIN}_enqueue_scripts() {
	wp_register_script(
		'${THEME_TEXT_DOMAIN}-main-script',
		get_template_directory_uri() . '/assets/js/main.js',
		array(), // dependencies
		wp_get_theme()->get('Version'),
		true
	);
	wp_enqueue_script('${THEME_TEXT_DOMAIN}-main-script');
}

function ${THEME_TEXT_DOMAIN}_enqueue_editor_styles() {
	wp_enqueue_style(
		'${THEME_TEXT_DOMAIN}-editor-style', 
		get_template_directory_uri() . '/assets/css/styles.css', 
		array(), 
		wp_get_theme()->get('Version'), 
		'all'
	);
}

function ${THEME_TEXT_DOMAIN}_enqueue_google_fonts() {
	wp_enqueue_style(
			'${THEME_TEXT_DOMAIN}-google-fonts',
			'https://fonts.googleapis.com/css2?family=Saira:ital,wght@0,100..900;1,100..900&display=swap',
			array(),
		null
	);
}
EOL

	# Footer	
	cat > "$THEME_DIR/parts/footer.php" <<EOL
<!-- wp:group {"className":"footer-container"} -->
<div class="wp-block-group footer-container"></div>
<!-- /wp:group -->
EOL

	# Header	
	cat > "$THEME_DIR/parts/header.php" <<EOL
<!-- wp:group {"className":"title-container"} -->
<div class="wp-block-group title-container">
	<!-- wp:site-title {"className":"site-title"} /-->
</div>
<!-- /wp:group -->
<!-- wp:navigation {"ref":97,"layout":{"type":"flex","justifyContent":"right","orientation":"vertical"},"className":"main-nav"} /-->
EOL

	# Index	
	cat > "$THEME_DIR/templates/index.html" <<EOL
<!-- wp:template-part {"slug":"header","theme":"${THEME_TEXT_DOMAIN}_theme","tagName":"header","className":"main-header"} /-->
<!-- wp:post-content /-->
<!-- wp:template-part {"slug":"footer","tagName":"footer","theme":"${THEME_TEXT_DOMAIN}_theme"} /-->
EOL

	# 404
	cat > "$THEME_DIR/templates/404.html" <<EOL
<!-- wp:template-part {"slug":"header","theme":"${THEME_TEXT_DOMAIN}_theme","tagName":"header","className":"main-header"} /-->
<!-- wp:post-content /-->
<!-- wp:heading -->
	<h2 class="wp-block-heading">404.html</h2>
<!-- /wp:heading -->
<!-- wp:template-part {"slug":"footer","tagName":"footer","theme":"${THEME_TEXT_DOMAIN}_theme"} /-->
EOL

	# Main
	cat > "$THEME_DIR/sass/main.sass" <<EOL
@forward 'abstracts'
@forward 'base'
@forward 'utilities'
@forward 'components'
@forward 'layout'
@forward 'pages'
@forward 'themes'
@forward 'vendors'
EOL

	# Abstracts	
	cat > "$THEME_DIR/sass/abstracts/index.sass" <<EOL
@forward 'reset'
@forward 'variables'
@forward 'media-queries'
@forward 'colors'
@forward 'mixins'
@forward 'functions'
EOL

	# Abstracts -> Reset	
	cat > "$THEME_DIR/sass/abstracts/_reset.sass" <<EOL
// Reset styles
*,
*::before,
*::after
  box-sizing: border-box
  margin: 0
  padding: 0
EOL

	# Abstracts -> Variables	
	cat > "$THEME_DIR/sass/abstracts/_variables.sass" <<EOL
// Typography
\$font-family-base: 'Saira', sans-serif
\$font-size-base: 16px
\$line-height-base: 1.5

// Spacing
\$spacing-unit: 8px
EOL

	# Abstracts -> Media queries
	cat > "$THEME_DIR/sass/abstracts/_media-queries.sass" <<EOL
\$breakpoints: ( 'small': 600px, 'medium': 768px, 'large': 1024px, 'xlarge': 1200px, 'xxlarge': 1900px )
EOL

	# Abstracts -> Colors
	cat > "$THEME_DIR/sass/abstracts/_colors.sass" <<EOL
// Brand colors
\$primary-color: #007bff
\$secondary-color: #6c757d
\$accent-color: #28a745

// Neutral colors  
\$white: #ffffff
\$black: #000000
\$gray-100: #f8f9fa
\$gray-900: #212529
EOL

	# Abstracts -> Mixins	
	cat > "$THEME_DIR/sass/abstracts/_mixins.sass" <<EOL
=flex-center
  display: flex
  justify-content: center
  align-items: center

// Mixin for min-width queries
@mixin breakpoint-above(\$breakpoint)
  @if map-has-key(\$breakpoints, \$breakpoint)
    @media screen and (min-width: map-get(\$breakpoints, \$breakpoint))
      @content
  @else
    @warn "Unknown breakpoint: #{\$breakpoint}"
EOL

	# Abstracts -> Functions
	cat > "$THEME_DIR/sass/abstracts/_functions.sass" <<EOL
@function spacing(\$multiplier)
  @return \$spacing-unit * \$multiplier
EOL

	# Base	
	cat > "$THEME_DIR/sass/base/_index.sass" <<EOL
@forward 'typography'
@forward 'reset'
@forward 'base'
@forward 'helpers'
EOL

	# Base -> Typography
	cat > "$THEME_DIR/sass/base/_typography.sass" <<EOL
// Typography styles
body
  font-family: 'Saira', sans-serif
  line-height: 1.5
  color: \$gray-900

h1, h2, h3, h4, h5, h6
  margin-bottom: spacing(2)
  font-weight: 700
  line-height: 1.2
EOL

	# Base -> Reset
	cat > "$THEME_DIR/sass/base/_reset.sass" <<EOL
// Reset default styles
*,
*::before,
*::after
  margin: 0
  padding: 0
  box-sizing: border-box

html
  font-size: 16px
  -webkit-text-size-adjust: 100%
EOL

	# Base -> Base
	cat > "$THEME_DIR/sass/base/_base.sass" <<EOL
// Base styles
body
  background-color: \$white
  min-height: 100vh

img
  max-width: 100%
  height: auto

a
  color: \$primary-color
  text-decoration: none
  
  &:hover
    text-decoration: underline
EOL

	# Base -> Helpers
	cat > "$THEME_DIR/sass/base/_helpers.sass" <<EOL
// Helper classes
.text-center
  text-align: center

.hidden
  display: none

.container
  width: 100%
  max-width: 1200px
  margin: 0 auto
  padding: 0 spacing(2)
EOL

	# Success message
	echo "Block theme '$THEME_TEXT_DOMAIN' created successfully in '$THEME_DIR'."
}

create_theme $1