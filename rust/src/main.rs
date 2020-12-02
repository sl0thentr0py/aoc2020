use std::io::prelude::*;
use std::fs::File;
use std::io::BufReader;

use itertools::Itertools;

fn main() {
    let f = File::open("../files/01.input").unwrap();

    let lines: Vec<i32> = BufReader::new(f).
        lines().
        map(|l| l.unwrap().parse::<i32>().unwrap()).
        collect();

    let ans1 = lines.iter().combinations(2).
        find(|c| c[0] + c[1] == 2020).unwrap().
        iter().
        fold(1, |x, &y| x * y);

    println!("{}", "=".repeat(20));
    println!("{:?}", ans1);

    let ans2 = lines.iter().combinations(3).
        find(|c| c[0] + c[1] + c[2] == 2020).unwrap().
        iter().
        fold(1, |x, &y| x * y);

    println!("{}", "=".repeat(20));
    println!("{:?}", ans2);
}
