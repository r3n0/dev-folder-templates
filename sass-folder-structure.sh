#!/bin/bash
create_sass_folder_structure(){


# Create the main SASS directory
mkdir -p sass

# Create subdirectories for SASS best practices
mkdir -p sass/abstracts
mkdir -p sass/base
mkdir -p sass/utilities
mkdir -p sass/components
mkdir -p sass/layout
mkdir -p sass/pages
mkdir -p sass/themes
mkdir -p sass/vendors

# Create a main SASS file
touch sass/main.sass

cat > "sass/main.sass" <<EOL
@forward 'abstracts'
@forward 'base'
@forward 'utilities'
@forward 'components'
@forward 'layout'
@forward 'pages'
@forward 'themes'
@forward 'vendors'
EOL

# Abstract folder
touch sass/abstracts/_index.sass # main file
touch sass/abstracts/_variables.sass
touch sass/abstracts/_media-queries.sass
touch sass/abstracts/_colors.sass
touch sass/abstracts/_mixins.sass
touch sass/abstracts/_functions.sass

cat > "sass/abstracts/_index.sass" <<EOL
@forward 'variables'
@forward 'media-queries'
@forward 'colors'
@forward 'mixins'
@forward 'functions'
EOL

# Base folder
touch sass/base/_index.sass # main file
touch sass/base/_typography.sass
touch sass/base/_reset.sass
touch sass/base/_base.sass
touch sass/base/_helpers.sass

cat > "sass/base/_index.sass" <<EOL
@forward 'typography'
@forward 'reset'
@forward 'base'
@forward 'helpers'
EOL

# Utilities folder
touch sass/utilities/_index.sass # main file
touch sass/utilities/_main.sass
touch sass/utilities/_container.sass

cat > "sass/utilities/_index.sass" <<EOL
@forward 'main'
@forward 'container'
EOL

# Components folder
touch sass/components/_index.sass # main file
touch sass/components/_button.sass
touch sass/components/_card.sass
touch sass/components/_form.sass
touch sass/components/_modal.sass
touch sass/components/_carousel.sass
touch sass/components/_dropdown.sass
touch sass/components/_tabs.sass

cat > "sass/components/_index.sass" <<EOL
@forward 'button'
@forward 'card'
@forward 'form'
@forward 'modal'
@forward 'carousel'
@forward 'dropdown'
@forward 'tabs'
EOL

# Layout folder
touch sass/layout/_index.sass # main file
touch sass/layout/_header.sass
touch sass/layout/_footer.sass
touch sass/layout/_sidebar.sass
touch sass/layout/_main.sass

cat > "sass/layout/_index.sass" <<EOL
@forward 'header'
@forward 'footer'
@forward 'sidebar'
@forward 'main'
EOL

# Pages folder
touch sass/pages/_index.sass # main file
touch sass/pages/_home.sass
touch sass/pages/_about.sass
touch sass/pages/_contact.sass

cat > "sass/pages/_index.sass" <<EOL
@forward 'home'
@forward 'about'
@forward 'contact'
EOL

# Themes folder
touch sass/themes/_index.sass # main file
touch sass/themes/_theme.sass
touch sass/themes/_admin.sass

cat > "sass/themes/_index.sass" <<EOL
@forward 'theme'
@forward 'admin'
EOL

# Vendors folder
touch sass/vendors/_index.sass # main file
touch sass/vendors/_modern-reset.sass

cat > "sass/vendors/_index.sass" <<EOL
@forward 'modern-reset'
EOL
}

create_sass_folder_structure