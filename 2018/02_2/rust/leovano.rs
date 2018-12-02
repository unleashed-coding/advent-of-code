use std::env;
use std::fs::File;
use std::io::{BufRead, BufReader};

fn is_ids(lhs: &str, rhs: &str) -> bool {
    lhs.chars()
        .zip(rhs.chars())
        .filter(|(c1, c2)| c1 != c2)
        .count()
        == 1
}

fn get_id(lhs: &str, rhs: &str) -> String {
    lhs.chars()
        .zip(rhs.chars())
        .filter(|(c1, c2)| c1 == c2)
        .map(|(c, _)| c)
        .collect()
}

fn find_id<T: AsRef<str>>(ids: &[T]) -> Option<String> {
    for id1 in ids {
        let id1 = id1.as_ref();
        for id2 in ids {
            let id2 = id2.as_ref();
            if is_ids(id1, id2) {
                return Some(get_id(id1, id2));
            }
        }
    }

    None
}

fn main() {
    let file = env::args().nth(1).expect("Arg1");
    let file = File::open(file).expect("FileFail");
    let file = BufReader::new(file)
        .lines()
        .collect::<Result<Vec<_>, _>>()
        .expect("ParseFail");

    println!("{:?}", find_id(&file));
}
