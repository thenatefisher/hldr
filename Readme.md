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

## Environment File

This file (`.hldrenv`) resides in the project root and can help you jump start a project by adding libraries and frameworks quickly. If you already have a resource linked into your HTML file, you would not want to have it in this file as well. An environment file can be created with `hldr init` or `hldr new NAME`

    scaffolding:
      - http://somecdn.com/css/bootstrap.min.css
      - http://somecdn.com/js/BBD-G23-4SIOU23-452 : js

Using it is simple. Just specify the remote resources you want included and Hldr will always inline the content. If the resource type cannot be determined by extension, it will be ignored. However, you can force a content type by using a colon and then the type (which can be either `js` or `css`). 

## Limitations

1. The file is going to be big. If you choose to embed images, it will be significantly larger than referencing them externally. However, this isn't too big a deal for a small amount of images. Also, if you decide against this feature, it's easily disabled with the `--no-images` flag.
1. Internet Explorer 8 will not show any embedded image data over 32k. Awesome, right? 

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