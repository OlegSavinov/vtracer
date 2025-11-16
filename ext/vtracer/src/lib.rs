use magnus::{function, prelude::*, Error, Ruby};
use std::path::Path;
use vtracer::{convert_image_to_svg, Config, Hierarchical, ColorMode};
use visioncortex::PathSimplifyMode;

fn img_to_svg_rs(
    input: String,
    output: String,
    colormode: Option<String>,
    hierarchical: Option<String>,
    mode: Option<String>,
    filter_speckle: Option<usize>,
    color_precision: Option<i32>,
    layer_difference: Option<i32>,
    corner_threshold: Option<i32>,
    length_threshold: Option<f64>,
    max_iterations: Option<usize>,
    splice_threshold: Option<i32>,
    path_precision: Option<u32>,
) -> String {
    let input_path = Path::new(&input);
    let output_path = Path::new(&output);
    let config = construct_config(
        colormode, hierarchical, mode, filter_speckle, color_precision, layer_difference, corner_threshold, length_threshold, max_iterations, splice_threshold, path_precision);

    let result = convert_image_to_svg(&input_path, &output_path, config);
    match result {
        Ok(()) => {
            format!("Success!")
        },
        Err(msg) => {
            panic!("Conversion failed with error message: {}", msg);
        }
    }
}

fn construct_config(
    colormode: Option<String>,
    hierarchical: Option<String>,
    mode: Option<String>,
    filter_speckle: Option<usize>,
    color_precision: Option<i32>,
    layer_difference: Option<i32>,
    corner_threshold: Option<i32>,
    length_threshold: Option<f64>,
    max_iterations: Option<usize>,
    splice_threshold: Option<i32>,
    path_precision: Option<u32>,
) -> Config {
    let color_mode = match colormode.as_deref().unwrap_or("color") {
        "color" => ColorMode::Color,
        "binary" => ColorMode::Binary,
        _ => ColorMode::Color,
    };

    let hierarchical = match hierarchical.as_deref().unwrap_or("stacked") {
        "stacked" => Hierarchical::Stacked,
        "cutout" => Hierarchical::Cutout,
        _ => Hierarchical::Stacked,
    };

    let mode = match mode.as_deref().unwrap_or("spline") {
        "spline" => PathSimplifyMode::Spline,
        "polygon" => PathSimplifyMode::Polygon,
        "none" => PathSimplifyMode::None,
        _ => PathSimplifyMode::Spline,
    };

    let filter_speckle = filter_speckle.unwrap_or(4);
    let color_precision = color_precision.unwrap_or(6);
    let layer_difference = layer_difference.unwrap_or(16);
    let corner_threshold = corner_threshold.unwrap_or(60);
    let length_threshold = length_threshold.unwrap_or(4.0);
    let splice_threshold = splice_threshold.unwrap_or(45);
    let max_iterations = max_iterations.unwrap_or(10);

    Config {
        color_mode,
        hierarchical,
        filter_speckle,
        color_precision,
        layer_difference,
        mode,
        corner_threshold,
        length_threshold,
        max_iterations,
        splice_threshold,
        path_precision,
        ..Default::default()
    }
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
    let module = ruby.define_module("Vtracer")?;
    module.define_singleton_method("img_to_svg", function!(img_to_svg_rs, 13))?;
    Ok(())
}
