---
layout: post
title:  "Creating My Jekyll Site"
categories: jekyll update
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
I made sure to have the theme explicity specified as `theme: minima` in `_config.yml` before I merged and pushed.

### Random Text for Now