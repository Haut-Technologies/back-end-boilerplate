use warp::Filter;

mod filters;

#[tokio::main]
async fn main() {
    env_logger::Builder::from_env(env_logger::Env::default().filter_or("LOG", "info")).init();

    let pool = db_client::connect()
        .await
        .expect("Failed to connect to database.");

    let api = filters::app_api(pool.clone());
    let api = warp::path("api").and(api).boxed();
    let graphiql = warp::path("graphiql")
        .and(juniper_warp::graphiql_filter("/api", None))
        .boxed();

    warp::serve(api.or(graphiql).with(warp::log("http")))
        .run(([0, 0, 0, 0], 3030))
        .await;
}
