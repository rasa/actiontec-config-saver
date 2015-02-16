# Actiontec Config Saver

actiontec-config-saver saves the configuration of your Actiontec Router as `.html` files.

## Quick Start

To run actiontec-config-saver, do the following:

1. Checkout the repository:
<pre>
$ git clone https://github.com/rasa/actiontec-config-saver.git
</pre>
2. Change to the `actiontec-config-saver` directory:
<pre>
$ cd actiontec-config-saver
</pre>
3. Copy the example `config.rb` script:
<pre>
$ cp config.rb.example config.rb
</pre>
4. Edit `config.rb` to set your router's login credentials:
<pre>
$ vi config.rb
</pre>
5. Run `run.rb`:
<pre>
$ ruby run.rb
</pre>

You will need Firefox or Chrome installed. If you use Chrome, change
````
    @b = Watir::Browser.new
````
to
````
    @b = Watir::Browser.new :chrome
````
in the beginning of `actiontecconfigsaver.rb`.

## Contributing

To contribute to this project, please see [CONTRIBUTING.md](CONTRIBUTING.md).

## Bugs

To view existing bugs, or report a new bug, please see the [issues](/issues) page for this project.

## License

This project is [MIT licensed](LICENSE).

## Changelog

Please see [CHANGELOG.md](CHANGELOG.md) for the version history for this project.

## Contact

This project was originally developed by [Ross Smith II](mailto:ross@smithii.com).
Any enhancements and suggestions are welcome.
