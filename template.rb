# gem 'slim-rails'
# gem 'bourbon'
# gem 'breakpoint'
# gem 'compass-rails'
# gem 'devise'
# gem 'figaro', github: "laserlemon/figaro"
# gem 'foreman'
# gem 'sass', "~> 3.3.0.rc.4"
# gem 'simple_form'
# gem 'susy', "~> 2.0.0.rc.1"

# gem_group :development do
# 	gem 'ffaker'
# 	gem 'guard'
# 	gem 'guard-bundler'
# 	gem 'guard-livereload', require: false
# 	gem 'guard-pow', require: false
# 	gem 'quiet_assets'
# 	gem 'rack-mini-profiler'
# 	gem 'spring'
# 	gem 'table_print'
# end

# gem_group :production do
# 	gem 'rails_12factor'
# end

append_file '.gitignore', <<-CODE
# Database
config/database.yml'

# Procfile
Procfile.env

# Pow
.powenv
CODE

file 'Procfile'
file 'Procfile.dev', <<-CODE
guard: bundle exec guard
CODE

initializer 'mini_profiler.rb', <<-CODE
Rack::MiniProfiler.config.position = 'right'
# Rack::MiniProfiler.config.start_hidden = true
CODE

rakefile 'database.rake', <<-CODE
module ActiveRecord
	module Tasks
		class PostgreSQLDatabaseTasks
			def drop
				establish_master_connection
				connection.select_all "select pg_terminate_backend(pg_stat_activity.pid) from pg_stat_activity where datname='\#{configuration['database']}' AND state='idle';"
				connection.drop_database configuration['database']
			end
		end
	end
end
CODE

run "bundle install"

# APPLICATION
remove_file 'app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.slim', <<-CODE
doctype html
html lang="en"
	head
		meta charset="utf-8"
		meta name="viewport" content="width=device-width, initial-scale=1.0"
		title == content_for?(:title) ? yield(:title) : "#{@app_name}"
	= stylesheet_link_tag "application", media: "all"
	== yield :stylesheet
	= javascript_include_tag "//use.typekit.com/ier1ulg.js"
	= javascript_tag "try{Typekit.load()}catch(e){}"
	= csrf_meta_tag
body
	== render 'layouts/header'
	== yield
	= javascript_include_tag "application"
	== yield :javascript
	= debug(params) if Rails.env.development?
CODE

file 'app/views/layouts/_header.html.slim', <<-CODE
CODE

# JS
remove_file 'app/assets/javascripts/application.js'
file 'app/assets/javascripts/application.js.coffee', <<-CODE
#= require jquery
#= require jquery_ujs
CODE

# CSS
remove_file 'app/assets/stylesheets/application.css'
file 'app/assets/stylesheets/application.css.sass', <<-CODE
@import base
@import master
CODE

file 'app/assets/stylesheets/_base.css.sass', <<-CODE
// GRID
$susy: (math: static, columns: 4, gutters: 1/7, column-width: 70px, global-box-sizing: border-box, debug: (image: hide))
$tablet: 8 (84px 12px)

// TYPOGRAPHY
$sans-serif: $helvetica
$serif: $georgia

// PALETTE
$black: #555
$blue: #477DCA
$dark-gray: #333
$medium-gray: #999
$light-gray: #DDD
$light-red: #FBE3E4
$light-yellow: #FFF6BF
$light-green: #E6EFC2

// VARIABLES
$base-border-radius: 2px
$base-font-color: $dark-gray
$base-font-family: $sans-serif
$base-font-size: 16px
$base-line-height: $base-font-size * 1.5

$base-accent-color: $blue
$base-link-color: $base-accent-color
$base-link-hover-color: darken($base-accent-color, 15)

$header-font-family: $base-font-family

$form-border-color: $light-gray
$form-border-color-hover: darken($form-border-color, 10)
$form-border-color-focus: $base-accent-color
$form-border-radius: $base-border-radius
$form-box-shadow: inset 0 1px 3px hsla(0, 0%, 0%, 0.06)
$form-box-shadow-focus: $form-box-shadow, 0 0 5px rgba(darken($form-border-color-focus, 5), 0.7)
$form-font-size: $base-font-size
$form-font-family: $base-font-family

// FLASH
$error-color: $light-red
$notice-color: $light-yellow
$success-color: $light-green

// BASE
body
	color: $base-font-color
	font-family: $base-font-family
	font-size: $base-font-size
	line-height: $base-line-height
	-webkit-font-smoothing: antialiased


h1, h2, h3, h4, h5, h6
	font-family: $header-font-family
	margin: 0
	text-rendering: optimizeLegibility

h1
	font-size: $base-font-size * 2.25 // 16 * 2.25 = 36px

h2
	font-size: $base-font-size * 2 // 16 * 2 = 32px

h3
	font-size: $base-font-size * 1.75 // 16 * 1.75 = 28px

p
	margin: 0

ul, ol
	margin: 0
	padding: 0

a
	color: $base-link-color
	text-decoration: none
	@include transition(color 0.1s linear)
	&:hover
		color: $base-link-hover-color
	&:active, &:focus
		color: $base-link-hover-color
		outline: none

img
	margin: 0
	max-width: 100%

// FORMS
input, label, select
	display: block

label
	font-weight: bold
	abbr
		display: none

textarea, \#{$all-text-inputs}, select[multiple=multiple]
	@include box-sizing(border-box)
	@include transition(border-color)
	background: white
	border-radius: $form-border-radius
	border: 1px solid $form-border-color
	box-shadow: $form-box-shadow
	font-family: $form-font-family
	font-size: $form-font-size
	margin-bottom: $base-line-height / 2
	padding: ($base-line-height / 3) ($base-line-height / 3)
	resize: vertical
	width: 100%
	&:hover
		border-color: $form-border-color-hover
	&:focus
		border-color: $form-border-color-focus
		box-shadow: $form-box-shadow-focus
		outline: none


input[type="checkbox"], input[type="radio"]
	display: inline
	margin-right: $base-line-height / 4

input[type="file"]
	width: 100%

button, input[type="submit"]
	cursor: pointer
	user-select: none
	vertical-align: middle
	white-space: nowrap

// MIXINS
@mixin clearfix
	&:after
		content: ""
		display: table
		clear: both

@mixin ellipsis
	overflow: hidden
	text-overflow: ellipsis
	white-space: nowrap
CODE

file 'app/assets/stylesheets/master.css.sass', <<-CODE
.container
	@include container
	@include susy-breakpoint(768px, $tablet)
		@include container
CODE

# GUARD
run 'bundle exec guard init'

# POW
run 'rvm env > .powenv'
run 'powder link'

# MIGRATE
# rake "db:drop"
# rake "db:create"
# rake "db:migrate"