# frozen_string_literal: true

require_relative "vtracer/version"
require_relative "vtracer/vtracer"

module Vtracer
  class Error < StandardError; end
  class ParameterError < StandardError; end

  VALID_COLORMODES = %w[color bw]
  VALID_HIERARCHICAL = %w[stacked cutout]
  VALID_MODES = %w[pixel polygon spline]

  def self.convert_image_to_svg(input,
                                output,
                                colormode: "color",
                                hierarchical: "stacked",
                                mode: "spline",
                                filter_speckle: 10,
                                color_precision: 8,
                                layer_difference: 48,
                                corner_threshold: 180,
                                length_threshold: 4.0,
                                max_iterations: 10,
                                splice_threshold: 45,
                                path_precision: nil)
    errors = []

    errors << "Input file not found: #{input}" unless File.exist?(input)
    errors << "Output file must have .svg extension" unless File.extname(output) == ".svg"

    unless VALID_COLORMODES.include?(colormode.to_s.downcase)
      errors << "colormode must be one of #{VALID_COLORMODES.join(", ")}"
    end
    unless VALID_HIERARCHICAL.include?(hierarchical.to_s.downcase)
      errors << "hierarchical must be one of #{VALID_HIERARCHICAL.join(", ")}"
    end
    errors << "mode must be one of #{VALID_MODES.join(", ")}" unless VALID_MODES.include?(mode.to_s.downcase)

    errors << "filter_speckle must be 0..16" unless (0..16).include?(filter_speckle)
    errors << "color_precision must be 1..8" unless (1..8).include?(color_precision)
    errors << "layer_difference must be 0..255" unless (0..255).include?(layer_difference)
    errors << "corner_threshold must be 0..180" unless (0..180).include?(corner_threshold)
    errors << "length_threshold must be 3.5..10.0" unless (3.5..10.0).include?(length_threshold)
    errors << "splice_threshold must be 0..180" unless (0..180).include?(splice_threshold)
    if path_precision && !(path_precision.is_a?(Integer) && path_precision >= 0)
      errors << "path_precision must be a non-negative integer"
    end

    raise ParameterError, errors.join(";\n") unless errors.empty?

    img_to_svg(input, output, colormode, hierarchical, mode, filter_speckle, color_precision, layer_difference,
               corner_threshold, length_threshold, max_iterations, splice_threshold, path_precision)
  end
end
