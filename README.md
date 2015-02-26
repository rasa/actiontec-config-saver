# Actiontec Config Saver [![Flattr this][flatter_png]][flatter]

Saves the configuration pages of your Actiontec router as `.html` files.

## Quick Start

To run actiontec-config-saver:

1. Install ruby.

2. Install [watir](http://watir.com/installation/)

3. Run:
	````bash
	$ git clone https://github.com/rasa/actiontec-config-saver
	$ cd actiontec-config-saver
	$ cp config.rb.example config.rb
	$ vi config.rb
	$ ruby run.rb
	````

You will need Firefox or Chrome installed. If you use Chrome, change

````ruby
    @b = Watir::Browser.new
````

to

````ruby
    @b = Watir::Browser.new :chrome
````
in the beginning of [actiontecconfigsaver.rb](actiontecconfigsaver.rb).

## Contributing

To contribute to this project, please see [CONTRIBUTING.md](CONTRIBUTING.md).

## Bugs

To view existing bugs, or report a new bug, please see [issues](../../issues).

## Changelog

To view the version history for this project, please see [CHANGELOG.md](CHANGELOG.md).

## License

This project is [MIT licensed](LICENSE).

## Contact

This project was created and is maintained by [Ross Smith II][] [![endorse][endorse_png]][endorse]

Feedback, suggestions, and enhancements are welcome.

[Ross Smith II]: mailto:ross@smithii.com "ross@smithii.com"
[flatter]: https://flattr.com/submit/auto?user_id=rasa&url=https%3A%2F%2Fgithub.com%2Frasa%2Factiontec-config-saver
[flatter_png]: http://button.flattr.com/flattr-badge-large.png "Flattr this"
[endorse]: https://coderwall.com/rasa
[endorse_png]: https://api.coderwall.com/rasa/endorsecount.png "endorse"

