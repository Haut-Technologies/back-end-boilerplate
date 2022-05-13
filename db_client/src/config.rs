use dotenv::var;

fn leak_str(value: String) -> &'static str {
    Box::leak(value.into_boxed_str())
}

lazy_static! {
    /// Postgresql database URL.
    pub static ref DATABASE_URL: &'static str = leak_str(var("DATABASE_URL")
        .expect("Environment variable `DATABASE_URL` is missing"));
}
