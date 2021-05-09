YAZ-CLIENT
==========

Install Homebrew

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install Yaz

```bash
brew install yaz
```


Read the [YAZ Docs](http://www.indexdata.com/yaz/doc/), [find a z39.50 target](http://irspy.indexdata.com/), review [bib-1 attribute set](https://www.loc.gov/z3950/agency/defns/bib1.html), and give it a whirl.


```bash
# start Yaz connection to Library of Congress z39.50
# z39.50 server is running on port 7090, via voyager
yaz-client z3950.loc.gov:7090/voyager

# open the connection for searching
open z3950.loc.gov:7090/voyager

# Send a boolean query
find @and cats hot

# Use Bib-1 Attributes (find "" in 245)
find @attr 1=4 "rocco di pietro"

# Use Bib-1 Attributes to search ISBN
find @attr 1=7 "9780674015432"

# Return one record
s 1

# Change record format
format xml
format marc21

# Display client settings
list_all

# capture records in file
set_marcdump /Users/Derek/Desktop/download.mrc

# find available commands and options
help

# close the connection
close

# Exit the client
exit

```

### Innovative Interfaces, Sierra
The standard z39.50 port is *210*

```bash
# Yaz connection to State Library of Ohio z39.50
yaz-client catalog.library.ohio.gov:210/innopac

# Open connection for search
open catalog.library.ohio.gov:210/innopac

# Grab a specific bibliographic record
find @attr 1=12 "b2769533"

# Show the MARC
s 1

# Change the output format to OPAC for additional info
format opac

> Data holdings 0
> localLocation: Stacks
> callNumber: RA790 .M613 2018
> publicNote: AVAILABLE
```

### Evergreen ILS
```bash
# Yaz Connection
yaz-client galion.cool-cat.org:210

# Open Galion database
open galion.cool-cat.org:210/galion

# Find some cats
find cats

# Return cat at index 1
show 1
```
