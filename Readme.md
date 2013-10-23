# Hldr
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

![There can be only be one](http://i.imgflip.com/4cgiz.jpg)

Yeah, obviously the output is a lot bigger than the original structure or a zip archive (especially if embedding images), but this is easier and cleaner for all parties involved. The vision for Hldr is twofold:

1. Allow (even non-technical) content creators to more easily leverage modern interactive frameworks within their document.
1. Make server-less (and connection-less) HTML content and front-end prototype sharing quick and easy.

## Setup

Installation is simple, just suck down the gem via `gem install hldr`

You can then immediately use the binary on any HTML file (`hldr document.html`), or you can have Hldr help you setup a new document with popular frameworks (see next section).

## Really advanced usage

Create a new document:

    $ hldr new cakeRecipe
    $ cd cakeRecipe

Have Hldr bootstrap a new feature-rich interactive HTML document with your fav frameworks (uses tab-completion to search through the [CDNJS](http://cdnjs.com/) repo). All of these settings will be saved to a `.hldrenv` file in the project root directory:

    $ hldr add bootstrap-3.0.0-rc2 
    $ hldr add jquery-mobile js
    $ hldr add d3 js
    $ hldr add flatui css
    $ hldr add anotherCssJsFw

Now hack on some HTML file, build content or create an amazing new interaction experience. Then build it with the environment configured above:

    $ hldr cakeRecipe.html > cakeRecipeFlatFile.html

As a bonus, swapping out assets is a breeze: 

    $ hldr rm bootstrap-3.0.0-rc2
    $ hldr add bootstrap-2.3.0
    $ hldr cakeRecipe.md > cakeRecipeFlatFile_using_Bootstrap2.html


## Limitations

1. The file is going to be big. If you choose to embed images, it will be significantly larger than referencing them externally. However, this isn't too big a deal for a small amount of images. Also, if you decide against this feature, it's easily disabled with the `--no-images` flag.
1. Internet Explorer 8 will not show any embedded image data over 32k. Awesome, right? 

## Example Config File

    scaffolding:
      - http://somecdn.com/css/bootstrap.min.css
      - http://somecdn.com/js/BBD-G23-4SIOU23-452 : js

**Note:** You can use the `hldr add` sub-command to search and bring in content hosted on CDNJS, right from the command line. 

This file (`.hldrenv`) resides in the projcet root. Basically, just specify the resources you want included and Hldr will always inline the content. If the resource type cannot be determined by extension, it will be ignored. However, you can force a content type by using a colon and then the type (which can be either `js` or `css`). 

## The Future
* compress images, html, js and css 
* templates
* keep everything in .hldr cache
* set max cache size in config
* support inline of css `@import`
* support inline of css `@import` media queries
* support inline of css fonts 
* option to compress images below 32k for IE8 support
* support css image inline
* create gem that installs to path
* handle css, scss, less, sass
* handle requireJs
* support input files outside of pwd
* support remote input
* support markdown input
* support haml input

## Contributing

Gitty up! If you love it and you know it, send a pull request!

## License

Hldr is released under the [MIT License](http://www.opensource.org/licenses/MIT).