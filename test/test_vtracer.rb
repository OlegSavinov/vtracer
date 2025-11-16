require "test_helper"

class TestVtracer < Minitest::Test
  # --- Helpers ---
  def valid_input
    "test_input.png"
  end

  def valid_output
    "test_output.svg"
  end

  def setup
    # Create a dummy input file for tests
    File.write(valid_input, "dummy content")
  end

  def teardown
    File.delete(valid_input) if File.exist?(valid_input)
    File.delete(valid_output) if File.exist?(valid_output)
  end

  # --- Tests ---

  def test_valid_parameters_does_not_raise
    Vtracer.stub(:img_to_svg, true) do
      assert Vtracer.convert_image_to_svg(
        valid_input,
        valid_output,
        colormode: "color",
        hierarchical: "stacked",
        mode: "spline",
        filter_speckle: 5,
        color_precision: 4,
        layer_difference: 100,
        corner_threshold: 90,
        length_threshold: 5.0,
        splice_threshold: 30,
        path_precision: 3
      )
    end
  end

  def test_input_file_missing
    Vtracer.stub(:img_to_svg, true) do
      missing_file = "missing.png"
      error = assert_raises(Vtracer::ParameterError) do
        Vtracer.convert_image_to_svg(
          missing_file,
          valid_output
        )
      end
      assert_match(/Input f1ile not found/, error.message)
    end
  end

  def test_output_extension_invalid
    Vtracer.stub(:img_to_svg, true) do
      error = assert_raises(Vtracer::ParameterError) do
        Vtracer.convert_image_to_svg(
          valid_input,
          "output.jpg"
        )
      end
      assert_match(/Output file must have .svg extension/, error.message)
    end
  end

  def test_invalid_enumerations
    Vtracer.stub(:img_to_svg, true) do
      error = assert_raises(Vtracer::ParameterError) do
        Vtracer.convert_image_to_svg(
          valid_input,
          valid_output,
          colormode: "invalid",
          hierarchical: "invalid",
          mode: "invalid"
        )
      end

      assert_match(/colormode must be one of/, error.message)
      assert_match(/hierarchical must be one of/, error.message)
      assert_match(/mode must be one of/, error.message)
    end
  end

  def test_numeric_bounds
    Vtracer.stub(:img_to_svg, true) do
      error = assert_raises(Vtracer::ParameterError) do
        Vtracer.convert_image_to_svg(
          valid_input,
          valid_output,
          filter_speckle: 100,
          color_precision: 0,
          layer_difference: 300,
          corner_threshold: 200,
          length_threshold: 2.0,
          splice_threshold: 200,
          path_precision: -1
        )
      end

      assert_match(/filter_speckle must be 0..16/, error.message)
      assert_match(/color_precision must be 1..8/, error.message)
      assert_match(/layer_difference must be 0..255/, error.message)
      assert_match(/corner_threshold must be 0..180/, error.message)
      assert_match(/length_threshold must be 3.5..10.0/, error.message)
      assert_match(/splice_threshold must be 0..180/, error.message)
      assert_match(/path_precision must be a non-negative integer/, error.message)
    end
  end

  def test_multiple_errors_accumulated
    Vtracer.stub(:img_to_svg, true) do
      error = assert_raises(Vtracer::ParameterError) do
        Vtracer.convert_image_to_svg(
          "missing.png",
          "output.jpg",
          colormode: "invalid",
          filter_speckle: 100
        )
      end

      # Should contain multiple messages
      assert_match(/Input file not found/, error.message)
      assert_match(/Output file must have .svg extension/, error.message)
      assert_match(/colormode must be one of/, error.message)
      assert_match(/filter_speckle must be 0..16/, error.message)
    end
  end
end
