# Asynchronous Server Technologies - Final project

*Asynchronous Server Technologies - ECE Paris (2017)*  
*Professor - Mr. César Berezowski*  

[![Build Status](https://travis-ci.org/Riemannn/AST_Final_Project.svg?branch=master)](https://travis-ci.org/Riemannn/AST_Final_Project)

Simple web application for ski enthusiasts, running on a NodeJS Express server.

## Tools used

Our app is running on an **Express NodeJS** server, and coded in **CoffeeScript**.  
Front end part was made using **transpilers (Pug & Stylus)**.  
Versioning was setup using **Git**, and **Github**, where you can [find our repository](https://github.com/Riemannn/AST_Final_Project).  
Coding was made exclusively on **Atom**, using the following packages :

* editorconfig
* atom-jade (for pug syntax)
* language-stylus (for stylus syntax)
* linter-coffeelint

We strongly advise you to use the same packages for a best experience.

## Installation

Ok, let's start now ! 😃  
To begin using our project, you need to install it first.

### Local

To install it locally, you will need :

* a working computer
* your favorite terminal
* **Node** and **npm** installed and up-to-date (you can check with `node -v` and `npm -v`)

Now, open your terminal, `cd` to a directory where you want to clone our project, and do the following :
```shell
>   git clone git@github.com:Riemannn/AST_Final_Project.git
>   cd AST_Final_Project
>   npm install
>   cp .env.example.coffee .env.coffee # Mandatory for the project to work
>   cp .editorconfig.example .editorconfig # Optional
>   npm start
```

It is recommended to take a look inside the generated `.env.coffee` file to see the set environment variables.  
If you wish to change the server's hosting IP address or port, you can do so in this same file.  

And that's all ! Your app is now up and running, all you need to do is open a web browser, and go to http://127.0.0.1:8080 or https://127.0.0.1:8443 (or, if you changed the environment variables, the corresponding address).

## Populate database

If you wish to populate the database with dummy data, we created a script that does it for you. All you need to do is start your server with `npm start`, and then open another terminal, and type the following command : `npm run db-seed`. This script requires you to have the `curl` package installed.

## Presentation

When you arrive on our app, you should be redirected on the login page at first. If you're calling the HTTP port (8080 by default), you're gonna be redirected to HTTPS also (8443 by default).

There, you can either register with a new profile, or if you ran the script to populate the database, login with one of the 3 users created (first@user.com / first ; second@user.com / second ; third@user.com / third).

Once logged in, you're automatically redirected on your dashboard, with a graph of your skiing top speeds.  
You can add new metrics by filling the form directly above of the graph. The graph will automatically change without you needing to reload the page.

You can also logout with the button in the left navbar, and connect as another user, or create another profile.

## Lint & Tests

For our project, we used the npm package **coffeelint** to lint all our CoffeeScript code inside the `src/` folder. We used custom rules, that you can see in the `coffeelint.json` file, trying to be as strict as possible to have a uniform code over our app. To verify that our code is well linted, you can type the following command at the root of the project :
```shell
>   npm run lint # Should only warn on the console.log() in the src/main.coffee file
```

For testing, we used two node modules : **mocha** and **should**.  
We only tested our models methods, testing the rest was not really useful.  
Tests can be found under the `tests` folder. To run the tests locally, you can run the following command :
```shell
>   npm test
```
This won't work if you ran the database populate script, or created a user manually. The database must be empty.
We also implemented Continuous Integration, with Travis CI. You can see the pipelines results by [clicking here](https://travis-ci.org/Riemannn/AST_Final_Project).  
We put the Travis status badge of our master branch at the top of this README file.

## Contributors

Alexandre Pielucha & Marie Perin

## License (ISC)

Copyright (C) 2017 Alexandre Pielucha & Marie Perin

Permission to use, copy, modify, and/or distribute this software for any  
purpose with or without fee is hereby granted, provided that the above  
copyright notice and this permission notice appear in all copies.  

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES  
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF  
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR  
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES  
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION  
OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN  
CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
