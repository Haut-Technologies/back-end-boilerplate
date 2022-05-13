use super::context::Context;
use juniper::graphql_object;

pub struct Query;

#[graphql_object(context = Context)]
impl Query {
    fn dummy() -> bool {
        unimplemented!();
    }
}
