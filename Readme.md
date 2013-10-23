# Hldr
A Ruby gem to generate portable interactive documents by compiling all linked assets from an HTML document into a single file (rendered to `stdout`). The value of the Word document is diminishing by the minute!

Suppose you have a somewhat complicated, well broken out HTML document or front-end prototype that you want to quickly show a non-technical colleague, Bernard. Your document may look like this:

    .
    └── img
    │   ├── icons
    │   │   └── star.png
    │   └── cake_decors.png
    │   └── kittens.png
    ├── js
    │   ├── app.js
    │   └── jquery.js
    ├── css
    │   ├── app.css
    │   └── bootstrap.css
    │
    └── cakeRecipe.html

Wouldn't it be great if we could quickly compile all of this into a **single** file to give Bernard?

    $ hldr cakeRecipe.html > flatfile.html

![There can be only be one](http://cdn1-www.craveonline.com/assets/uploads/2011/01/file_130400_2_highlander04.jpg)

Yeah, obviously the output is a lot bigger than the original structure or a zip archive (especially if embedding images), but this is easier and cleaner for all parties involved. The vision for Hldr is twofold:

1. Allowing (even non-technical) content creators to more easily leverage powerful interactive frameworks within their document.
1. Make HTML front-end prototype sharing quick and easy.

## Usage

Installation is simple, just suck down the gem via `gem install hldr`

## Really advanced usage

    $ hldr new cakeRecipe
    $ cd cakeRecipe

    $ hldr add bootstrap-3.0.0-rc2 
    $ hldr add jquery-mobile js
    $ hldr add d3 js
    $ hldr add flatui css
    $ hldr add anotherCssJsFw

As a bonus, swapping out assets is a breeze: 

    $ hldr rm bootstrap-3.0.0-rc2
    $ hldr add bootstrap-2.3.0
    $ hldr cakeRecipe.md > flatCakeRecipeFile.html

## Example Config File

    scaffolding:
      - http://somecdn.com/css/bootstrap.min.css
      - http://somecdn.com/js/BBD-G23-4SIOU23-452 : js

## The Future
- [ ] compress images, html, js and css 
- [ ] templates
- [ ] support md
- [ ] support haml
- [ ] Keep everything in .hldr cache
- [ ] fetch remotes
- [ ] support inline of css `@import`
- [ ] support inline of css `@import` media queries
- [ ] support inline of css fonts 
- [ ] option to compress images below 32k for IE8 support
- [ ] support css image inline
- [ ] create gem that installs to path
- [ ] handle css, scss, less, sass
- [ ] handle requireJs
- [ ] set max cache size in config

## Bugs
* Handle malformed input (ie file not found, etc)