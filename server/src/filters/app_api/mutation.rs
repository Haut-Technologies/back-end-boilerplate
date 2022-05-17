use super::context::Context;
use juniper::graphql_object;

pub struct Mutation;

#[graphql_object(context = Context)]
impl Mutation {
    fn dummy() -> bool {
        true
    }
}
