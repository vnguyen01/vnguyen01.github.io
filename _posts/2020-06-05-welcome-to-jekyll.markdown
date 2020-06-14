---
layout: post
title:  "Creating My Jekyll Site"
---
## Jekyll Minima Site from Scratch
I had no idea what Jekyll is but heard that it's an easy way to set up a clean website for a blog. I still found several 
aspects to be challenging. The instructions from the 
[github quickstart](https://help.github.com/en/github/working-with-github-pages/creating-a-github-pages-site-with-jekyll) 
did help for the most part. I had been testing my site locally and everything worked!

However, when I pushed everything to the repository `vnguyen01.github.io` in the branch `gh-pages` as specified by the 
instructions, no website appeared. 
It turns out that it needs to go into the `master` branch in order to serve on Github. This [stackoverflow post](https://stackoverflow.com/questions/25559292/github-page-shows-master-branch-not-gh-pages) 
made things a lot more clear, but maybe I just wasn't following instructions correctly.

Another frustrating thing, as you'll see later, I opted to customize and build upon the Minima theme so my site has no 
set theme from the `_config.yml`. [It turns out you also need to specify a theme or else the website won't load](https://github.community/t/page-not-showing-the-theme/10340/4). 
Another thing I didn't find very obvious from the get go. So, I went into `settings` on my repository page, scrolled 
all the way down until I got to GitHub Pages, and clicked `Choose a Theme`. 

At this point, it turns out that none of the themes was Minima, so I clicked on random one. But I did this before merging 
`gh-pages` into `master`, so now I have a working website at least but everything I want is still in the other branch. 
I merged, basically overriding all the files in `master` since it was just the chosen theme with none of my previous work. This time, 
I made sure to have the theme explicitly specified as `theme: minima` in `_config.yml` before I merged and pushed.

One thing that is *very* annoying is a page might look normal when serve locally but not so when served by Github... and 
for this the only thing I can do is to commit and test often!

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
seem to appear on the same line as the title. Also, some of the icons in the footer appear squished. 
Now, there's probably a much better way to fix this, but after some experimenting with the developer tools in 
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
so edited the `assets/css/minima/_base.scss` file for the relevant class to be

```
.svg-icon {
    ...
    padding-right: 0px;
    vertical-align: middle;
    margin-right: 5px;
}
```

## Bootstrap Table of Contents
### Distribution Files
I followed the instructions from the [Bootstrap TOC plug-in site](https://afeld.github.io/bootstrap-toc/) which involved 
putting the `bootstrap-toc.css` file in `assets/css/` and the `bootstrap-toc.js` file in `assets/js`. In addition, it is 
also suggested to add a [file](https://github.com/afeld/bootstrap-toc/blob/gh-pages/_includes/layout.css) that I've renamed 
to be `bootstrap-toc-layout.css` in `assets/css/`. This additional file allows the TOC to be overridden for small screens 
and for there is be second-level navigation (uncomment the relevant code block).

Again, we need to make sure to modify the `main.scss` file to import these CSS files when our site builds:

```
@import "css/bootstrap-toc.css";
@import "css/bootstrap-toc-layout.css";
```
### Include Attribute in HTML
In order for the TOC to appear, we want to add in the `data-toggle="toc"` attribute in a `<nav>` element. Since I only 
want to TOC to appear in posts, I will modify the layout of `_layout/post.html` where the `<header>` and `{{ content }}` 
normally sits to instead be

```
<div class="row">
  <div class="col-sm-3">
    <nav id="toc" data-toggle="toc" class="sticky-top"></nav>
  </div>
  <div class="col-sm-9">
    <header class="post-header">
      ...
    </header>
    <div class="post-content e-content" itemprop="articleBody">
     ...
    </div>
  </div>  
</div>
```

This allows me to partition the page into a left side which includes my header and content and a right side which 
includes the TOC. Then, you have to modify the body tag in `_layouts/default.html` so it becomes 
`<body data-spy="scroll" data-target="#toc">`.

I want the width of the centered content area to be a bit bigger to I modified the `assets/css/minima.scss` file where
```
// Width of the content area
$content-width:    1000px !default;

$on-palm:          600px !default;
$on-laptop:        1000px !default;
```
### Javascript
Now, we need to open up the `_includes/head.html` file and include `bootstrap-toc.js` script within `<head>`

```
<script
      src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
      integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
      crossorigin="anonymous"
></script>
<script type="text/javascript" src="{{ "/assets/js/bootstrap-toc.js" | relative_url }}"></script>
```

I'm not too familiar with the performance reason, but there's also some javascript that needs to be included and it's 
better to have it in the `_includes/footer.html` file before the `<footer>` tag. 

 ```
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js" integrity="sha384-SlE991lGASHoBfWbelyBPLsUlwY1GwNDJo3jSJO04KZ33K2bwfV9YBauFfnzvynJ" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
```

Re-building the site and serving it should hopefully display the TOC. One might notice that there's an additional item 
in the TOC that comes from the footer. This is because the footer is still part of the body and the TOC will detect 
`<h2>`, `<h3>`, `<h4>` headers. To fix this, I'll just comment out the heading within `_includes/footer.html` for now:

```
<!--<h2 class="footer-heading">{{ site.title | escape }}</h2>-->
```

## Keyword Tags

## Pagination