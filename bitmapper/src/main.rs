use image;

use std::env;
use std::path::Path;

use image::{GenericImageView, Pixel};


fn main() {
    let args: Vec<String> = env::args().collect();

    //we need one argument; the input image
    let input_filename = args[1].clone();

    let img = image::open(&Path::new(&input_filename)).unwrap();

    let (width, height) = img.dimensions();
    println!("{}", width);
    println!("{}", height);

    for x in 0..width - 1 {
        for y in 0..height {
            let pixel = img.get_pixel(x, y);
            //decode the pixel to a hex
            if y != 0 {
                print!(",");
            }
            print!("{:?}", pixel.to_rgb());
        }
        println!(";");
    }
}




