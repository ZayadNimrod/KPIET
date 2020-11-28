use image;
use std::fs::File;
use std::env;

use image::{GenericImageView, Pixel};
use std::io::{Write};


fn write(out: &mut File, to_write: &str) {
    out.write_all(to_write.as_bytes()).expect("Couldn't write to file");
}

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() != 3 {
        print!("Needs exactly two arguments; <input_file> <output_file>");
    }
    let input_filename = args[1].clone();
    let output_filename = args[2].clone();

    let img = image::open(&input_filename).expect("couldn't open image");

    let (width, height) = img.dimensions();


    let mut out = File::create(&output_filename).expect("couldn't create file:");

    let header = format!("{};{};\n", width, height);
    //write(&mut out, &header);


    for y in 0..height {
        for x in 0..width - 1 {
            let pixel = img.get_pixel(x, y);
            //decode the pixel to a hex
            if x != 0 {
                write(&mut out, " ");
            }
            let rgb = pixel.to_rgb();
            let hex = format!("x{:02x}{:02x}{:02x}", rgb[0], rgb[1], rgb[1]);
            write(&mut out, &hex);
        }

        write(&mut out, " ;\n");
    }

    println!("Image encoded, operation complete");
}




