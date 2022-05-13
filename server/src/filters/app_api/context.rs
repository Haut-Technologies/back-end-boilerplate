use db_client;
use shrinkwraprs::Shrinkwrap;

#[derive(Shrinkwrap)]
pub struct Context(pub db_client::Context);

impl juniper::Context for Context {}
