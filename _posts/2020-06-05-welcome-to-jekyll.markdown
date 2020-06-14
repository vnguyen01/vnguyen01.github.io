---
layout: post
title:  "Creating My Jekyll Site"
categories: jekyll update
---
## Override and Customize Minima Theme
In `_config.yml`, the default theme is listed as minima. We want to comment that out.

```
# theme: minima
```

Instead, we want to copy all of Minima's Jekyll package contents located in its 
`_layouts`, `_includes`, and `_sass` directories into our main site directory. From the main 
site directory, we can run in the terminal the command

```
open $(bundle show minima)
```

to have a pop up window showing those relevant directories. Now, by editing the files in these 
folders, we can customize the theme to our liking.

## Import Bootstrap 4
I really like the dynamic table of contents that is available in 
[Bootstrap documentation websites](https://getbootstrap.com/docs/3.3/css/). Luckily, there is a 
[Bootstrap plugin](https://afeld.github.io/bootstrap-toc/) that can generate this table of contents. But 
to get that to work, we first have to set up our site to have Bootstrap.

When the website builds, all of the CSS is compiled from the `_sass` folder that we've copied into our directory. 
Since we will have Bootstrap stuff in addition to Minima stuff, it's better to put all relevant CSS files into a 
specific directory. Create the folder `css/` in `assets/`. Then, copy all the contents in `_sass/` into the 
newly created location `assets/css/minima`. Next, we have to let Jekyll know the existence of this new path by 
 modifying `_config.yml`:

```
sass:
  sass_dir: assets/css
```

Now, we should download the [Bootstrap source files](https://getbootstrap.com/docs/4.0/getting-started/download/), 
unzip it, and copy the contents of `bootstrap-4.0.0/scss/` into `assets/css/bootstrap-4.0.0/`. So to recap, the directory 
`assets/css` should contain 2 folders: `minima` and `bootstrap-4.0.0`.

Lastly, we need to edit the file `main.scss` to include the additional import of Bootstrap:

```
@import "minima";
@import "bootstrap-4.0.0/bootstrap";
```

Remember to get the changes in the `_config.yml` file to work we have to rerun the command
```
bundle exec jekyll serve
```

## Fix Several Styling Issues
If we navigate to localhost to see the result of the site, we'll notice that some formatting appears 
messed up, or at least on my computer it does. The buttons in the navigation bar have a border and don't 
seem to appear on the same line as the title. Also, some of the icons in the footer appear squished. Now, there's probably a much better way to fix this, but after some experimenting with the developer tools in 
a browser, these styling fixes seemed to fix everything.

### Navbar
Within `assets/css/minima/_layout.scss`, I added in

```
// label for nav-trigger keeps having inline-block
.label-nav-trigger{
    display: none;
    margin-bottom: 0px;
}
```

I then went into the file `_includes/header.html` and added the class I called above for the `nav-trigger`:
```
<label for="nav-trigger" class="label-nav-trigger">
```

Now to get rid of the borders around the links, I modified the attributes of the `.page-link` class within the 
`.site-nav` class to be

```
border:none;
display:inline;
```

This just means there will be no border and each navigation link will appear on the same line instead of stacked. When the 
screen is too small, the menu icon will appear. Clicking on it will bring down a list of the links. However, the link dropdown is 
transparent with the background of the site. To fix this, I just made the navigation bar always be higher than everything else:

```
.site-nav {
    ...
    z-index: 1;
    ...
}
```

### Svg icons
The social media icons on the bottom looked squished. I couldn't figure out a more clever way to fix that 
so I created a new file `assets/css/custom.css` and added in

```
.svg-icon {
    ...
    padding-right: 0px;
    vertical-align: middle;
    margin-right: 5px;
}
```
