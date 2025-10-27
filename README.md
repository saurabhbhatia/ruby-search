## Search CLI Utility

### Setup Instructions

- ruby 3.3.4
- httparty

First, clone the repository to your local machine and make sure you have ruby 3.3.4 installed

```
$ bundle install
```

Make the command line executible

```
$ chmod +x search.rb
```

### Usage Instructions

Search by "name"

```
$ ./search.rb --name john
```

Search by "email". This will return search results only when there's an eact match.

```
$ ./search.rb --email john.doe@gmail.com
```

In order to see help

```
$ ./search.rb --help
```

### Running Tests

```
$ ruby tests/search_test.rb
```

### How does the solution work

Name is a partial match. I used ruby's `include?` method to check for the search term as a substring. We downcase both the terms to sanitise the input by downcasing the search term and full name.

```
def find_by_name(search_term)
  @data.select do |item|
    @search_results << item if item["full_name"]&.downcase&.include?(search_term.downcase)
  end
end
```

Email is an exact match. Here I use ruby's regex to do an exact match on the email provided 

```
def find_by_email(search_term)
  @data.select do |item|
    @search_results << item if item["email"]&.downcase&.match?(/^#{search_term.downcase}$/)
  end
end
```

I use ruby's `OptionParser` to parse the command line arguments and generate a little help section.

### Potential areas of improvement

- Currently, the tests connect to the real json via the main search utility file. However, as an improvement, we could mock the http call to the remote json server.s

- Convert `search.rb` into a module and packaged as a ruby gem, so that we can consume it within an another ruby application as a library.