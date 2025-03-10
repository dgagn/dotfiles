use std::{
    env,
    path::{Path, PathBuf},
};

use clap::Parser;
use colored::Colorize;

#[derive(Parser, Debug)]
struct Args {
    components: Vec<String>,
    #[arg(short, long)]
    verbose: bool,
}

fn main() {
    let args = Args::parse();

    let home = PathBuf::from(env::var("HOME").expect("home should be defined"));
    let dotfiles_dir = env::var("DOTFILES_DIR")
        .unwrap_or_else(|_| home.join("dotfiles").to_string_lossy().to_string());
    let dotfiles_dir = PathBuf::from(dotfiles_dir);
    let config_dir = get_xdg_config_home();

    for component in args.components {
        if component == "install" || component == "bin" || component == "share" {
            continue;
        }

        let source = dotfiles_dir.join(&component);
        let target = config_dir.join(&component);

        let is_symlink = target
            .symlink_metadata()
            .map(|m| m.file_type().is_symlink())
            .unwrap_or_default();

        if args.verbose {
            println!(
                "{} install component {} from {} to {}",
                "INFO".blue(),
                component,
                source.display(),
                target.display()
            );
        }

        if target.exists() || is_symlink {
            if args.verbose {
                println!(
                    "{} {} because installed at {}",
                    "SKIP".yellow(),
                    component,
                    target.display()
                );
            }
        } else {
            match std::os::unix::fs::symlink(&source, &target) {
                Ok(_) => {
                    println!("{} {} to {}", "OK".green(), component, target.display());
                }
                Err(e) => eprintln!("{} failed {} because {}", "ERROR".red(), component, e),
            }
        }
    }
}

fn get_xdg_config_home() -> PathBuf {
    if let Ok(dir) = env::var("XDG_CONFIG_HOME") {
        PathBuf::from(dir)
    } else {
        let home = env::var("HOME").expect("coult not get $HOME directory");
        Path::new(&home).join(".config")
    }
}
