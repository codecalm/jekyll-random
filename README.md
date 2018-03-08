# Jekyll-Random

A Jekyll plugin that generates _pseudo-random_ data. Very useful when you want to generate a large amount of random data. The plugin is prepared to work with other Jekyll plugins like `jekyll-timeago` or `jekyll-humanize`.

**The data is generated based on index, so that every time when you run `jekyll build`, the generated data is the same.**

## Installation

Simply download the `random.rb` file and place it in the `_plugins` directory of your Jekyll site.


## Usage

Each of the methods in the file presents an available Fluid type filter to be used in Jekyll templates. Thanks to this you can manipulate the generated data.

### random_number(_index_, _min=0_, _max=100_, _round=0_)

Return a number between _min_ and _max_ based on _index_. By default it returns a number between 0 and 100.

```ruby
{% for i in (1..100) %}
  {{ i }} - {{ forloop.index | random_number: 0, 10 }}
{% endfor %}
```

The code above returns random numbers like:

```
1 - 6
2 - 1
3 - 6
4 - 8
5 - 4
6 - 7
7 - 1
...
```

You can also change the `round` parameter to generate fractions:

```ruby
{% for i in (1..100) %}
  {{ i }} - {{ forloop.index | random_number: 0, 100, 2 }}
{% endfor %}
```

The result of code above:

```
1 - 42.98
2 - 0.08
3 - 96.59
4 - 6.81
5 - 36.91
6 - 7.06
7 - 80.38
...
```

### random_item(_index_, _items_)

Return random item from _items_ array based on _index_. _items_ can be array, collection, or data file. 

```ruby
{% assign colors = 'red|green|blue|yellow|orange' | split: '|' %}
{% for i in (1..100) %}
  {{ i }} - {{ forloop.index | random_item: colors }}
{% endfor %}
```

The results:

```
1 - blue
2 - blue
3 - red
4 - yellow
5 - yellow
6 - red
7 - red
8 - yellow
...
```

### random_date(_index_, _start_date=false_, _end_date=false_)

Return random date between _start_date_ and _end_date_. By default, it returns the date between 100 days ago and now. Returned date you can format by `date` filter to get expected result. This filter is useful when you generate birth date or register date. 

```ruby
{% for i in (1..100) %}
  {{ i }} - {{ forloop.index | random_date: "2010-01-01", "2018-01-01" | date: '%B %d, %Y' }}
{% endfor %}
```

```
1 - May 23, 2016
2 - January 31, 2017
3 - August 10, 2014
4 - December 08, 2016
5 - January 22, 2016
6 - November 16, 2015
7 - June 09, 2013
...
```

### random_date_ago(_index_, _days_ago=100_)

This filter works similar to `random_date`, but returns random date between today and date _days_ago_ ago. By default return date between now and 100 days ago. It is helpful to generate random data like last login date. If you additionally use the `jekyll-timeago` filter you can get date in _2 days ago_ format.

```ruby
{% for i in (1..100) %}
  {{ i }} - {{ forloop.index | random_date_ago: 10 | timeago }}
{% endfor %}
```

Results:

```
1 - 6 days ago
2 - yesterday
3 - 6 days ago
4 - 1 week ago
5 - 4 days ago
6 - 1 week ago
7 - yesterday
...
```

You can also change _days_ago_ parameter to negative number like `{{ forloop.index | random_date_ago: -10 | timeago }}` to get date in future:

```
1 - today
2 - in 1 week
3 - tomorrow
4 - tomorrow
5 - in 2 days
6 - in 2 days
7 - in 4 days
8 - in 5 days
9 - in 1 week
...
```

## Generate data based on the same index

Sometimes you want to generate data in the same row with the same parameters. Because this plugin generate pseudo-random data every returned number will be the same:

```ruby
{% for i in (1..5) %}
  {{ i }} - {{ forloop.index | random_number }}, {{ forloop.index | random_number }}, {{ forloop.index | random_number }}
{% endfor %}
```

The above code returns a code that does not meet our expectations, because every time returns the same data:

```
1 - 42, 42, 42
2 - 0, 0, 0
3 - 96, 96, 96
4 - 6, 6, 6
5 - 36, 36, 36
...
```

To fix it, simply add a random number to `index` parameter: `{{ forloop.index | plus: 156 | random_number }}`. Thanks to this the results will be different to every index.

```
1 - 42 - 47 - 55
2 - 0 - 87 - 96
3 - 96 - 15 - 81
4 - 6 - 12 - 59
5 - 36 - 8 - 20
...
```

## Sample code

To see how useful this plugin is, try to run the code below. Remember to set few random data in `_config.yml` file:

```yml
users:
  - name: Tate
    surname: Nesfield
    email: tnesfield0@scribd.com
  - name: Thelma
    surname: Muirden
    email: tmuirden1@google.com
  ...
  
commits:
  - Push poorly written test can down the road another ten years
  - This will definitely break in 2020 (TODO)
  ...
```

_index.html_

```html
{% assign colors = 'red|green|blue|yellow|orange' | split: '|' %}
<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Percentage</th>
        <th>Age</th>
        <th>Status</th>
        <th>Register date</th>
        <th>Last login</th>
        <th>Commit</th>
    </tr>
    {% for user in site.users %}
    <tr>
        <td>{{ forloop.index }}</td>
        <td>{{ user.name }} {{ user.surname }}</td>
        <td>{{ user.email }}</td>
        <td>{{ forloop.index | random_number }}%</td>
        <td>{{ forloop.index | random_number: 25, 55 }}</td>
        <td>{{ forloop.index | random_item: colors }}</td>
        <td>{{ forloop.index | random_date: "2010-01-01", "2018-01-01" | date: '%B %d, %Y' }}</td>
        <td>{{ forloop.index | random_date_ago: 10 | timeago }}</td>
        <td>{{ site.commits[forloop.index] }}</td>
    </tr>
    {% endfor %}
</table>
```

Results:

```
ID  Name                Email                        Percentage  Age  Status  Register date       Last login   Commit
1   Tate Nesfield       tnesfield0@scribd.com        42%         31   blue    May 23, 2016        6 days ago   This will definitely break in 2020 (TODO)
2   Thelma Muirden      tmuirden1@google.com         0%          50   green   January 31, 2017    yesterday    yet another quality commit
3   Ros Rawstorne       rrawstorne2@furl.net         96%         37   red     August 10, 2014     6 days ago   fuckup.
4   Marco Newburn       mnewburn3@eventbrite.com     6%          47   blue    December 08, 2016   1 week ago   some brief changes
5   Tessie Lack         tlack4@nytimes.com           36%         33   green   January 22, 2016    4 days ago   herpderp (redux)
6   Cinderella Illwell  cillwell5@mayoclinic.com     7%          28   red     November 16, 2015   1 week ago   PEBKAC
7   Jermaine Marston    jmarston6@independent.co.uk  80%         40   green   June 09, 2013       yesterday    Hide those navs, boi!
8   Harlan Oliveti      holiveti7@cam.ac.uk          83%         26   blue    May 31, 2013        2 days ago   I'm totally adding this to epic win. +300
9   Lillis Riddler      lriddler8@de.vu              73%         27   green   July 31, 2011       1 week ago   Bit Bucket is down. What should I do now?
10  Marlowe Rabson      mrabson9@wufoo.com           79%         31   green   October 08, 2013    3 days ago   This really should not take 19 minutes to build.
11  Vera Doggart        vdoggarta@fastcompany.com    94%         36   red     July 28, 2014       6 days ago   This is why the cat shouldn't sit on my keyboard.
12  Lari Webling        lweblingb@umn.edu            90%         39   red     April 29, 2013      3 days ago   The same thing we do every night, Pinky - try to take over the world!
13  Annabela Apps       aappsc@lulu.com              8%          32   green   December 02, 2013   1 week ago   Does this work
14  Hurlee Teaser       hteaserd@webeden.co.uk       44%         31   green   August 03, 2011     4 days ago   Some bugs fixed
15  Natty Blois         nbloise@zdnet.com            0%          36   green   June 16, 2016       5 days ago   I was wrong...
```

## Development

Any kind of feedback, bug report, idea or enhancement are really appreciated. To contribute, just fork the repo, hack on it and send a pull request.

## License

Copyright (c) Paweł Kuna. Jekyll-Random is released under the MIT License.

## Contribute

1. [Fork](https://github.com/codecalm/jekyll-random/fork) this repo.
2. Create a branch `git checkout -b my_feature`
3. Commit your changes `git commit -am "Added Feature"`
4. Push to the branch `git push origin my_feature`
5. Open a [Pull Request](https://github.com/codecalm/jekyll-random/pulls)