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

Options:

| Option                                          | Description                                                         |
| ----------------------------------------------- | ------------------------------------------------------------------- |
| **colormode** (`"color"`, `"binary"`)           | Defines how colors are interpreted during tracing.                  |
| **hierarchical** (`"none"`, `"stacked"`)        | Enables layered tracing output when using color mode.               |
| **mode** (`"spline"`, `"polygon"`, `"none"`)    | Chooses the path type for traced shapes.                            |
| **filter_speckle** (0–16)                       | Removes small isolated pixel clusters (noise reduction).            |
| **color_precision** (1–8)                       | Controls color quantization accuracy. Higher = more colors.         |
| **layer_difference** (0–255)                    | Minimum color difference before a new layer is created.             |
| **corner_threshold** (0–180)                    | Angular threshold for detecting corners in shapes.                  |
| **length_threshold** (3.5–10.0)                 | Minimum curve length for spline simplification.                     |
| **splice_threshold** (0–180)                    | Angle threshold used when merging segments.                         |
| **path_precision** (integer ≥ 0)                | Controls the detail level of generated paths. Higher = more points. |


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
