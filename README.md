# Vtracer

This gem is a wrapper of a rust library [VTracer](https://github.com/visioncortex/vtracer). 

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add vtracer
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install vtracer
```

## Usage


```ruby
Vtracer.convert_image_to_svg("/path/to/file/input.jpg", "../can/relative/out_put.svg", layer_difference: 10, max_iterations: 25)
```
                              ↑ input file path           ↑ output file path
Options:

| Option                                                | Description                                                         |
| ------------------------------------------------------| ------------------------------------------------------------------- |
| **colormode** (`"color"`, `"binary"`)                 | True color image `color` (default) or Binary image `bw`             |
| **color_precision** (1–8)                             | Number of significant bits to use in an RGB channel                 |
| **corner_threshold** (0–180)                          | Minimum momentary angle (degree) to be considered a corner          |
| **filter_speckle** (0–16)                             | Discard patches smaller than X px in size                           |
| **layer_difference** (or gradient_step)(0–255)        | Color difference between gradient layers                            |
| **hierarchical** (`"none"`, `"stacked"`)              | Hierarchical clustering `stacked` (default) or non-stacked `cutout`. Only applies to color mode.|
| **mode** (`"spline"`, `"polygon"`, `"none"`)          | Curver fitting mode `pixel`, `polygon`, `spline`                    |
| **path_precision** (integer ≥ 0)                      | Number of decimal places to use in path string                      |
| **length_threshold** (or segment_length)(3.5–10.0)    | Perform iterative subdivide smooth until all segments are shorter than this length|
| **splice_threshold** (0–180)                          | Minimum angle displacement (degree) to splice a spline              |


[Learn more](https://github.com/visioncortex/vtracer)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OlegSavinov/vtracer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/OlegSavinov/vtracer/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Vtracer project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/OlegSavinov/vtracer/blob/main/CODE_OF_CONDUCT.md).
