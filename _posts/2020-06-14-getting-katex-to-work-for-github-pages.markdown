---
layout: post
title:  "KaTeX for Github Pages"
date: 2020-06-14 4:00:00
description: KaTeX is a JavaScript library that renders LaTeX faster than MathJax. Unfortunately, Github Pages does not support the jekyll-katex plugin, but there is a way around that by building the site locally and pushing the contents of the site to master.

tags: 
    - jekyll
    - github
    - katex
    - latex
---
## What Happens on GitHub
When you push the code of your static website to Github, Github builds and serves the site much like how you 
can locally build and serve the site. Now, here's an important distinction I never picked up on from the [tutorial](https://help.github.com/en/github/working-with-github-pages/creating-a-github-pages-site):
1. If you're pushing to a directory named `USERNAME.github.io`, then you are setting up a user website, and 
the code *must* be pushed to the `master` branch.
2. If you're not pushing to a directory named as such, then you're setting up a project website, and the code *needs* 
to go into a branch named `gh-pages`.

### Dependencies and Plug-ins
Github Pages provides a really nice service of hosting these static sites. It comes with a caveat though which is only 
[certain plug-ins will be supported](https://pages.github.com/versions/). This means that some of the newer ones that people 
use a lot on non-Github Pages hosted sites such as `jekyll-paginate-v2` and `jekyll-tagging` will not let your site be 
built and served by Github.

One of these unsupported plug-ins is `jekyll-katex`. I'll try to explain how I got it to 'work' on Github Pages.

## Getting KaTeX (or Other Custom Plug-in) to Work
[KaTeX](https://katex.org/) was developed by Khan Academy. There are a few Jekyll plug-ins for it, and the one I used is 
`jekyll-katex` where more documentation can be found [here](https://github.com/linjer/jekyll-katex). First, let's go 
through the steps of getting it to work *locally*.

### Locally Building and Serving
As per the instructions we'll have to include the plug-in in our `_config.yml` and also in the `Gemfile`. Next, 
we need to run `bundle install` to make sure the dependency will be installed within `vendor/bundle`.

Next, we want to link the CSS needed by putting the following within the `<head>` tag of the `_includes/head.html` file:

```
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.css" integrity="sha384-zB1R0rpPzHqg7Kpt0Aljp8JPLqbXI3bhnPWROx27a9N0Ll6ZP/+DiW/UqRcLbRjq" crossorigin="anonymous">
```

For me, rebuilding and serving the site allows {% katex %}\KaTeX{% endkatex %} to render! FYI, I sometimes get a warning:

```
Found a Liquid block containing the excerpt separator "\n\n". 
```

when I encapsulate my entire post in a mixed environment tag. This [open issue references the warning](https://github.com/linjer/jekyll-katex/issues/25). 
{% katexmm %}$\KaTeX${% endkatexmm %} is powerful because it comes with some packages already installed.

### Only Serve Content on Github

When we build the site, all the HTML goes into the folder `_site`. If we want the website to work for Github Pages, then 
we need to only upload the contents *inside* `_site` to the `master` branch. However, it's good to keep the source code also 
in the same repository, but on a separate branch. I followed this [tutorial](https://www.drewsilcock.co.uk/custom-jekyll-plugins) that 
showed me how to separate the two branches to get this to work.  

There were two things that I had to do differently.
1. The `git branch --set-upstream master origin/master` command is outdated so I had to do `git branch --set-upstream-to=origin/master master`.
2. I couldn't get the `git remote add origin https://github.com/USERNAME/USERNAME.github.io` to work and had to instead do 
`git remote set-url origin https://USERNAME@github.com/USERNAME/USERNAME.github.io.git`.

There's also a bash script that is provided to automate this process but I couldn't get it to work. 
I have all my source code in a branch called `gh-pages` and the `master` branch lives within the `_site` folder.
This is what does work for me:

1. Always test locally in the root directory of your project. This is the level where you have the folders `_site`, `_includes`, etc.
   ```
   bundle exec jekyll serve
   ```
   This rebuilds the website where you can see it at your localhost.
2. When are you ready to commit, be sure to rebuild to regenerate all of the files in `_site`. Be sure to 
include the `.nojekyll` file in `_site` which lets Github know to only generate the site from the HTML.
    ```
    git checkout gh-pages
    git add .
    git commit -am 'update source code`
    git push origin gh-pages
    touch _site/.nojekyll
    cd _site
    git add .
    git commit -am 'update website html'
    git push origin master -f
    ```

This is probably not the best practice when it comes to Git...but it does the job.

### Bash Script
I reformatted these commands into 
the bash script in the tutorial to avoid having to type this out each time and to have the same commit message for both 
branches.

```
#!/bin/bash

# https://gist.github.com/drewsberry/1b9fc80682edd8bcecc4

if [[ -z "$1" ]]; then
  echo "Please enter a git commit message."
  exit
fi

git checkout gh-pages && \
git add . && \
git commit -am "$1" && \
git push origin gh-pages && \
echo "Source successfully pushed to GitHub."
bundle exec jekyll build && \
touch _site/.nojekyll && \
cd _site && \
git add . && \
git commit -am "$1" && \
git push origin master && \
cd .. && \
echo "Site successfully build and pushed to GitHub."
```