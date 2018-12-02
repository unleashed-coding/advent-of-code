use std::collections::HashMap;
use std::env;
use std::fs::File;
use std::io::{BufRead, BufReader};

fn do_count<T: AsRef<str>>(ids: &[T]) -> (u64, u64) {
    let mut h = HashMap::new();
    let mut counter = (0u64, 0u64);

    for id in ids {
        h.clear();
        for c in id.as_ref().chars() {
            *h.entry(c).or_insert(0) += 1;
        }

        if h.iter().any(|(_, v)| *v == 2) {
            counter.0 += 1;
        }

        if h.iter().any(|(_, v)| *v == 3) {
            counter.1 += 1;
        }
    }

    counter
}

fn main() {
    let file = env::args().nth(1).expect("Arg1");
    let file = File::open(file).expect("FileFail");
    let file = BufReader::new(file)
        .lines()
        .collect::<Result<Vec<_>, _>>()
        .expect("ParseFail");

    let (a, b) = do_count(file.as_slice());

    println!("{}", a * b);
}
