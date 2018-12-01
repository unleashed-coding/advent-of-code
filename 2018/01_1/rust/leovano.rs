use std::{env, fs};

fn main() {
    let file = env::args().nth(1).expect("Arg1");
    let file = fs::read_to_string(file).expect("FileFail");

    let freq = file
        .split_whitespace()
        .fold(0, |acc, it| acc + it.parse::<i64>().expect("ParseFail"));

    println!("{}", freq);
}
