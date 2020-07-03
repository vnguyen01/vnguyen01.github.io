---
layout: post
title:  "Mean Absorption Coin Toss Problems"
date: 2020-06-20 12:00:00
description: Coin toss problems that ask for the average number of flips until a certain sequence appears can be formulaically solved by 3 closely related methods.
tags:
    - coin
    - probability
---
## Overview
{% katexmm %}
These problems appear as follows:
- How many coin tosses would it take on average until we see 3 consecutive heads?
- What is the expected number of coin flips until the first heads appears on an even flip?
- What is the expected number of times a person must toss coins until the pattern $HTH$ emerges?

In the above, we are asked to compute an expected waiting time until some sequence occurs, and 
in a given trial, this prescribed sequence will *always* occur after some number of coin tosses. Let's use the 
first example problem, the waiting time until $HHH$, for the different methods of solving.

## Using System of Equations
### Expected Value
The expected value for a discrete random variable $X$ is defined as the sum over all values that $X$ can take multiplied by
 its probability of occurrence:
$$
 \begin{aligned}
    \text{E}[X] &= \sum_{i} x_i \times \text{Pr}[X=x_i]
 \end{aligned}
$$
Let the discrete random variable $X$ be defined as the number of coin tosses or flips until 3 consecutive heads appear.
 If we denote the probability of heads, $\text{Pr}[H] = p$, and of tails, $\text{Pr}[T] = q$, where $p+q=1$,
 then the expected number of flips until $HHH$ appears is
$$\begin{aligned}
     \text{E}[X] &= \overbrace{3 \times \text{Pr}[X = 3]}^{\{HHH\}}  + \overbrace{4 \times \text{Pr}[X = 4]}^{\{THHH\}}+  \overbrace{5 \times \text{Pr}[X = 5]}^{\{TTHHH, \hspace{0.5ex}HTHHH\}}+ \cdots\\
     &= 3p^3 + 4qp^3 + 5(q^2p^3 + pqp^3) + \cdots\end{aligned}$$
### Conditional Expectation
Instead of figuring out what this power series converges to, we can simplify our problem by rewriting the expected value conditioned on the variable $Y$:
$$
\begin{aligned}
    \text{E}[X] &= \text{E}[\text{E}[X|Y]]= \sum_{i}\text{Pr}[Y = y_i] \times \text{E}[X|Y=y_i]
\end{aligned}
$$

We will define $Y$ as the possible outcomes of our first coin flip so that
$$
\begin{aligned}
\text{E}[X] &= \text{Pr}[Y=H] \times \text{E}[X|Y=H] + \text{Pr}[Y=T] \times \text{E}[X|Y=T]
\end{aligned}
$$

If the first flip is $H$, then we've increased the number of flips by 1 and the remaining flips left can be defined as $\text{E}[X|H]$, a quantity that is conditioned on the fact we just flipped $H$. But if the next flip is $T$, then we've also increased the number of flips by 1. However, the remaining flips left, $\text{E}[X|T]=\text{E}[X]$ because flipping $T$ does not get us further along towards $HHH$. Therefore,
$$
\begin{aligned}
    \text{E}[X|Y=H] &= 1 + \text{E}[X|H]\\
    \text{E}[X|Y=T] &= 1 + \text{E}[X]
\end{aligned}
$$
In addition, $\text{Pr}[Y=H] = \text{Pr}[H]$ and $\text{Pr}[Y=T] = \text{Pr}[T]$ because the individual coin tosses are independent. In other words, probability of heads or tails does not change depending on the toss number.
### General Form
Using the same logic to write $\text{E}[X|H]$ and $\text{E}[X|HH]$ as conditional expectations, our equations are
$$\begin{aligned}
    \text{E}[X] &= p(1+\text{E}[X|H]) + q(1+\text{E}[X])\\
    \text{E}[X|H] &= p(1+\text{E}[X|HH]) + q(1+\text{E}[X])\\
    \text{E}[X|HH] &= p(1+\text{E}[X|HHH]) + q(1+\text{E}[X])
\end{aligned}$$
where $\text{E}[X|HHH]=0$ because no more flips are needed if we've already gotten $HHH$. Using $p+q=1$ and rearranging our unknowns and constants gives
$$\begin{aligned}
\left.
    \begin{alignedat}{4}
      p\text{E}[X] & {}-{}  p& {}\text{E}[X|H]{} &   {}+{}  & 0     & = 1 \\
      -q \text{E}[X]  &  {}+{} & {}\text{E}[X|H]{}   & {}-{} p&\text{E}[X|HH]  & = 1 \\
      -q\text{E}[X] &  {}+{}  & {}0{}    & {}+{} &\text{E}[X|HH]  & = 1
    \end{alignedat}
     \right\} \quad \begin{bmatrix}
     p & -p & 0\\
     -q & 1 & -p\\
     -q & 0 & 1 \\
     \end{bmatrix}
     \begin{bmatrix}
     \text{E}[X]\\
     \text{E}[X|H]\\
     \text{E}[X|HH]\\
     \end{bmatrix}=
     \begin{bmatrix}
     1\\
     1\\
     1\\
     \end{bmatrix}
\end{aligned}$$
For a fair coin, $p=q=1/2$,
$$\begin{aligned}
     \begin{bmatrix}
     \text{E}[X]\\
     \text{E}[X|H]\\
     \text{E}[X|HH]\\
     \end{bmatrix}=\begin{bmatrix}
     1/2 & -1/2 & 0\\
     -1/2 & 1 & -1/2\\
     -1/2 & 0 & 1 \\
     \end{bmatrix}^{-1}
     \begin{bmatrix}
     1\\
     1\\
     1\\
     \end{bmatrix}=\begin{bmatrix}
     8 & 4 & 2\\
     6 & 4 & 2\\
     4 & 2 & 2 \\
     \end{bmatrix}\begin{bmatrix}
     1\\
     1\\
     1\\
     \end{bmatrix}=\begin{bmatrix}
     14\\
     12\\
     8\\
     \end{bmatrix}
\end{aligned}$$
Therefore, **the expected number of flips before obtaining $HHH$ is 14**. If we start with $HH$ already,
 then the expected number of flips remaining becomes 8. By conditioning on the first move, we've actually
  used something called *first step analysis* to solve this problem. This technique finds many applications
   in problems that involve finding mean absorption times. Keep in mind the matrix inversion operation above as it
    will soon make another appearance!

## Markov Chain
### Probability of being in given state
From the first step analysis, after any $n$th toss, the coin flip pattern can be in one of 4 states:
- $S_0$: the previous flip was not $H$ or we haven't flipped anything yet ($n=0$)
- $S_1$: the previous flip was $H$
- $S_2$: the previous two flips were $HH$
- $S_3$: the previous three flips were $HHH$

Let's define a probability distribution vector, $\mathbf{x}(n)$, where the $i$th entry 
denotes the probability of being in state $S_i$ on the $n$th flip. Before we've flipped anything, 
$n=0$, there's a 100% chance we are in $S_0$. After $n=1$, there is a $\text{Pr}[H]=p$ we are 
in $S_1$ and a $\text{Pr}[T]=q$ we remain in $S_0$:
$$
\begin{aligned}
     \mathbf{x}(0) = \begin{bmatrix}
1 \\
0\\
0\\
0
\end{bmatrix}, \quad
\mathbf{x}(1) = \begin{bmatrix}
q \\
p\\
0\\
0
\end{bmatrix}
\end{aligned}$$
### Transition Matrix
What about for $n=2$ and so forth? Let's define a matrix $\mathbf{A}$ of $i$ rows and $j$ columns where each 
entry $a_{ij}$ is the probability of moving into $S_j$ on flip $n+1$ given that we started in $S_i$ on 
flip $n$:
$$
\begin{aligned}
\mathbf{A} = \begin{bmatrix}
q & p & 0 & 0 \\
    q & 0 & p & 0 \\
    q & 0 & 0 & p \\
    0 & 0 & 0 & 1
\end{bmatrix}
\end{aligned}
$$
Thus, where the chain can go next depends only on where it was in the previous state. From the law of total probability, each row of this transition matrix must sum to 1.

We can use this matrix to calculate the probability distribution of being in each state on flip $n+1$ given our distribution on flip $n$:
$$\begin{aligned}
    \mathbf{A}\cdot \mathbf{x}(n) &= \mathbf{x}(n+1)
\end{aligned}$$

While $\mathbf{A}$ gives us the probability of transitions in 1 successive flip, what if we wanted to know the probability of going from $S_i$ to $S_j$ in exactly $n > 1$ successive flips? It turns out that raising $\mathbf{A}$ to the power $n$ produces those $n$-step transition probabilities. Thus,
$$\begin{aligned}
    \mathbf{A}^n \cdot \mathbf{x}(0) = \mathbf{x}(n)
\end{aligned}$$

### Existence of an Absorbing State
Is it true that if coins were flipped forever, we would eventually get $HHH$? That is, as we flip coins forever, the probability distribution vector will converge will all the mass in $S_3$:
$$\begin{aligned}
    \lim_{n\to \infty}\mathbf{A}^n \mathbf{x}(0) = \lim_{n\to \infty}\mathbf{x}(n) = \begin{bmatrix}
0 \\
0\\
0\\
1
\end{bmatrix}
\end{aligned}$$

Let us recall how eigenvalues and eigenvectors are related for a matrix,
$$\begin{aligned}
    \mathbf{A}\mathbf{v} &= \lambda \mathbf{v}
\end{aligned}$$
If we calculate the eigenvalues of $\mathbf{A}$, we find the largest eigenvalue to be 1. In fact, the Perron-Frobenius Theorem states that stochastic matrices will always contain $\lambda_{\text{max}} = 1$. This means the eigenvector associated with $\lambda = 1$ fulfills $\mathbf{A}\mathbf{v} = \mathbf{v}$. This eigenvector turns out to be $\mathbf{v} = [0, 0, 0, 1]^T$!
Put another way, when  $\mathbf{x}(n) = \mathbf{v}$, the Markov Chain has been absorbed, $\mathbf{A} \cdot \mathbf{x}(n) = \mathbf{x}(n)$.

### Fundamental Matrix
For absorbing Markov Chains, we can partition the transition matrix into 4 quadrants:
$$
\begin{aligned}
\def\arraystretch{1.2}
\mathbf{A} = \left[
   \begin{array}{ccc|c}
   q & p & 0 & 0 \\
    q & 0 & p & 0 \\
    q & 0 & 0 & p \\ \hline
    0 & 0 & 0 & 1
\end{array}
\right] = \left[
\begin{array}{c|c}
   \mathbf{Q} & \mathbf{R} \\ \hline
   \mathbf{0} & \mathbf{I}
\end{array}\right]
\end{aligned}
$$
- $\mathbf{Q}$ is a square matrix with  probabilities (all less than 1) between transient states
- $\mathbf{R}$ is a rectangular matrix of  probabilities (all less than 1) between transient to absorbing states
- $\mathbf{0}$ is a rectangular matrix denoting transitions between states that never happen (cannot go from $S_3$ to any state other than itself)
- $\mathbf{I}$ is the identity matrix of absorbing states
     
For different powers of $\mathbf{A}$,
$$\begin{aligned}
    \mathbf{A}^2 &= \begin{bmatrix}
\mathbf{Q}^2 & (\mathbf{Q}+\mathbf{I})\mathbf{R}\\
\mathbf{0} & \mathbf{I}
\end{bmatrix}, \quad
\mathbf{A}^3 = \begin{bmatrix}
\mathbf{Q}^3 & (\mathbf{Q}^2 + \mathbf{Q}+\mathbf{I})\mathbf{R}\\
\mathbf{0} & \mathbf{I}
\end{bmatrix}, \quad
\mathbf{A}^n = \begin{bmatrix}
\mathbf{Q}^n & (\sum_{i=0}^{n-1} \mathbf{Q}^i)\mathbf{R}\\
\mathbf{0} &  \mathbf{I}
\end{bmatrix}
\end{aligned}$$

What happens as $n$ goes to $\infty$?
$$\begin{aligned}
\lim_{n \to \infty} \mathbf{A}^n = \begin{bmatrix}
\mathbf{0} & (\mathbf{I}-\mathbf{Q})^{-1}\mathbf{R}\\
\mathbf{0}&  \mathbf{I}
\end{bmatrix}
\end{aligned}$$
where we've used the fact that all the entries of $\mathbf{Q}$ are less than 0 so they should get smaller as $n$ grows bigger. Let's take a closer look at what goes on the upper right corner. Let's define a matrix $\mathbf{N}$ as
$$\begin{aligned}
    \mathbf{N} &= \sum_{i=0}^\infty \mathbf{Q}^i\\
    \mathbf{Q}\mathbf{N} &= \sum_{i=0}^\infty \mathbf{Q}^{i+1}\\
    \mathbf{N} - \mathbf{Q}\mathbf{N} &= \mathbf{I}\\
    \mathbf{N} &= (\mathbf{I}- \mathbf{Q})^{-1}
\end{aligned}$$

This is known as the fundamental matrix, and it's something we've seen before! Recall the matrix inversion that would make a reappearance:
$$\begin{aligned}
    \mathbf{N} = \left(\underbrace{\begin{bmatrix}
     p & -p & 0\\
     -q & 1 & -p\\
     -q & 0 & 1 \\
     \end{bmatrix}}_{\text{system of equations}}\right)^{-1} = \left(\underbrace{\begin{bmatrix}
     1 & 0 & 0\\
     0 & 1 & 0\\
     0 & 0 & 1 \\
     \end{bmatrix}}_{\mathbf{I}} - \underbrace{\begin{bmatrix}
     q & p & 0\\
     q & 0 & p\\
     q & 0 & 0 \\
     \end{bmatrix}}_{\mathbf{Q}}\right)^{-1}
\end{aligned}$$

As before, for a fair coin,
$$
\begin{aligned}mathbf{N}=
\begin{bmatrix}
8 & 4 & 2\\
     6 & 4 & 2\\
     4 & 2 & 2 
\end{bmatrix}
\end{aligned}
$$

Each entry in $\mathbf{N}$ contains the expected number of visits that starting in $S_i$ the chain visits $S_j$. Since the chain has to progress through $S_0$, $S_1$, and $S_2$ before it arrives at the absorbing state $S_3$, the expected number of flips to get to $S_3$ starting from $S_0$ is the sum of the first row, $(\mathbf{N}\cdot \mathbf{1})_0$.

#### Equivalency to Powers of $\mathbf{Q}$
There is another way to understand what each entry $n_{ij}$ describes. Let us define the random variable $X_{ij}^n$ which equals
- 1 if the chain ends up in $S_j$ after exactly $n$ flips starting from $S_i$
- 0 otherwise

Furthermore, since we know for some $\mathbf{Q}^n$ that $q_{ij}^n$ is the probability the chain transitions from $S_i$ to $S_j$ in exactly $n$ flips, we have
$$\begin{aligned}
    \text{Pr}[X_{ij}^n = 1] &= q_{ij}^n\\
    \text{Pr}[X_{ij}^n = 0] &= 1-q_{ij}^n
\end{aligned}$$
The expected number of time (not plural since it can't finish up there more than once!) that the chain will end up in $S_j$ after exactly $n$ tosses starting from $S_i$ is
$$\begin{aligned}
    \text{E}[X_{ij}^n] &= 1 \times \text{Pr}[X_{ij}^n = 1] + 0 \times \text{Pr}[X_{ij}^n = 0]\\ &= q_{ij}^n
\end{aligned}$$
Thus, the expected number of times the chain will end up in $S_j$ for all values of tosses from $0$ to $\infty$ given that we start from $S_i$ is
$$\begin{aligned}
    \text{E}[X_{ij}^0 + X_{ij}^1 + X_{ij}^2 + \ldots] &= \text{E}[X_{ij}^0] + \text{E}[X_{ij}^1] + \text{E}[X_{ij}^2] +\ldots\\
    &= q_{ij}^0 +  q_{ij}^1 + q_{ij}^2 + \ldots \\&= n_{ij}
\end{aligned}$$
where $q_{ij}^0 = 1$ only if $j=i$ since if we start in $i$ and no tosses happen, 
we still remain in state $i$. As shown above, we can also arrive at an intuitive understanding 
of the entries of $\mathbf{N}$ from the sum over all powers of $\mathbf{Q}$.

### Absorbing Probabilities
The complete expression at the upper right corner of the partitioned matrix, 
$\mathbf{N}\mathbf{R}$, is a $3\times 1$ rectangular matrix where each entry is the 
probability of absorption given the chain starts in one of the transient states.
$$
\mathbf{N}\mathbf{R} = \begin{bmatrix}
       8 & 4 & 2\\
     6 & 4 & 2\\
     4 & 2 & 2 \\
  \end{bmatrix}\begin{bmatrix}
      0 \\
      0\\
      1/2\\
   \end{bmatrix}=\begin{bmatrix}
      1 \\
      1 \\
      1 \\
    \end{bmatrix}
$$
Since we only have one absorbing state, there is only one column, 
and the probabilities of being absorbed are all 100%. If instead, the 
problem contained a second absorbing state, then we could compare the 
probabilities of being absorbed into the different absorbing state.

## Probability Generating Function
If we flip coins forever, we will eventually reach 3 consecutive heads. But what could we say about all the coin flip patterns before the $HHH$?
$$\begin{aligned}&HHT|T|T|HT\cdots HHH\\
    &T|HT|T\cdots HHH\\
    &T|T|T\cdots HHH\\
    &HT|HHT\cdots HHH\end{aligned}$$
Notice that we could break them up into 3 chunks:
- one or more consecutive $T$s
- a single $H$ followed by a single $T$,
- two $H$s followed by a single $T$

and of course there must be the $HHH$ at the end. Therefore, any sequence is of the form
$$(T, HT, HHT)HHH$$
where each subsequence in the parentheses can be repeated 0 or as many times as possible, in any order, and with each other. Also notice that any combination of these building blocks will not produce 3 consecutive heads. With a probability generating function (PGF), we can generate all the probabilities of the distribution:
$$G_X(z) = \sum_k^\infty \text{Pr}(X=k) \times z^k$$
The variable $z$ is considered a dummy variable whose purpose is to allow the function $G$ to represent the entire probability distribution. To see why, when $z=1$, we are just adding up all the probabilities of outcomes of the random variable $X$ and $G_X(1) = 1$.

### Method of Moments
The powers of $z$ denote the values our random variable $X$ can take. In this case, it would be the number of coin tosses. Its coefficients reflect the probabilities of occurrence. If one takes the first derivative of the function evaluated at $z=1$,
$$G_X'(1) = \sum_k^\infty k \times  \text{Pr}[X=k] = \text{E}[X]$$
and we recover the formula for expected value. Thus, the first moment of a PGF gives the expectation. We can even calculate the variance with the second derivative like so $\text{Var}[X] = G''(1)+G_X'(1)-[G_X'(1)]^2$. Our generating function for $X$ is
$$\begin{aligned}G_X(z) &= \sum_k^\infty (\overbrace{qz+pqz^2+p^2qz^3}^{(T,\hspace{0.5ex} HT,\hspace{0.5ex} HHT)})^k\overbrace{p^3z^3}^{HHH}\\
&= \frac{p^3 z^3}{1- (qz+pqz^2+p^2qz^3)}\end{aligned}$$
For a fair coin, $p=q=1/2$, the first derivative evaluated at $z=1$ is
$$
\begin{aligned}
G_X'(1) &= \frac{(1-q-pq-p^2q)3p^3 - p^3 (-q -2pq -3p^2q)}{(1-q-pq-p^2q)^2} \\
&= \frac{1/8 \times 3/8 + 1/8 \times 11/8}{(1/8)^2} = 14
\end{aligned}$$

## When to Use Which?
For simple formulations of mean absorption problems, I find the first step method with the system of equations to be 
the most intuitive approach. Being able to deconstruct the problem into a conditional expectation also is a straight-forward 
thought process I find. With the Markov approach, having to invert $(\mathbf{I}-\mathbf{Q})^{-1}$ to get the fundamental matrix 
without a computer is 
pretty annoying especially when the matrix is larger than $3 \times 3$. However, when the problem is messy enough, a computer 
is almost always needed unless there's a trick. The PGF approach gives a nice formula for the entire distribution but derivatives can 
also be a pain to do when the problem becomes more complex.

One nice extension of the Markov method is that when there are multiple absorbing states, and the problem additionally asks 
for the relative probabilities of ending up in one state versus the other, you can easily calculate this from $\mathbf{N}\mathbf{R}$; 
for example, if the problem asks what the probability of getting $HTH$ before $HHT$ is. I'll continue to share interesting coin 
flip problems!
{% endkatexmm %}