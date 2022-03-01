---
layout: post
title:  "HH or TH first?"
date: 2022-02-28 12:00:00
description: What is more likely to be first observed, HH or TH?
tags:
    - coin
    - probability
---
## Overview
{% katexmm %}
Let's say you keep flipping a fair coin until you observe $HH$. How many flips on average would that take?
What about until you observe $TH$? Since both sequences occur 
individually with probability $1/4$, they should equally have the same
expected number of flips... right?

We can solve this with a system of equations using conditional expectations or by
inverting the fundamental matrix, but let's tackle it with probability generating functions. 

## Expected Number of Flips
### Case 1: HH
Of the infinite number of sequences of some size $n$ that end in $HH$, the previous string of size $n-2$ 
must be of some combination $(T, HT)$.
$$\begin{aligned}&HT|T|T|HT\cdots HH\\
    &T|HT|T\cdots HH\\
    &T|T|T\cdots HH\\
    &HT|HT\cdots HH\end{aligned}$$
Let $X$ be the number of flips until $HH$. Using a dummy variable $z$,
the PGF for $X$ is
$$
\begin{aligned}
G_X(z) &= \sum_{k=0}^\infty (\overbrace{qz + pqz^2}^{(T, HT)})^k \overbrace{p^2z^2}^{HH}
\end{aligned}
$$
Plugging in $p=q=1/2$ and simplifying:
$$
\begin{aligned}
G_X(z) &= \sum_{k=0}^\infty \left(\frac{z}{2} + \frac{z^2}{4}\right)^k \frac{z^2}{4}\\
&=\frac{z^2}{4} \sum_{k=0}^\infty \left(\frac{z}{2} + \frac{z^2}{4}\right)^k \\
&= \frac{z^2}{4} \left( 1+ \sum_{k=1}^\infty \left(\frac{z}{2} + \frac{z^2}{4}\right)^k \right)\\
&= \frac{z^2}{4} \left( 1+ \sum_{k=0}^\infty \left(\frac{z}{2} + \frac{z^2}{4}\right)^{k+1} \right)\\
&= \frac{z^2}{4} \left( 1+ \left(\frac{z}{2} + \frac{z^2}{4}\right) \sum_{k=0}^\infty \left(\frac{z}{2} + \frac{z^2}{4}\right)^k \right)\\
&= \frac{z^2}{4} + \frac{2z^3+z^4}{4z^2} G_X(z)\\
G_X(z) - \frac{2z^3+z^4}{4z^2} G_X(z) &= \frac{z^2}{4}\\
G_X(z) &= \frac{z^2}{4} \times \frac{4z^2}{4z^2 - 2z^3 - z^4}\\
&= \frac{z^2}{4-2z-z^2}
\end{aligned}
$$
As a sanity check, the PGF function equals $1$ for $z=1$, so our function that 
encapsulates all of the probabilities adds up to $1$, which it should. The expected number of flips is 
the first derivative where $z=1$:
$$
\begin{aligned}
G_X'(z) &= \frac{2z(4-z)}{(4-2z-z^2)^2}
\end{aligned}
$$
This gives 6 flips. The variance, $G_X''(z) + G_X'(z) - G_X'(z)^2 = 52 + 6 - 36 = 22$.

### Case 2: TH
All $n-2$ sequences for strings ending with $TH$ have a different sort of pattern.
 They are either just a string starting with $T$s or starting with a bunch of $H$s followed by a bunch of $T$s. Let's see 
this for each $k = n - 2$,
- $k=0$: This is just the sequence $TH$. Out of the possibilities $\{HT, TH, HH, TT\}$, this occurs with probability $1/4$.
- $k=1$: This could be $\{TTH, HTH\}$. Out of the 8 other sequences of length 3, this has probability also $1/4$.
- $k=2$: This could be $\{TTTH, HHTH, HTTH\}$. This has probability $3/16$.

Notice that for some $k$, the prefix string would include one with all $T$s, all $H$s, $k-1$ $H$s ending with a single $T$,
 $k-2$ $H$s ending with two $T$s, etc. So, for each $k$, there are $k+1$ different strings and each occur with probability $1/2^{k+2}$. 
Let $Y$ be the number of flips until $TH$. Our PGF is
$$
\begin{aligned}
G_Y(z) &= \sum_{k=0}^\infty \overbrace{(k+1) \frac{z^k}{2^k}}^{(T\cdots T, H\cdots HT \cdots T)} \overbrace{\frac{z^2}{4}}^{TH}\\
&= \frac{z^2}{4} \left(1 + \sum_{k=1}^\infty (k+1) \frac{z^k}{2^k}\right)\\
&= \frac{z^2}{4} \left(1 + \sum_{k=0}^\infty (k+2) \frac{z^{k+1}}{2^{k+1}}\right)\\
&= \frac{z^2}{4} \left(1 + \frac{z}{2}\sum_{k=0}^\infty (k+2) \frac{z^k}{2^k}\right)\\
&= \frac{z^2}{4} \left(1 + \frac{z}{2}\left(\sum_{k=0}^\infty (k+1) \frac{z^k}{2^k} + \sum_{k=0}^\infty \frac{z^k}{2^k} \right) \right)\\
&= \frac{z^2}{4} \left(1 + \frac{2}{z} G_Y(z) +  \frac{z}{2-z}  \right)\\
&= \frac{z^2}{(z-2)^2}\\
G_Y'(z) &= -\frac{4z}{(z-2)^3}
\end{aligned}
$$
The expected number of flips is... 4! And the variance is 16.

### But Why?
This might seem at first counter intuitive. Actually, solving this as a system of equations may have shed light on why, but PGF are more fun. 
For $HH$, no progress is made until a $H$ appears. And yet, another $H$ must immediately follow to see $HH$--a $T$ will bring you back to no progress. 
For $TH$, no progress is made until a $T$ appears. But once this happens, even if a $H$ doesn't immediately follow, another $T$ won't bring us all the way back to no progress. It will 
be like if once we make the first step, we never regress whereas in the $HH$ case, it's possible to regress back.

## Probability of HH before TH
Let $W$ be the event of observing $HH$ before $TH$.
$$
\begin{aligned}
P(W) &= P(H) P(W|H) + P(T) P(W|T)\\
&= \frac{1}{2} P(W|H) + \frac{1}{2} P(W|T)\\
P(W|H) &= P(H) P(W|HH) + P(T) P(W|T)\\
&= \frac{1}{2} \times 1 + \frac{1}{2} P(W|T)\\
P(W|T) &= P(H) P(W|TH) + P(T) P(W|T)\\
&= \frac{1}{2} \times 0 + \frac{1}{2} P(W|T)\\
&= 0
\end{aligned}
$$
The reason it's impossible to win once a $T$ appears is because we get trapped in an absorbing state towards $TH$. A single $H$ will result in $TH$ occurring and 
any $T$s is just delaying the inevitable. Plugging everything in gives $P(W|H) = 1/2$ and $P(W) = 1/4$.

If we instead did $HH$ versus $HT$, then it's equally likely to see either. That's because any $T$s before a $H$ doesn't lead to progress for either, and 
once a $H$ shows up, it's equally likely for the next flip to be a $H$ or a $T$ which completes either sequence (for a fair coin). So $P(W) = 1/2$... even though 
the expected flips until we see $HT$ is... 4.
{% endkatexmm %}