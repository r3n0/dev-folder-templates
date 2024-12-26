#!/bin/bash


create_theme_and_plugin(){
	# Capture the theme text domain from all arguments
	TEXT_DOMAIN=$1
	THEME_TEXT_DOMAIN=${TEXT_DOMAIN}_theme
	PLUGIN_TEXT_DOMAIN=${TEXT_DOMAIN}_plugin

	# Convert plugin text domain to uppercase constant name
	PLUGIN_TEXT_DOMAIN_PATH=$(echo $PLUGIN_TEXT_DOMAIN | tr '[:lower:]' '[:upper:]')_PATH
	PLUGIN_TEXT_DOMAIN_URL=$(echo $PLUGIN_TEXT_DOMAIN | tr '[:lower:]' '[:upper:]')_URL

	# Define theme directory path
	THEME_DIR="$HOME/Development/WordPress/$TEXT_DOMAIN/$TEXT_DOMAIN-theme"	
	PLUGIN_DIR="$HOME/Development/WordPress/$TEXT_DOMAIN/$TEXT_DOMAIN-plugin"

	# Check if theme name and text domain were provided
	if [ -z "$TEXT_DOMAIN" ]; then
		echo "Usage: $0 <theme-name> <text-domain>"
		exit 1
	fi

	# --------------------------
	# --------------------------
	# Create the theme directories
	# --------------------------
	# --------------------------
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
	# --------------------------
	# --------------------------
	# Create all the theme files
	# --------------------------
	# --------------------------
	#

	# Create the style.css file with dynamic theme name
	cat > "$THEME_DIR/style.css" <<EOL
	/*
	Theme Name: $THEME_TEXT_DOMAIN
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
	"\$schema": "https://raw.githubusercontent.com/WordPress-Coding-Standards/theme.json/master/theme.json",
	"version": 6.4,
	"title": "$THEME_TEXT_DOMAIN",
	"description": "This theme is built with the Block Theme API.",
	"author": "René Martínez Sánchez",
	"textDomain": "$THEME_TEXT_DOMAIN",
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

	# Components
	cat > "$THEME_DIR/sass/components/_index.sass" <<EOL
@forward 'button'
@forward 'card'
@forward 'form'
@forward 'modal'
@forward 'carousel'
@forward 'dropdown'
@forward 'tabs'
@forward 'works-grid'
@forward 'post-banner'
@forward 'narratives-queries'
@forward 'post-relationship-widget'
EOL

	# Components -> Button
	cat > "$THEME_DIR/sass/components/_button.sass" <<EOL
.button
  display: inline-block
  padding: spacing(1) spacing(2)
  border: none
  border-radius: 4px
  background-color: \$primary-color
  color: \$white
  cursor: pointer
  transition: background-color 0.3s ease

  &:hover
    background-color: darken(\$primary-color, 10%)
    text-decoration: none
EOL

	# Components -> Card
	cat > "$THEME_DIR/sass/components/_card.sass" <<EOL
.card
  background: \$white
  border-radius: 8px
  box-shadow: 0 2px 4px rgba(0,0,0,0.1)
  padding: spacing(3)
  margin-bottom: spacing(3)

  &__title
    margin-bottom: spacing(2)
    
  &__content
    color: \$text-color
EOL

	# Components -> Form
	cat > "$THEME_DIR/sass/components/_form.sass" <<EOL
.form
  &__group
    margin-bottom: spacing(2)
    
  &__label
    display: block
    margin-bottom: spacing(1)
    
  &__input
    width: 100%
    padding: spacing(1)
    border: 1px solid \$border-color
    border-radius: 4px
    
    &:focus
      outline: none
      border-color: \$primary-color
EOL

	# Components -> Modal
	cat > "$THEME_DIR/sass/components/_modal.sass" <<EOL
.modal
  position: fixed
  top: 0
  left: 0
  width: 100%
  height: 100%
  background: rgba(0,0,0,0.5)
  display: none
  align-items: center
  justify-content: center
  
  &__content
    background: \$white
    padding: spacing(3)
    border-radius: 8px
    max-width: 500px
    width: 90%
EOL

	# Components -> Carousel
	cat > "$THEME_DIR/sass/components/_carousel.sass" <<EOL
.carousel
  position: relative
  overflow: hidden
  
  &__slide
    display: none
    width: 100%
    
    &.active
      display: block
      
  &__nav
    position: absolute
    bottom: spacing(2)
    width: 100%
    text-align: center
EOL

	# Components -> Dropdown
	cat > "$THEME_DIR/sass/components/_dropdown.sass" <<EOL
.dropdown
  position: relative
  display: inline-block
  
  &__content
    display: none
    position: absolute
    top: 100%
    left: 0
    background: \$white
    border: 1px solid \$border-color
    border-radius: 4px
    min-width: 150px
    
  &.active &__content
    display: block
EOL

	# Components -> Tabs
	cat > "$THEME_DIR/sass/components/_tabs.sass" <<EOL
.tabs
  &__nav
    display: flex
    border-bottom: 1px solid \$border-color
    
  &__link
    padding: spacing(2)
    border-bottom: 2px solid transparent
    
    &.active
      border-bottom-color: \$primary-color
      
  &__content
    padding: spacing(2) 0
EOL

	# Components -> Works Grid
	cat > "$THEME_DIR/sass/components/_works-grid.sass" <<EOL
.works-grid
  display: grid
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr))
  gap: spacing(3)
  padding: spacing(3) 0
  
  &__item
    position: relative
    overflow: hidden
    border-radius: 8px
EOL

	# Components -> Post Banner
	cat > "$THEME_DIR/sass/components/_post-banner.sass" <<EOL
.post-banner
  position: relative
  margin-bottom: spacing(4)
  
  &__image
    width: 100%
    height: 400px
    object-fit: cover
    
  &__content
    position: absolute
    bottom: 0
    padding: spacing(3)
    color: \$white
    background: linear-gradient(transparent, rgba(0,0,0,0.7))
EOL

	# Components -> Narratives Queries
	cat > "$THEME_DIR/sass/components/_narratives-queries.sass" <<EOL
.narratives-queries
  margin: spacing(4) 0
  
  &__list
    list-style: none
    padding: 0
    
  &__item
    padding: spacing(2)
    border-bottom: 1px solid \$border-color
    
    &:last-child
      border-bottom: none
EOL

	# Components -> Post Relationship Widget
	cat > "$THEME_DIR/sass/components/_post-relationship-widget.sass" <<EOL
.post-relationship-widget
  padding: spacing(3)
  background: \$light-gray
  border-radius: 8px
  
  &__title
    margin-bottom: spacing(2)
    
  &__list
    list-style: none
    padding: 0
    
  &__item
    margin-bottom: spacing(2)
    
    &:last-child
      margin-bottom: 0
EOL

	# Layout
	cat > "$THEME_DIR/sass/layout/_index.sass" <<EOL
@forward 'header'
@forward 'footer'
@forward 'sidebar'
@forward 'main'
EOL

	# Layout -> Header
	cat > "$THEME_DIR/sass/layout/_header.sass" <<EOL
// Header styles
.header
  background-color: \$primary-color
  color: \$white
EOL

	# Layout -> Footer
	cat > "$THEME_DIR/sass/layout/_footer.sass" <<EOL
// Footer styles
.footer
  background-color: \$primary-color
  color: \$white
EOL

	# Layout -> Sidebar
	cat > "$THEME_DIR/sass/layout/_sidebar.sass" <<EOL
// Sidebar styles
.sidebar
  background-color: \$secondary-color
  color: \$white
EOL

	# Layout -> Main
	cat > "$THEME_DIR/sass/layout/_main.sass" <<EOL
// Main styles
.main
  padding: spacing(3)
EOL

	# Pages
	cat > "$THEME_DIR/sass/pages/_index.sass" <<EOL
@forward 'home'
@forward 'single'
@forward 'archive'
EOL

	# Pages -> Home
	cat > "$THEME_DIR/sass/pages/_home.sass" <<EOL
// Home page styles
.home
  background-color: \$white
EOL	

	# Pages -> Single
	cat > "$THEME_DIR/sass/pages/_single.sass" <<EOL
// Single post styles
.single
  background-color: \$white
EOL

	# Pages -> Archive
	cat > "$THEME_DIR/sass/pages/_archive.sass" <<EOL
// Archive page styles
.archive
  background-color: \$white
EOL

	# Themes
	cat > "$THEME_DIR/sass/themes/_index.sass" <<EOL
@forward 'theme'
@forward 'admin'
EOL

	# Themes -> theme
	cat > "$THEME_DIR/sass/themes/_theme.sass" <<EOL
@mixin dark-mode
    @media (prefers-color-scheme: dark)
        @content

@mixin light-mode
    @media (prefers-color-scheme: light)
        @content
EOL

	# Themes -> Admin
	cat > "$THEME_DIR/sass/themes/_admin.sass" <<EOL
// Admin styles
.admin
  background-color: \$white
EOL

	# Utilities
	cat > "$THEME_DIR/sass/utilities/_index.sass" <<EOL
@forward 'main'
@forward 'container'
EOL	

	# Utilities -> Main
	cat > "$THEME_DIR/sass/utilities/_main.sass" <<EOL
// Main styles
.main
  background-color: \$white
EOL

	# Utilities -> Container
	cat > "$THEME_DIR/sass/utilities/_container.sass" <<EOL
// Container styles
.container
  width: 100%
  max-width: 1200px
  margin: 0 auto
  padding: 0 spacing(2)
EOL

	# Vendors
	cat > "$THEME_DIR/sass/vendors/_index.sass" <<EOL
@forward 'bootstrap'
EOL

	# Vendors -> Bootstrap
	cat > "$THEME_DIR/sass/vendors/_bootstrap.sass" <<EOL
// Bootstrap styles
.bootstrap
  background-color: \$white
EOL

	# Success message
	echo "Block theme '$THEME_TEXT_DOMAIN' created successfully in '$THEME_DIR'."

	# --------------------------
	# --------------------------
	# Create the plugin directories
	# --------------------------
	# --------------------------
	mkdir -p "$PLUGIN_DIR"

	mkdir -p "$PLUGIN_DIR/assets"
	mkdir -p "$PLUGIN_DIR/assets/js"

	mkdir -p "$PLUGIN_DIR/includes"

	mkdir -p "$PLUGIN_DIR/blocks"

	# Create the plugin files
	cat > "$PLUGIN_DIR/${PLUGIN_TEXT_DOMAIN}.php" <<EOL
	<?php
/*
	Plugin Name: $PLUGIN_TEXT_DOMAIN    
	Description: Plugin for the $THEME_TEXT_DOMAIN
	Version: 1.0
	Author: r3n0
*/

// Exit if accessed directly
if (!defined('ABSPATH')) {
    exit;
}

// Load textdomain
function ${PLUGIN_TEXT_DOMAIN}_load_textdomain() {
    load_plugin_textdomain('${PLUGIN_TEXT_DOMAIN}', false, dirname(plugin_basename(__FILE__)) . '/languages/');
}
add_action('plugins_loaded', '${PLUGIN_TEXT_DOMAIN}_load_textdomain');

// Define plugin paths
if (!defined('${PLUGIN_TEXT_DOMAIN_PATH}')) {
    define('${PLUGIN_TEXT_DOMAIN_PATH}', plugin_dir_path(__FILE__));
}
if (!defined('${PLUGIN_TEXT_DOMAIN_URL}')) {
    define('${PLUGIN_TEXT_DOMAIN_URL}', plugin_dir_url(__FILE__));
}

// Custom post types
require_once ${PLUGIN_TEXT_DOMAIN_PATH} . 'includes/custom-post-types.php';
add_action('init', '${PLUGIN_TEXT_DOMAIN}_work_custom_post_type');
add_action('init', '${PLUGIN_TEXT_DOMAIN}_reel_custom_post_type');

// Enqueue libraries
require_once ${PLUGIN_TEXT_DOMAIN_PATH} . 'includes/enqueue.php';
add_action('wp_enqueue_scripts', '${PLUGIN_TEXT_DOMAIN}_enqueue_scripts');

// Add custom block category
require_once ${PLUGIN_TEXT_DOMAIN_PATH} . 'includes/custom-block-category.php';
add_filter('block_categories_all', '${PLUGIN_TEXT_DOMAIN}_custom_block_categories', 10, 2);

EOL

	cat > "$PLUGIN_DIR/includes/custom-post-types.php" <<EOL
<?php
function ${PLUGIN_TEXT_DOMAIN}_work_custom_post_type() {
	\$labels = array(
		'name' 				=> __('Works', '$PLUGIN_TEXT_DOMAIN'),
		'singular_name' 	=> __('Work', '$PLUGIN_TEXT_DOMAIN'),
		'add_new' 			=> __('Add New', '$PLUGIN_TEXT_DOMAIN'),
		'add_new_item' 		=> __('Add New Work', '$PLUGIN_TEXT_DOMAIN'),
		'edit_item' 		=> __('Edit Work', '$PLUGIN_TEXT_DOMAIN'),
		'new_item' 			=> __('New Work', '$PLUGIN_TEXT_DOMAIN'),
		'view_item' 		=> __('View Work', '$PLUGIN_TEXT_DOMAIN'),
		'search_items' 		=> __('Search Works', '$PLUGIN_TEXT_DOMAIN'),
		'not_found' 		=> __('No works found', '$PLUGIN_TEXT_DOMAIN'),
	);

	\$capabilities = array(
		'edit_post' 			=> 'edit_work',
		'edit_posts' 			=> 'edit_works',
		'edit_others_posts' 	=> 'edit_others_works',
		'publish_posts' 		=> 'publish_works',
		'read_post' 			=> 'read_work',
		'read_private_posts' 	=> 'read_private_works',
		'delete_post' 			=> 'delete_work',
		'delete_posts' 			=> 'delete_works'
	);

	register_post_type('work', 
		array(
			'labels' 				=> \$labels,
			'public' 				=> true,
			'show_in_rest' 			=> true,
			'supports' 				=> array('title', 'editor', 'thumbnail', 'custom-fields'),
			'rewrite' 				=> array('slug' => 'works'),
			// 'has_archive' 			=> true,
			'menu_icon' 			=> 'dashicons-art',
			'capability_type' 		=> 'post',
			'hierarchical' 			=> false,
			// 'capabilities' 			=> \$capabilities,
		)
	);
}

function ${PLUGIN_TEXT_DOMAIN}_reel_custom_post_type() {
	\$labels = array(
		'name' 				=> __('Reels', '$PLUGIN_TEXT_DOMAIN'),
		'singular_name' 	=> __('Reel', '$PLUGIN_TEXT_DOMAIN'),
		'add_new' 			=> __('Add New', '$PLUGIN_TEXT_DOMAIN'),
		'add_new_item' 		=> __('Add New Reel', '$PLUGIN_TEXT_DOMAIN'),
		'edit_item' 		=> __('Edit Reel', '$PLUGIN_TEXT_DOMAIN'),
		'new_item' 			=> __('New Reel', '$PLUGIN_TEXT_DOMAIN'),
		'view_item' 		=> __('View Reel', '$PLUGIN_TEXT_DOMAIN'),
		'search_items' 		=> __('Search Reels', '$PLUGIN_TEXT_DOMAIN'),
		'not_found' 		=> __('No reels found', '$PLUGIN_TEXT_DOMAIN'),
	);

	\$capabilities = array(
		'edit_post' 			=> 'edit_reel',
		'edit_posts' 			=> 'edit_reels',
		'edit_others_posts' 	=> 'edit_others_reels',
		'publish_posts' 		=> 'publish_reels',
		'read_post' 			=> 'read_reel',
		'read_private_posts' 	=> 'read_private_reels',
		'delete_post' 			=> 'delete_reel',
		'delete_posts' 			=> 'delete_reels'
	);

	register_post_type('reel', 
		array(
			'labels' 				=> \$labels,
			'public' 				=> true,
			'show_in_rest' 			=> true,
			'supports' 				=> array('title', 'editor', 'thumbnail', 'custom-fields'),
			'rewrite' 				=> array('slug' => 'reels'),
			// 'has_archive' 			=> true,
			'menu_icon' 			=> 'dashicons-art',
			'capability_type' 		=> 'post',
			'hierarchical' 			=> false,
			// 'capabilities' 			=> \$capabilities,
		)
	);
}
EOL

	cat > "$PLUGIN_DIR/assets/js/main.js" <<EOL
console.log('Hello World');
EOL

 cat > "$PLUGIN_DIR/includes/enqueue.php" <<EOL
 <?php

function ${PLUGIN_TEXT_DOMAIN}_enqueue_scripts() {
	wp_register_script(
		'${PLUGIN_TEXT_DOMAIN}-barba-js', 
		'https://unpkg.com/@barba/core', 
		array(), 
		null, 
		true
	);	
	wp_enqueue_script('${PLUGIN_TEXT_DOMAIN}-barba-js');

	wp_register_script(
		'${PLUGIN_TEXT_DOMAIN}-gsap', 
		'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.0/gsap.min.js', 
		array(), 
		null, 
		true
	);
	wp_enqueue_script('${PLUGIN_TEXT_DOMAIN}-gsap');

	wp_register_script(
		'${PLUGIN_TEXT_DOMAIN}-scrolltrigger',
		'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js',
		array('${PLUGIN_TEXT_DOMAIN}-gsap'),
		null,
		true
	);
	wp_enqueue_script('${PLUGIN_TEXT_DOMAIN}-scrolltrigger');

	wp_register_script(
		'${PLUGIN_TEXT_DOMAIN}-scrollto',
		'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollToPlugin.min.js',
		array('${PLUGIN_TEXT_DOMAIN}-scrolltrigger'),
		null,
		true
	);
	wp_enqueue_script('${PLUGIN_TEXT_DOMAIN}-scrollto');


	wp_register_script(
		'${PLUGIN_TEXT_DOMAIN}-page-transitions',
		${PLUGIN_TEXT_DOMAIN}_PLUGIN_URL . '/assets/js/page_transitions.js',
		array('${PLUGIN_TEXT_DOMAIN}-barba-js', '${PLUGIN_TEXT_DOMAIN}-gsap', '${PLUGIN_TEXT_DOMAIN}-scrolltrigger', '${PLUGIN_TEXT_DOMAIN}-scrollto'), // dependencies
		wp_get_theme()->get('Version'),
		true
	);
	wp_enqueue_script('${PLUGIN_TEXT_DOMAIN}-page-transitions');

}
EOL

	cat > "$PLUGIN_DIR/includes/custom-block-category.php" <<EOL
	<?php
function ${PLUGIN_TEXT_DOMAIN}_custom_block_categories( \$categories, \$post ) {
    // Define your custom category
    \$my_category = array(
        array(
            'slug'  => '${PLUGIN_TEXT_DOMAIN}',
            'title' => __( '${PLUGIN_TEXT_DOMAIN}', '${PLUGIN_TEXT_DOMAIN}_' ),
            'icon'  => null, // Optional: You can specify a Dashicon here
        ),
    );

    // Merge your category with the existing categories
    return array_merge( \$my_category, \$categories );
}
EOL

	cat > "$PLUGIN_DIR/includes/Bidirectional-Relationchips.php" <<EOL
<?php
/**
 * Bidirectional Relationship
 * 
 * This class creates a bidirectional relationship between 
 * two post types. It creates a meta box in the from post 
 * type and a select field for the related posts. It also 
 * creates a ajax action to search for related posts.
 */

class ${PLUGIN_TEXT_DOMAIN}_Bidirectional_Relationship {
    private \$from_post_type;
    private \$to_post_type;
    private \$from_meta_key;
    private \$to_meta_key;
    private \$nonce_action;
    private \$nonce_name;
    private \$ajax_action;
    private \$metabox_id;
    private \$metabox_title;

    public function __construct(\$args) {
        \$this->from_post_type = \$args['from_post_type'];
        \$this->to_post_type = \$args['to_post_type'];
        \$this->from_meta_key = \$args['from_meta_key'];
        \$this->to_meta_key = \$args['to_meta_key'];
        \$this->nonce_action = \$args['nonce_action'];
        \$this->nonce_name = \$args['nonce_name'];
        \$this->ajax_action = \$args['ajax_action'];
        \$this->metabox_id = \$args['metabox_id'];
        \$this->metabox_title = \$args['metabox_title'];

        add_action( 'admin_enqueue_scripts', array( \$this, '${PLUGIN_TEXT_DOMAIN}_enqueue_select2' ) );
        add_action( 'add_meta_boxes', array( \$this, '${PLUGIN_TEXT_DOMAIN}_add_relationship_metabox' ) );
        add_action( 'save_post_' . \$this->from_post_type, array( \$this, '${PLUGIN_TEXT_DOMAIN}_save_relationship' ) );
        add_action( 'wp_ajax_' . \$this->ajax_action, array( \$this, '${PLUGIN_TEXT_DOMAIN}_related_post_search' ) );
		add_action('init', array(\$this, 'register_bidirectional_relationship_meta'));

    }

    public function ${PLUGIN_TEXT_DOMAIN}_enqueue_select2(\$hook) {
        global \$post_type;

        if ( ('post.php' == \$hook || 'post-new.php' == \$hook) && \$post_type == \$this->from_post_type ) {
            wp_enqueue_style( 'select2', 'https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css', array(), '4.0.13' );
            wp_enqueue_script( 'select2', 'https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js', array( 'jquery' ), '4.0.13', true );
        }
    }

    public function ${PLUGIN_TEXT_DOMAIN}_add_relationship_metabox() {
        add_meta_box(
            \$this->metabox_id,
            \$this->metabox_title,
            array( \$this, '${PLUGIN_TEXT_DOMAIN}_relationship_metabox_callback' ),
            \$this->from_post_type,
            'side',
            'default'
        );
    }

	public function ${PLUGIN_TEXT_DOMAIN}_relationship_metabox_callback(\$post) {
		// Add nonce for security
		wp_nonce_field(\$this->nonce_action, \$this->nonce_name);
	
		// Get existing related posts
		\$related_posts = get_post_meta(\$post->ID, \$this->from_meta_key, false); // false returns all meta values as an array
		if (!is_array(\$related_posts)) {
			\$related_posts = array();
		}
	
		// Generate unique ID and name for the select element
		\$select_id = esc_attr(\$this->metabox_id . '_select');
		\$select_name = esc_attr(\$this->from_meta_key . '[]');
	
		// Output the select field
		echo '<select id="' . \$select_id . '" name="' . \$select_name . '" multiple="multiple" style="width: 100%;">';
	
		// Pre-populate with selected posts
		if (!empty(\$related_posts)) {
			\$selected_posts = get_posts(array(
				'post_type' => \$this->to_post_type,
				'post__in' => \$related_posts,
				'numberposts' => -1,
				'post_status' => 'publish',
			));
			foreach (\$selected_posts as \$related_post) {
				echo '<option value="' . esc_attr(\$related_post->ID) . '" selected="selected">' . esc_html(\$related_post->post_title) . '</option>';
			}
		}
	
		echo '</select>';
	
		// Initialize Select2 with the unique ID
		?>
		<script type="text/javascript">
			jQuery(document).ready(function(\$) {
				\$('#<?php echo esc_js(\$select_id); ?>').select2({
					placeholder: '<?php echo esc_js(\$this->metabox_title); ?>',
					ajax: {
						url: ajaxurl,
						dataType: 'json',
						delay: 250,
						data: function (params) {
							return {
								action: '<?php echo esc_js(\$this->ajax_action); ?>',
								q: params.term, // search term
								page: params.page
							};
						},
						processResults: function (data, params) {
							params.page = params.page || 1;
	
							return {
								results: data.items,
								pagination: {
									more: data.more
								}
							};
						},
						cache: true
					},
					minimumInputLength: 1,
				});
			});
		</script>
		<?php
	}

    function ${PLUGIN_TEXT_DOMAIN}_save_relationship(\$post_id) {
	
		// Verify nonce
		if (!isset(\$_POST[\$this->nonce_name]) || !wp_verify_nonce(\$_POST[\$this->nonce_name], \$this->nonce_action)) {
			return;
		}

		// Check autosave
		if (defined('DOING_AUTOSAVE') && DOING_AUTOSAVE) {
			return;
		}

		// Check if this is the correct post type
		if (get_post_type(\$post_id) != \$this->from_post_type) {
			return;
		}

		// Check user permissions
		if (!current_user_can('edit_post', \$post_id)) {
			return;
		}

		// Get submitted related posts
		\$related_posts = isset(\$_POST[\$this->from_meta_key]) ? array_map('intval', \$_POST[\$this->from_meta_key]) : array();

		// Remove all existing relationships
		delete_post_meta(\$post_id, \$this->from_meta_key);
	
		// Add each related post ID as a separate meta entry
		foreach (\$related_posts as \$related_post_id) {
			add_post_meta(\$post_id, \$this->from_meta_key, \$related_post_id);
		}
	
		// Now update the reverse relationships
		// Get all posts that previously had this post related
		\$args = array(
			'post_type'      => \$this->to_post_type,
			'meta_key'       => \$this->to_meta_key,
			'meta_value'     => \$post_id,
			'posts_per_page' => -1,
			'fields'         => 'ids',
		);
		\$existing_related_posts = get_posts(\$args);
	
		// Remove the relationship from posts no longer related
		\$posts_to_remove = array_diff(\$existing_related_posts, \$related_posts);
		foreach (\$posts_to_remove as \$related_post_id) {
			delete_post_meta(\$related_post_id, \$this->to_meta_key, \$post_id);
		}
	
		// Add the current post ID to the related posts of newly related posts
		foreach (\$related_posts as \$related_post_id) {
			add_post_meta(\$related_post_id, \$this->to_meta_key, \$post_id);
		}
	}

   function ${PLUGIN_TEXT_DOMAIN}_related_post_search() {

		\$results = array();
		\$search_term = isset(\$_GET['q']) ? sanitize_text_field(\$_GET['q']) : '';
		\$paged = isset(\$_GET['page']) ? intval(\$_GET['page']) : 1;

		\$query_args = array(
			'post_type'      => \$this->to_post_type,
			's'              => \$search_term,
			'posts_per_page' => 10,
			'paged'          => \$paged,
			'post_status'    => 'publish',
		);

		\$query = new WP_Query(\$query_args);
		\$items = array();

		if (\$query->have_posts()) {
			while (\$query->have_posts()) {
				\$query->the_post();
				\$items[] = array(
					'id'   => get_the_ID(),
					'text' => get_the_title(),
				);
			}
		}

		\$more = \$query->max_num_pages > \$paged;

		wp_send_json(array('items' => \$items, 'more' => \$more));
	}

	function register_bidirectional_relationship_meta(){
		register_post_meta(\$this->from_post_type, \$this->from_meta_key, array(
			'show_in_rest' => true,
			'single' => false, // Since we'll be storing multiple values
			'type' => 'integer',
		));
	
		register_post_meta(\$this->to_post_type, \$this->to_meta_key, array(
			'show_in_rest' => true,
			'single' => false, // Since we'll be storing multiple values
			'type' => 'integer',
		));
	}
}
EOL


	cat > "$PLUGIN_DIR/includes/register-relationship.php" <<EOL
	
	<?php

// For Work and Show Relationship
require_once ${PLUGIN_TEXT_DOMAIN}_PLUGIN_PATH . 'includes/Bidirectional_Relationship.php';


/**
 * Work and Reel Relationship
 */
new ${PLUGIN_TEXT_DOMAIN}_Bidirectional_Relationship(array(
    'from_post_type' => 'work',
    'to_post_type' => 'reel',
    'from_meta_key' => '_${PLUGIN_TEXT_DOMAIN}_related_reels',
    'to_meta_key' => '_${PLUGIN_TEXT_DOMAIN}_related_works',
    'nonce_action' => '${PLUGIN_TEXT_DOMAIN}_save_work_reel',
    'nonce_name' => '${PLUGIN_TEXT_DOMAIN}_work_reel_nonce',
    'ajax_action' => '${PLUGIN_TEXT_DOMAIN}_reel_search',
    'metabox_id' => '${PLUGIN_TEXT_DOMAIN}_work_reel_metabox',
    'metabox_title' => 'Related reels',
));

/**
 * Reel and Work Relationship
 */
new ${PLUGIN_TEXT_DOMAIN}_Bidirectional_Relationship(array(
    'from_post_type' => 'reel',
    'to_post_type' => 'work',
    'from_meta_key' => '_${PLUGIN_TEXT_DOMAIN}_related_works',
    'to_meta_key' => '_${PLUGIN_TEXT_DOMAIN}_related_reels',
    'nonce_action' => '${PLUGIN_TEXT_DOMAIN}_save_reel_work',
    'nonce_name' => '${PLUGIN_TEXT_DOMAIN}_reel_work_nonce',
    'ajax_action' => '${PLUGIN_TEXT_DOMAIN}_work_search',
    'metabox_id' => '${PLUGIN_TEXT_DOMAIN}_reel_work_metabox',
    'metabox_title' => 'Related Works',
));

EOL

	cat > "$PLUGIN_DIR/.gitignore" <<EOL
	
# ignore everything in the root except the "wp-content" directory.
!wp-content/

# ignore everything in the "wp-content" directory, except:
# "mu-plugins", "plugins", "themes" directory
wp-content/*
!wp-content/mu-plugins/
!wp-content/plugins/
!wp-content/themes/

# ignore these plugins
wp-content/plugins/hello.php

# ignore specific themes
wp-content/themes/twenty*/

# ignore node dependency directories
node_modules/

# ignore log files and databases
*.log
*.sql
*.sqlite

.DS_Store

EOL

	# Success message
	echo "Block theme '$THEME_TEXT_DOMAIN' created successfully in '$THEME_DIR'."
}


create_theme_and_plugin $1
