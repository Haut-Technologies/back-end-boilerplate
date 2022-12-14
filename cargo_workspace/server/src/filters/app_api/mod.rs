use db_client::{self, Pool};
use juniper::{EmptySubscription, RootNode};
use warp::{filters::BoxedFilter, Filter};

mod context;
mod mutation;
mod query;
use context::Context;
use mutation::Mutation;
use query::Query;

type Schema = RootNode<'static, Query, Mutation, EmptySubscription<Context>>;

/// User graphql api endpoint, serves the app(s).
pub fn app_api(pl: Pool) -> BoxedFilter<(impl warp::Reply,)> {
    let context = warp::any().map(move || Context(db_client::Context::new(pl.clone())));
    let schema = Schema::new(Query, Mutation, EmptySubscription::<Context>::new());
    juniper_warp::make_graphql_filter(schema, context.boxed())
}
