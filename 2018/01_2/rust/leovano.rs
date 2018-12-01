use std::collections::HashSet;
use std::{env, fs};

fn get_frequency_twice(ints: &[i64]) -> i64 {
    let mut v = 0;
    let mut h = HashSet::new();
    
    loop {
        for num in ints {
            v += num;
            if h.contains(&v) {
                return v;
            } else {
                h.insert(v);
            }
        }
    }
}

fn main() {
    let file = env::args().nth(1).expect("Arg1");
    let file = fs::read_to_string(file).expect("FileFail");

    let ints = file
        .split_whitespace()
        .map(|it| it.parse::<i64>().expect("ParseFail"))
        .collect::<Vec<_>>();

    println!("{}", get_frequency_twice(ints.as_slice()));
}
